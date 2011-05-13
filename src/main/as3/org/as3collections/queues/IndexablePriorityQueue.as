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
	import org.as3coreaddendum.errors.ClassCastError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.system.IIndexable;
	import org.as3coreaddendum.system.IPriority;
	import org.as3coreaddendum.system.comparators.IndexablePriorityComparator;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This queue uses an <code>org.as3coreaddendum.system.comparators.IndexablePriorityComparator</code> object to sort the elements.
	 * All elements must implement the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces, otherwise a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * <p>This queue is util when you want to sort the objects by priority, but if the priority of two objects are equal, the <code>index</code> property of the objects are compared to decide wich object comes before.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * package test
	 * {
	 *     import org.as3coreaddendum.system.IIndexable;
	 *     import org.as3coreaddendum.system.IPriority;
	 * 
	 *     public class TestIndexablePriority implements IIndexable, IPriority
	 *     {
	 *         private var _index:int;
	 *         private var _name:String;
	 *         private var _priority:int;
	 * 
	 * 
	 *         public function get priority(): int { return _priority; }
	 * 
	 *         public function set priority(value:int): void { _priority = value; }
	 * 
	 *         public function get index(): int { return _index; }
	 * 
	 *         public function set index(value:int): void { _index = value; }
	 * 
	 *         public function TestIndexablePriority(name:String, priority:int, index:int)
	 *         {
	 *             _name = name;
	 *             _priority = priority;
	 *             _index = index;
	 *         }
	 * 
	 *         public function toString(): String
	 *         {
	 *             return "[TestIndexablePriority " + _name + "]";
	 *         }
	 *     }
	 * }
	 * </listing>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedQueue;
	 * import org.as3collections.queues.IndexablePriorityQueue;
	 * import test.TestIndexablePriority;
	 * 
	 * var queue1:ISortedQueue = new IndexablePriorityQueue();
	 * 
	 * var o1:TestIndexablePriority = new TestIndexablePriority("o1", 1, 0);
	 * var o2:TestIndexablePriority = new TestIndexablePriority("o2", 2, 1);
	 * var o3:TestIndexablePriority = new TestIndexablePriority("o3", 2, 2);
	 * var o4:TestIndexablePriority = new TestIndexablePriority("o4", 4, 3);
	 * 
	 * queue1.offer(o2)            // true
	 * queue1                      // [[TestIndexablePriority o2]]
	 * queue1.size()               // 1
	 * 
	 * queue1.offer(o3)            // true
	 * queue1                      // [[TestIndexablePriority o2],[TestIndexablePriority o3]]
	 * queue1.size()               // 2
	 * 
	 * queue1.offer(o2)            // true
	 * queue1                      // [[TestIndexablePriority o2],[TestIndexablePriority o2],[TestIndexablePriority o3]]
	 * 
	 * queue1.offer(o1)            // true
	 * queue1                      // [[TestIndexablePriority o2],[TestIndexablePriority o2],[TestIndexablePriority o3],[TestIndexablePriority o1]]
	 * 
	 * queue1.offer(o4)            // true
	 * queue1                      // [[TestIndexablePriority o4],[TestIndexablePriority o2],[TestIndexablePriority o2],[TestIndexablePriority o3],[TestIndexablePriority o1]]
	 * 
	 * queue1.offer(1)             // false
	 * queue1                      // [[TestIndexablePriority o4],[TestIndexablePriority o2],[TestIndexablePriority o2],[TestIndexablePriority o3],[TestIndexablePriority o1]]
	 * 
	 * queue1.add(1)               // ClassCastError: The element must implement the 'org.as3coreaddendum.system.IPriority' interface. Type received: int
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class IndexablePriorityQueue extends SortedQueue
	{
		/**
		 * Constructor, creates a new <code>IndexablePriorityQueue</code> object.
		 * 
		 * @param 	source 		an array to fill the queue.
		 */
		public function IndexablePriorityQueue(source:Array = null): void
		{
			super(source, new IndexablePriorityComparator());
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * This method differs from <code>offer</code> only in that it throws an error if the element cannot be inserted.
		 * <p>This implementation returns the result of <code>offer</code> unless the element cannot be inserted.</p>
		 * <p>This implementation only allow elements that implements the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 * A <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown if the element does not implements this interfaces.</p>
		 * 
		 * @param element
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the element does not implements the <code>org.as3coreaddendum.system.IPriority</code> or <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 * @throws 	flash.errors.IllegalOperationError  			if the specified element cannot be inserted.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function add(element:*): Boolean
		{
			if (element == null) throw new NullPointerError("The 'element' argument must not be 'null'.");
			if (!(element is IPriority)) throw new ClassCastError("The element must implement the 'org.as3coreaddendum.system.IPriority' interface. Type received: " + ReflectionUtil.getClassPath(element));
			if (!(element is IIndexable)) throw new ClassCastError("The element must implement the 'org.as3coreaddendum.system.IIndexable' interface. Type received: " + ReflectionUtil.getClassPath(element));
			
			var b:Boolean = offer(element);
			
			if (!b) throw new IllegalOperationError("The element cannot be inserted: " + element);
			
			return b;
		}

		/**
		 * Creates and return a new <code>IndexablePriorityQueue</code> object containing all elements in this queue (in the same order).
		 * 
		 * @return 	a new <code>IndexablePriorityQueue</code> object containing all elements in this queue (in the same order).
 		 */
		override public function clone(): *
		{
			var q:IndexablePriorityQueue = new IndexablePriorityQueue(data);
			q.comparator = comparator;
			q.options = options;
			
			return q;
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * <p>This implementation only allow elements that implements the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 * If the element does not implements this interfaces the method returns <code>false</code>.</p>
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @param  	element 	the element to add.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		override public function offer(element:*): Boolean
		{
			if (element == null || !(element is IPriority) || !(element is IIndexable)) return false;
			
			return super.offer(element);
		}

	}

}