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
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.lists.ArrayList;
	import org.as3coreaddendum.errors.ClassCastError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.system.IPriority;
	import org.as3coreaddendum.system.comparators.PriorityComparator;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This queue uses a <code>org.as3coreaddendum.system.comparators.PriorityComparator</code> object to sort the elements.
	 * All elements must implement the <code>org.as3coreaddendum.system.IPriority</code> interface, otherwise a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * package test
	 * {
	 *     import org.as3coreaddendum.system.IPriority;
	 * 
	 *     public class TestPriority implements IPriority
	 *     {
	 *         private var _name:String;
	 *         private var _priority:int;
	 * 
	 *         public function get priority(): int { return _priority; }
	 * 
	 *         public function set priority(value:int): void { _priority = value; }
	 * 
	 *         public function TestPriority(name:String, priority:int)
	 *         {
	 *             _name = name;
	 *             _priority = priority;
	 *         }
	 * 
	 *         public function toString(): String
	 *         {
	 *             return "[TestPriority " + _name + "]";
	 *         }
	 *     }
	 * }
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedQueue;
	 * import org.as3collections.queues.PriorityQueue;
	 * import test.TestPriority;
	 * 
	 * var queue1:ISortedQueue = new PriorityQueue();
	 * 
	 * var o1:TestPriority = new TestPriority("o1", 1);
	 * var o2:TestPriority = new TestPriority("o2", 2);
	 * var o3:TestPriority = new TestPriority("o3", 3);
	 * var o4:TestPriority = new TestPriority("o4", 4);
	 * 
	 * queue1.offer(o2)            // true
	 * queue1                      // [[TestPriority o2]]
	 * queue1.size()               // 1
	 * 
	 * queue1.offer(o3)            // true
	 * queue1                      // [[TestPriority o3],[TestPriority o2]]
	 * queue1.size()               // 2
	 * 
	 * queue1.offer(o2)            // true
	 * queue1                      // [[TestPriority o3],[TestPriority o2],[TestPriority o2]]
	 * 
	 * queue1.offer(o1)            // true
	 * queue1                      // [[TestPriority o3],[TestPriority o2],[TestPriority o2],[TestPriority o1]]
	 * 
	 * queue1.offer(o4)            // true
	 * queue1                      // [[TestPriority o4],[TestPriority o3],[TestPriority o2],[TestPriority o2],[TestPriority o1]]
	 * 
	 * queue1.offer(1)             // false
	 * queue1                      // [[TestPriority o4],[TestPriority o3],[TestPriority o2],[TestPriority o2],[TestPriority o1]]
	 * 
	 * queue1.add(1)               // ClassCastError: The element must implement the 'org.as3coreaddendum.system.IPriority' interface. Type received: int
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class PriorityQueue extends SortedQueue
	{
		/**
		 * Constructor, creates a new <code>PriorityQueue</code> object.
		 * 
		 * @param 	source 		an array to fill the queue.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if one or more elements in the <code>source</code> argument do not implement the <code>org.as3coreaddendum.system.IPriority</code> interface.
		 */
		public function PriorityQueue(source:Array = null): void
		{
			validateCollection(new ArrayList(source));
			
			super(source, new PriorityComparator());
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * This method differs from <code>offer</code> only in that it throws an error if the element cannot be inserted.
		 * <p>This implementation returns the result of <code>offer</code> unless the element cannot be inserted.</p>
		 * <p>This implementation only allow elements that implements the <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * A <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown if the element does not implements this interface.</p>
		 * 
		 * @param element
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the element does not implements the <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * @throws 	flash.errors.IllegalOperationError  			if the specified element cannot be inserted.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function add(element:*): Boolean
		{
			if (element == null) throw new NullPointerError("The 'element' argument must not be 'null'.");
			validateElement(element);
			
			var b:Boolean = offer(element);
			
			if (!b) throw new IllegalOperationError("The element cannot be inserted: " + element);
			
			return b;
		}

		/**
		 * Creates and return a new <code>PriorityQueue</code> object containing all elements in this queue (in the same order).
		 * 
		 * @return 	a new <code>PriorityQueue</code> object containing all elements in this queue (in the same order).
 		 */
		override public function clone(): *
		{
			var q:PriorityQueue = new PriorityQueue(data);
			q.comparator = comparator;
			q.options = options;
			
			return q;
		}
		
		/**
		 * Returns <code>true</code> if all elements of the <code>collection</code> argument implement <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * 
		 * @param  	collection 	the collection to check.
		 * @return 	<code>true</code> if all elements of the <code>collection</code> argument implement <code>org.as3coreaddendum.system.IPriority</code> interface.
		 */
		public function isValidCollection(collection:ICollection): Boolean
		{
			if (!collection) return false;
			if (collection.isEmpty()) return true;
			//TODO: pensar sobre migrar esse método para CollectionUtil
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (!isValidType(it.next())) return false;
			}
			
			return true;
		}

		/**
		 * Returns <code>true</code> if the element implement <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * 
		 * @param  	element 	the element to check.
		 * @return 	<code>true</code> if the element implement <code>org.as3coreaddendum.system.IPriority</code> interface.
		 */
		public function isValidType(element:*): Boolean
		{
			return element is IPriority;
		}
		
		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * <p>This implementation only allow elements that implements the <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * If the element does not implements this interface the method returns <code>false</code>.</p>
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @param  	element 	the element to add.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		override public function offer(element:*): Boolean
		{
			if (element == null || !(element is IPriority)) return false;
			
			return super.offer(element);
		}
		
		/**
		 * Checks if all elements of the <code>collection</code> argument implements <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * 
		 * @param  	collection 	the collection to check.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if one or more elements in the <code>collection</code> argument do not implement the <code>org.as3coreaddendum.system.IPriority</code> interface. 	
		 */
		public function validateCollection(collection:ICollection): void
		{
			if (!collection) return;
			if (collection.isEmpty()) return;
			//TODO: pensar sobre migrar esse método para CollectionUtil
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				validateElement(it.next());
			}
		}

		/**
		 * Checks if the element implements <code>org.as3coreaddendum.system.IPriority</code> interface.
		 * 
		 * @param  	element 	the element to check.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the <code>element</code> argument do not implement the <code>org.as3coreaddendum.system.IPriority</code> interface.
		 */
		public function validateElement(element:*): void
		{
			if (!isValidType(element)) throw new ClassCastError("The element must implement the 'org.as3coreaddendum.system.IPriority' interface. Type received: " + ReflectionUtil.getClassPath(element));
		}

	}

}