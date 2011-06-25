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

package org.as3collections.queues 
{
	import org.as3collections.IQueue;
	import org.as3collections.UniqueCollection;
	import org.as3collections.utils.CollectionUtil;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * <code>UniqueQueue</code> works as a wrapper for a queue.
	 * It does not allow duplicated elements in the queue.
	 * It stores the <code>wrapQueue</code> constructor's argument in the <code>wrappedQueue</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedQueue</code> object.
	 * The methods that need to be checked for duplication are previously validated before forward the call.
	 * The calls that are forwarded to the <code>wrappedQueue</code> returns the return of the <code>wrappedQueue</code> call.
	 * <p>You can also create unique and typed queues. See below the link "QueueUtil.getUniqueTypedQueue()".</p>
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
	 * @see org.as3collections.utils.QueueUtil#getUniqueQueue() QueueUtil.getUniqueQueue()
	 * @see org.as3collections.utils.QueueUtil#getUniqueTypedQueue() QueueUtil.getUniqueTypedQueue()
	 * @author Flávio Silva
	 */
	public class UniqueQueue extends UniqueCollection implements IQueue
	{
		/**
		 * @private
		 */
		protected function get wrappedQueue(): IQueue { return wrappedCollection as IQueue; }

		/**
		 * Constructor, creates a new <code>UniqueQueue</code> object.
		 * 
		 * @param 	wrapQueue 	the target queue to wrap.
		 * @throws 	ArgumentError  	if the <code>wrapQueue</code> argument is <code>null</code>.
		 */
		public function UniqueQueue(wrapQueue:IQueue)
		{
			super(wrapQueue);
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * This method differs from <code>offer</code> only in that it throws an error if the element cannot be inserted.
		 * <p>This implementation returns the result of <code>offer</code> unless the element cannot be inserted.</p>
		 * <p>If <code>wrappedQueue.contains(element)</code> returns <code>true</code> an <code>IllegalOperationError</code> is thrown.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	ArgumentError  	if the specified element is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element prevents it from being added to this queue.
		 * @throws 	flash.errors.IllegalOperationError  			if <code>wrappedQueue.contains(element)</code> returns <code>true</code>.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function add(element:*): Boolean
		{
			if (wrappedQueue.contains(element)) throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is a unique queue and does not allow duplicated elements. Requested element: " + element);
			return super.add(element);
		}

		/**
		 * Creates and return a new <code>UniqueQueue</code> object with the clone of the <code>wrappedQueue</code> object.
		 * 
		 * @return 	a new <code>UniqueQueue</code> object with the clone of the <code>wrappedQueue</code> object.
 		 */
		override public function clone(): *
		{
			return new UniqueQueue(wrappedQueue.clone());
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
		 * This method uses <code>CollectionUtil.equalConsideringOrder</code> method to perform equality, sending this list and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalConsideringOrder() CollectionUtil.equalConsideringOrder()
		 */
		override public function equals(other:*): Boolean
		{
			return CollectionUtil.equalConsideringOrder(this, other);
		}

		/**
		 * If <code>wrappedQueue.contains(element)</code> returns <code>true</code> then returns <code>false</code>.
		 * Otherwise, it forwards the call to <code>wrappedQueue.offer</code>.
		 * 
		 * @param  	element 	the element to forward to <code>wrappedQueue.offer</code>.
		 * @return 	<code>false</code> if <code>wrappedQueue.contains(element)</code> returns <code>true</code>. Otherwise returns the return of the call <code>wrappedQueue.offer</code>.
		 */
		public function offer(element:*): Boolean
		{
			if (wrappedQueue.contains(element)) return false;
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