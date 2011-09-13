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
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.ClassCastError;
	import org.as3coreaddendum.events.IndexEvent;
	import org.as3coreaddendum.events.PriorityEvent;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.IIndexable;
	import org.as3coreaddendum.system.IPriority;
	import org.as3coreaddendum.system.comparators.PriorityIndexComparator;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * This queue uses an <code>org.as3coreaddendum.system.comparators.PriorityIndexComparator</code> object to sort the elements.
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
	public class PriorityIndexQueue extends SortedQueue
	{
		/**
		 * <code>IndexablePriorityQueue</code> does not allow changing its <code>comparator</code> object.
		 * <p><code>IndexablePriorityQueue</code> was designed to be used exclusively with its default comparator object.
		 * If you want to change the comparator object using this setter, consider using <code>SortedQueue</code> class instead.</p>
		 * <p>If this setter is used an <code>IllegalOperationError</code> is thrown.</p>
		 */
		override public function set comparator(value:IComparator): void
		{
			throw new IllegalOperationError("IndexablePriorityQueue does not allow changing its comparator object.\nIf you want to change it consider using SortedQueue class instead.");
		}
		
		/**
		 * <code>IndexablePriorityQueue</code> does not allow changing its options.
		 * <p><code>IndexablePriorityQueue</code> was designed to be used exclusively with its default options.
		 * If you want to change the options using this setter, consider using <code>SortedQueue</code> class instead.</p>
		 * <p>If this setter is used an <code>IllegalOperationError</code> is thrown.</p>
		 */
		override public function set options(value:uint): void
		{
			throw new IllegalOperationError("IndexablePriorityQueue does not allow changing its options.\nIf you want to change it consider using SortedQueue class instead.");
		}
		
		/**
		 * Constructor, creates a new <code>IndexablePriorityQueue</code> object.
		 * 
		 * @param 	source 		an array to fill the queue.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if one or more elements in the <code>source</code> argument do not implement the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 */
		public function PriorityIndexQueue(source:Array = null)
		{
			validateCollection(new ArrayList(source));
			
			super(source, new PriorityIndexComparator());
		}

		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * This method differs from <code>offer</code> only in that it throws an error if the element cannot be inserted.
		 * <p>This implementation returns the result of <code>offer</code> unless the element cannot be inserted.</p>
		 * <p>This implementation only allow elements that implements the <code>org.as3coreaddendum.system.IPriority</code> and <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 * A <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown if the element does not implements this interfaces.</p>
		 * 
		 * @param element
		 * @throws 	ArgumentError  	if the specified element is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the element does not implements the <code>org.as3coreaddendum.system.IPriority</code> or <code>org.as3coreaddendum.system.IIndexable</code> interfaces.
		 * @throws 	flash.errors.IllegalOperationError  			if the specified element cannot be inserted.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function add(element:*): Boolean
		{
			if (element == null) throw new ArgumentError("The 'element' argument must not be 'null'.");
			validateElement(element);
			
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
			var q:PriorityIndexQueue = new PriorityIndexQueue(data);
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
			if (element == null || !isValidElement(element)) return false;
			
			return super.offer(element);
		}
		
		/**
		 * @private
		 */
		protected function isValidElement(element:*): Boolean
		{
			return element is IPriority && element is IIndexable;
		}
		
		/**
		 * @private
		 */
		protected function validateCollection(collection:ICollection): void
		{
			if (!collection || collection.isEmpty()) return;
			//TODO:pensar em criar metodo em CollectionUtil que recebe varios types e valida. pensar em incluir em org.as3utils.ArrayUtil
			var containsOnlyTypePriority:Boolean = CollectionUtil.containsOnlyType(collection, IPriority, false);
			var containsOnlyTypeIndexable:Boolean = CollectionUtil.containsOnlyType(collection, IIndexable, false);
			if (containsOnlyTypePriority && containsOnlyTypeIndexable) return;
			
			var it:IIterator = collection.iterator();
			var element:*;
			
			while (it.hasNext())
			{
				element = it.next();
				if (!isValidElement(element)) break;
			}
			
			var error:ClassCastError = getInvalidElementError(element);
			throw error;
		}
		
		/**
		 * @private
		 */
		override protected function elementAdded(element:*):void
		{
			super.elementAdded(element);
			if (element && element is IEventDispatcher) addPriorityIndexEventListenerToElement(element);
		}
		
		/**
		 * @private
		 */
		override protected function elementRemoved(element:*):void
		{
			super.elementRemoved(element);
			if (element && element is IEventDispatcher) removePriorityIndexEventListenerFromElement(element);
		}
		
		/**
		 * @private
		 */
		protected function validateElement(element:*): void
		{
			if (isValidElement(element)) return;
			
			var error:ClassCastError = getInvalidElementError(element);
			throw error;
		}
		
		/**
		 * @private
		 */
		private function addPriorityIndexEventListenerToElement(element:IEventDispatcher):void
		{
			element.addEventListener(IndexEvent.CHANGED, elementPriorityIndexChanged, false, 0, true);
			element.addEventListener(PriorityEvent.CHANGED, elementPriorityIndexChanged, false, 0, true);
		}
		
		/**
		 * @private
		 */
		private function elementPriorityIndexChanged(event:Event):void
		{
			_sort();
		}
		
		/**
		 * @private
		 */
		private function getInvalidElementError(element:*): ClassCastError
		{
			var message:String = "Element must implement org.as3coreaddendum.system.IPriority and org.as3coreaddendum.system.IIndexable\n";
			message += "element: <" + element + ">\n";
			message += "element type: <" + ReflectionUtil.getClassPath(element) + ">";
			
			return new ClassCastError(message);
		}
		
		/**
		 * @private
		 */
		private function removePriorityIndexEventListenerFromElement(element:IEventDispatcher):void
		{
			element.removeEventListener(IndexEvent.CHANGED, elementPriorityIndexChanged, false);
			element.removeEventListener(PriorityEvent.CHANGED, elementPriorityIndexChanged, false);
		}

	}

}