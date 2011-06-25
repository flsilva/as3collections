/*
 * Licensed under the MIT License
 * 
 * Copyright 2010 (c) Flávio Silva, http://flsilva.com
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * http://www.opensource.org/licenses/mit-license.php
 */

package org.as3collections.utils
{
	import flash.errors.IllegalOperationError;
	
	import org.as3collections.IQueue;
	import org.as3collections.queues.TypedQueue;
	import org.as3collections.queues.UniqueQueue;

	/**
	 * A utility class to work with implementations of the <code>IQueue</code> interface.
	 * 
	 * @author Flávio Silva
	 */
	public class QueueUtil
	{
		/**
		 * <code>QueueUtil</code> is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	<code>QueueUtil</code> is a static class and shouldn't be instantiated.
		 */
		public function QueueUtil()
		{
			throw new IllegalOperationError("QueueUtil is a static class and shouldn't be instantiated.");
		}

		/**
		 * Returns a new <code>TypedQueue</code> with the <code>wrapList</code> argument wrapped.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IQueue;
		 * import org.as3collections.queues.LinearQueue;
		 * import org.as3collections.queues.TypedQueue;
		 * import org.as3collections.utils.QueueUtil;
		 * 
		 * var q1:IQueue = new LinearQueue([1, 5, 3, 7]);
		 * 
		 * var queue1:IQueue = QueueUtil.getTypedQueue(q1);
		 * 
		 * queue1                      // [1,5,3,7]
		 * queue1.size():              // 4
		 * queue1.isEmpty()            // false
		 * 
		 * queue1.poll()               // 1
		 * queue1                      // [5,3,7]
		 * 
		 * queue1.offer(2)             // true
		 * queue1                      // [5,3,7,2]
		 * 
		 * queue1.offer(5)             // true
		 * queue1                      // [5,3,7,2,5]
		 * 
		 * queue1.offer("a")           // false
		 * queue1                      // [5,3,7,2,5]
		 * 
		 * queue1.add("a")             // ClassCastError: Invalid element type. element: a | type: String | expected type: int
		 * </listing>
		 * 
		 * @param  	wrapQueue 	the target queue to be wrapped by the <code>TypedQueue</code>.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedQueue</code>.
		 * @throws 	ArgumentError  	if the <code>queue</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapQueue</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedQueue</code> with the <code>queue</code> argument wrapped.
		 */
		public static function getTypedQueue(wrapQueue:IQueue, type:*): TypedQueue
		{
			return new TypedQueue(wrapQueue, type);
		}

		/**
		 * Returns a new <code>UniqueQueue</code> with the <code>wrapQueue</code> argument wrapped.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IQueue;
		 * import org.as3collections.queues.LinearQueue;
		 * import org.as3collections.queues.UniqueQueue;
		 * import org.as3collections.utils.QueueUtil;
		 * 
		 * var q1:IQueue = new LinearQueue([1, 5, 3, 7]);
		 * 
		 * var queue1:IQueue = new UniqueQueue(q1); // you can use this way
		 * 
		 * //var queue1:IQueue = QueueUtil.getUniqueQueue(q1); // or you can use this way
		 * 
		 * queue1                      // [1,5,3,7]
		 * queue1.size()               // 4
		 * queue1.isEmpty()            // false
		 * 
		 * queue1.poll()               // 1
		 * queue1                      // [5,3,7]
		 * 
		 * queue1.offer(2)             // true
		 * queue1                      // [5,3,7,2]
		 * 
		 * queue1.offer(5)             // false
		 * queue1                      // [5,3,7,2]
		 * 
		 * queue1.add(5)               // Error: UniqueQueue is a unique queue and does not allow duplicated elements. Requested element: 5
		 * </listing>
		 * 
		 * @param  	wrapQueue 	the target queue to be wrapped by the <code>UniqueQueue</code>.
		 * @throws 	ArgumentError  	if the <code>queue</code> argument is <code>null</code>.
		 * @return 	a new <code>UniqueQueue</code> with the <code>queue</code> argument wrapped.
		 */
		public static function getUniqueQueue(wrapQueue:IQueue): UniqueQueue
		{
			return new UniqueQueue(wrapQueue);
		}

		/**
		 * Returns a new <code>TypedQueue</code> that wraps a new <code>UniqueQueue</code> that wraps the <code>wrapQueue</code> argument.
		 * <p>The result will be a unique and typed array queue, despite of the return type <code>TypedQueue</code>.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IQueue;
		 * import org.as3collections.queues.Queue;
		 * import org.as3collections.queues.TypedQueue;
		 * import org.as3collections.utils.QueueUtil;
		 * 
		 * var q1:IQueue = new LinearQueue([1, 5, 3, 7]);
		 * 
		 * var queue1:IQueue = QueueUtil.getUniqueTypedQueue(q1, int);
		 * 
		 * queue1                  // [1,5,3,7]
		 * queue1.size()           // 4
		 * queue1.isEmpty()        // false
		 * 
		 * queue1.poll()           // 1
		 * queue1                  // [5,3,7]
		 * 
		 * queue1.offer(2)         // true
		 * queue1                  // [5,3,7,2]
		 * 
		 * queue1.offer(5)         // false
		 * queue1                  // [5,3,7,2]
		 * 
		 * queue1.add(5)           // Error: UniqueQueue is a unique queue and does not allow duplicated elements. Requested element: 5
		 * 
		 * queue1.offer("a")       // false
		 * queue1                  // [5,3,7,2]
		 * 
		 * queue1.add("a")         // ClassCastError: Invalid element type. element: a | type: String | expected type: int
		 * </listing>
		 * 
		 * @param  	wrapQueue 	the target queue to be wrapped.
		 * @param  	type 		the type of the elements allowed by the returned <code>TypedQueue</code>.
		 * @throws 	ArgumentError  	if the <code>queue</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapQueue</code> argument are incompatible with the <code>type</code> argument.
		 * @return 	a new <code>TypedQueue</code> with the <code>queue</code> argument wrapped.
		 */
		public static function getUniqueTypedQueue(wrapQueue:IQueue, type:*): TypedQueue
		{
			return new TypedQueue(new UniqueQueue(wrapQueue), type);
		}

	}

}