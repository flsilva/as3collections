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
	import org.as3collections.TypedCollection;
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.NullPointerError;
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
		 * If the <code>element</code> argument is <code>null</code> throws <code>org.as3coreaddendum.errors.NullPointerError</code>.
		 * Otherwise the element is validated with the <code>validateType</code> method to be forwarded to <code>wrappedCollection.add</code>.
		 * 
		 * @param  	element 	the element to forward to <code>wrappedCollection.add</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>element</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the element is incompatible with the type of this collection.
		 * @return 	the return of the call <code>wrappedCollection.add</code>.
		 */
		override public function add(element:*): Boolean
		{
			if (!element) throw new NullPointerError("The 'element' argument must not be 'null'.");
			return super.add(element);
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
		 * This method first checks if <code>other</code> argument is a <code>TypedQueue</code>.
		 * If not it returns <code>false</code>. If <code>true</code> it checks the <code>type</code> property of both queues.
		 * If they are different it returns <code>false</code>.
		 * Otherwise it uses <code>CollectionUtil.equalConsideringOrder</code> method to perform equality, sending this queue and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalConsideringOrder() CollectionUtil.equalConsideringOrder()
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var otherList:TypedQueue = other as TypedQueue;
			if (type != otherList.type) return false;
			
			return CollectionUtil.equalConsideringOrder(this, other);
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
			if (!isValidElement(element)) return false;
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