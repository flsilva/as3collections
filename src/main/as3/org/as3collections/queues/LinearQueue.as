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
	import org.as3collections.AbstractQueue;
	import org.as3collections.IIterator;
	import org.as3collections.iterators.ArrayIterator;

	/**
	 * <code>LinearQueue</code> orders elements in a FIFO (first-in-first-out) manner.
	 * <p><code>LinearQueue</code> does not allow <code>null</code> elements.</p>
	 * 
	 * @example
	 * 
	 * <b>Example 1</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IQueue;
	 * import org.as3collections.queues.LinearQueue;
	 * 
	 * var queue:IQueue = new LinearQueue();
	 * 
	 * queue                       // []
	 * queue.size()                // 0
	 * queue.isEmpty()             // true
	 * 
	 * queue.peek()                // null
	 * queue.element()             // NoSuchElementError: The queue is empty.
	 * 
	 * queue.offer(3)              // true
	 * queue                       // [3]
	 * queue.size()                // 1
	 * queue.isEmpty()             // false
	 * 
	 * queue.offer("a")            // true
	 * queue                       // [3,a]
	 * 
	 * queue.offer(1)              // true
	 * queue                       // [3,a,1]
	 * 
	 * queue.offer(7)              // true
	 * queue                       // [3,a,1,7]
	 * 
	 * queue.offer(null)           // false
	 * queue.add(null)             // NullPointerError: The 'element' argument must not be 'null'.
	 * queue                       // [3,a,1,7]
	 * 
	 * queue.peek()                // 3
	 * queue.element()             // 3
	 * queue:                      // [3,a,1,7]
	 * 
	 * queue.poll()                // 3
	 * queue                       // [a,1,7]
	 * 
	 * queue.dequeue()             // a
	 * queue                       // [1,7]
	 * 
	 * queue.remove(10)            // false
	 * queue                       // [1,7]
	 * 
	 * queue.remove(7)             // true
	 * queue                       // [1]
	 * 
	 * queue.clear()
	 * queue                       // []
	 * queue.size()                // 0
	 * queue.isEmpty()             // true
	 * 
	 * queue.poll()                // null
	 * queue.dequeue()             // NoSuchElementError: The queue is empty.
	 * </listing>
	 * 
	 * <b>Example 2</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IQueue;
	 * import org.as3collections.queues.LinearQueue;
	 * 
	 * var queue1:IQueue = new LinearQueue([1, 5, 3, 7]);
	 * 
	 * queue1                      // [1,5,3,7]
	 * queue1.size()               // 4
	 * queue1.isEmpty()            // false
	 * 
	 * var queue2:IQueue = queue1.clone();
	 * 
	 * queue2                      // [1,5,3,7]
	 * queue2.size()               // 4
	 * queue2.isEmpty()            // false
	 * 
	 * queue2.equals(queue1)       // true
	 * queue1.equals(queue2)       // true
	 * 
	 * queue2.poll()               // 1
	 * queue2                      // [5,3,7]
	 * 
	 * queue2.equals(queue1)       // false
	 * queue1.equals(queue2)       // false
	 * queue2.equals(queue2)       // true
	 * 
	 * queue1.clear()
	 * queue1                      // []
	 * 
	 * queue2.clear()
	 * queue2:                     // []
	 * 
	 * queue2.equals(queue1)       // true
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class LinearQueue extends AbstractQueue
	{
		/**
		 * Constructor, creates a new <code>LinearQueue</code> object.
		 * 
		 * @param 	source 	an array to fill the queue.
		 */
		public function LinearQueue(source:Array = null)
		{
			super(source);
		}

		/**
		 * Removes all of the elements from this queue. The queue will be empty after this method returns.
		 */
		override public function clear(): void
		{
			if (isEmpty()) return;
			data.splice(0);
			_allEquatable = true;
		}

		/**
		 * Creates and return a new <code>LinearQueue</code> object containing all elements in this queue (in the same order).
		 * 
		 * @return 	a new <code>LinearQueue</code> object containing all elements in this queue (in the same order).
 		 */
		override public function clone(): *
		{
			return new LinearQueue(data);
		}

		/**
		 * Returns an iterator over a set of elements.
		 * <p>This implementation returns an <code>ArrayIterator</code> object.</p>
		 * 
		 * @return 	an iterator over a set of elements.
		 * @see 	org.as3collections.iterators.ArrayIterator ArrayIterator
 		 */
		override public function iterator(): IIterator
		{
			return new ArrayIterator(data);
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * <p>This implementation adds the element to the tail of the queue.</p>
		 * 
		 * @param  	element 	the element to add.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		override public function offer(element:*): Boolean
		{
			if (element == null) return false;
			
			data.push(element);
			checkEquatable(element);
			return true;
		}

		/**
		 * Retrieves, but does not remove, the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * 
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		override public function peek(): *
		{
			if (isEmpty()) return null;
			return data[0];
		}

		/**
		 * Retrieves and removes the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * 
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		override public function poll(): *
		{
			if (isEmpty()) return null;
			
			var e:* = data.shift();
			checkAllEquatable();
			
			return e;
		}

	}

}