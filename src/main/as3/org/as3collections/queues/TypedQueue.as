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

package org.as3collections.queues {
	import org.as3collections.ICollection;
	import org.as3collections.IQueue;
	import org.as3collections.TypedCollection;
	import org.as3utils.ReflectionUtil;

	/**
	 * <code>TypedQueue</code> works as a wrapper for a queue.
	 * Since ActionScript 3.0 does not support typed arrays, <code>TypedQueue</code> is a way to create typed queues.
	 * It stores the <code>wrapQueue</code> constructor's argument in the <code>wrappedQueue</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedQueue</code> object.
	 * The methods that need to be checked for the type of the elements are previously validated with the <code>validateType</code> or <code>validateCollection</code> method before forward the call.
	 * If the type of an element requested to be added to this list is incompatible with the type of the list, the method <code>offer</code> returns <code>false</code> and the method <code>add</code> throws <code>org.as3coreaddendum.errors.ClassCastError</code>.
	 * The calls that are forwarded to the <code>wrappedQueue</code> returns the return of the <code>wrappedQueue</code> call.
	 * <p><code>TypedQueue</code> does not allow <code>null</code> elements.</p>
	 * <p>You can also create unique and typed queues. See below the link "QueueUtil.getUniqueTypedQueue()".</p>
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
	 * var queue1:IQueue = new TypedQueue(q1, int); // you can use this way
	 * 
	 * //var queue1:IQueue = QueueUtil.getTypedQueue(q1); // or you can use this way
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
	 * @see org.as3collections.utils.QueueUtil#getTypedQueue() QueueUtil.getTypedQueue()
	 * @see org.as3collections.utils.QueueUtil#getUniqueTypedQueue() QueueUtil.getUniqueTypedQueue()
	 * @author Flávio Silva
	 */
	public class TypedQueue extends TypedCollection implements IQueue
	{
		/**
		 * @private
		 */
		protected function get wrappedQueue(): IQueue { return wrappedCollection as IQueue; }

		/**
		 * Constructor, creates a new <code>TypedQueue</code> object.
		 * 
		 * @param 	wrapQueue 	the target queue to wrap.
		 * @param 	type 		the type of the elements allowed by this queue.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapQueue</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapQueue</code> argument are incompatible with the <code>type</code> argument.
		 */
		public function TypedQueue(wrapQueue:IQueue, type:*)
		{
			super(wrapQueue, type);
		}

		/**
		 * Creates and return a new <code>TypedQueue</code> object with the clone of the <code>wrappedQueue</code> object.
		 * 
		 * @return 	a new <code>TypedQueue</code> object with the clone of the <code>wrappedQueue</code> object.
 		 */
		override public function clone(): *
		{
			return new TypedQueue(wrappedQueue.clone(), type);
		}

		/**
		 * Forwards the call to <code>wrappedQueue.dequeue</code>.
		 * 
		 * @return 	the return of the call <code>wrappedQueue.dequeue</code>.
		 */
		public function dequeue(): *
		{
			return wrappedQueue.dequeue();
		}

		/**
		 * Forwards the call to <code>wrappedQueue.element</code>.
		 * 
		 * @return 	the return of the call <code>wrappedQueue.element</code>.
		 */
		public function element(): *
		{
			return wrappedQueue.element();
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the elements in the queue.
		 * So, for two collections are equal the order of elements returned by the iterator must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var c:ICollection = other as ICollection;
			
			if (c == null || c.size() != size()) return false;
			
			return wrappedQueue.equals(c);
		}

		/**
		 * If <code>isValidType(element)</code> returns <code>false</code> then returns <code>false</code>.
		 * Otherwise, it forwards the call to <code>wrappedQueue.offer</code>.
		 * 
		 * @param  	element 	the element to forward to <code>wrappedQueue.offer</code>.
		 * @return 	<code>false</code> if <code>isValidType(element)</code> returns <code>false</code>. Otherwise returns the return of the call <code>wrappedQueue.offer</code>.
		 */
		public function offer(element:*): Boolean
		{
			if (!isValidType(element)) return false;
			return wrappedQueue.offer(element);
		}

		/**
		 * Forwards the call to <code>wrappedQueue.peek</code>.
		 * 
		 * @return 	the return of the call <code>wrappedQueue.peek</code>.
		 */
		public function peek(): *
		{
			return wrappedQueue.peek();
		}

		/**
		 * Forwards the call to <code>wrappedQueue.poll</code>.
		 * 
		 * @return 	the return of the call <code>wrappedQueue.poll</code>.
		 */
		public function poll(): *
		{
			return wrappedQueue.poll();
		}

	}

}