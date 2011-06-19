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
	import org.as3collections.ISortedQueue;
	import org.as3coreaddendum.system.IComparator;
	import org.as3utils.ReflectionUtil;

	/**
	 * A queue that provides a <em>total ordering</em> on its elements.
	 * The queue is ordered according to the <em>natural ordering</em> of its elements, by a <em>IComparator</em> typically provided at sorted queue creation time, or by the arguments provided to the <code>sort</code> or <code>sortOn</code> methods.
	 * <p>For each change that occurs the queue is automatically ordered using the <code>comparator</code> and <code>options</code>.
	 * If none was provided the default behavior of the <code>sort</code> method is used.</p>
	 * <p>The user of this queue may change their order at any time by calling the <code>sort</code> or <code>sortOn</code> method and imposing others arguments to change the sort behaviour.</p>
	 * <p>It's possible to create unique sorted queues, typed sorted queues and even unique typed sorted queues.
	 * You just sends the <code>SortedQueue</code> object to the wrappers <code>UniqueQueue</code> or <code>TypedQueue</code> or uses the <code>QueueUtil.getUniqueTypedQueue</code>.
	 * But there's a problem here: the return type will be <code>UniqueQueue</code> or <code>TypedQueue</code>.
	 * Thus you will can no longer use the <code>sort</code> and <code>sortOn</code> methods directly.
	 * The wrapped <code>SortedQueue</code> will be only automatically ordered, with the provided <code>comparator</code> and <code>options</code> constructor's arguments.
	 * Check the examples at the bottom of the page.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedQueue;
	 * import org.as3collections.queues.SortedQueue;
	 * 
	 * var queue1:ISortedQueue = new SortedQueue([3, 5, 1, 7], null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * queue1                      // [7,5,3,1]
	 * queue1.size()               // 4
	 * 
	 * queue1.add(-1)              // true
	 * queue1                      // [7,5,3,1,-1]
	 * queue1.size()               // 5
	 * 
	 * queue1.add(4)               // true
	 * queue1                      // [7,5,4,3,1,-1]
	 * queue1.size()               // 6
	 * 
	 * queue1.add(5)               // true
	 * queue1                      // [7,5,5,4,3,1,-1]
	 * queue1.size()               // 7
	 * 
	 * queue1.poll()               // 7
	 * queue1                      // [5,5,4,3,1,-1]
	 * queue1.size()               // 6
	 * 
	 * queue1.sort(null, Array.NUMERIC)
	 * queue1                      // [-1,1,3,4,5,5]
	 * 
	 * queue1.poll()               // -1
	 * queue1                      // [5,5,4,3,1]
	 * queue1.size()               // 5
	 * 
	 * queue1.add(2)               // true
	 * queue1                      // [5,5,4,3,2,1]
	 * queue1.size()               // 6
	 * 
	 * queue1.add(10)              // true
	 * queue1                      // [10,5,5,4,3,2,1]
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class SortedQueue extends LinearQueue implements ISortedQueue
	{
		private var _comparator: IComparator;
		private var _options: uint;

		/**
		 * Defines the comparator object to be used automatically to sort.
		 * <p>If this value change the queue is automatically reordered with the new value.</p>
		 */
		public function get comparator(): IComparator { return _comparator; }

		public function set comparator(value:IComparator): void
		{
			_comparator = value;
			_sort();
		}

		/**
		 * Defines the options to be used automatically to sort.
		 * <p>If this value change the queue is automatically reordered with the new value.</p>
		 */
		public function get options(): uint { return _options; }

		public function set options(value:uint): void
		{
			_options = value;
			_sort();
		}

		/**
		 * Constructor, creates a new <code>SortedQueue</code> object.
		 * 
		 * @param 	source 		an array to fill the queue.
		 * @param 	comparator 	the comparator object to be used internally to sort.
		 * @param 	options 	the options to be used internally to sort.
		 */
		public function SortedQueue(source:Array = null, comparator:IComparator = null, options:uint = 0)
		{
			super(source);
			
			_comparator = comparator;
			_options = options;
			_sort();
		}

		/**
		 * Creates and return a new <code>SortedQueue</code> object containing all elements in this queue (in the same order).
		 * 
		 * @return 	a new <code>SortedQueue</code> object containing all elements in this queue (in the same order).
 		 */
		override public function clone(): *
		{
			return new SortedQueue(data, _comparator, _options);
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * <li>object A and object B has the same type of comparator</li>
		 * <li>object A and object B has the same options</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the elements in the queue.
		 * So, for two queues are equal the order of elements returned by the iterator object must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var l:ISortedQueue = other as ISortedQueue;
			
			if (_options != l.options) return false;
			if (!_comparator && l.comparator) return false;
			if (_comparator && !l.comparator) return false;
			if (!ReflectionUtil.classPathEquals(_comparator, l.comparator)) return false;
			
			return super.equals(other);
		}
		
		/**
		 * Inserts the specified element into this queue if it is possible to do so immediately without violating restrictions.
		 * When using a restricted queue (like <code>TypedQueue</code> and <code>UniqueQueue</code>), this method is generally preferable to <code>add</code>, which can fail to insert an element only by throwing an error. 
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @param  	element 	the element to add.
		 * @return 	<code>true</code> if the element was added to this queue, else <code>false</code>. 
		 */
		override public function offer(element:*): Boolean
		{
			var b:Boolean = super.offer(element);
			if (b) _sort();
			return b;
		}

		/**
		 * Retrieves and removes the head of this queue, or returns <code>null</code> if this queue is empty. 
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @return 	the head of this queue, or <code>null</code> if this queue is empty.
 		 */
		override public function poll(): *
		{
			var e:* = super.poll();
			if (e) _sort();
			return e;
		}

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this queue, if it is present.
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @param  	o 	the object to be removed from this collection, if present.
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 */
		override public function remove(o:*): Boolean
		{
			var b:Boolean = super.remove(o);
			if (b) _sort();
			return b;
		}

		/**
		 * Removes all of this queue's elements that are also contained in the specified collection. After this call returns, this queue will contain no elements in common with the specified collection.
		 * <p>Before returning, the queue is reordered.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this queue.
		 * @return 	<code>true</code> if this queue changed as a result of the call.
		 */
		override public function removeAll(collection:ICollection): Boolean
		{
			var b:Boolean = super.removeAll(collection);
			if (b) _sort();
			return b;
		}

		/**
		 * Sorts the objects within this class.
		 * <p>For more info see <code>org.as3coreaddendum.system.ISortable.sort()</code> in the link below.</p>
		 * 
		 * @param compare
		 * @param options
		 * @return
		 */
		public function sort(compare:Function = null, options:uint = 0): Array
		{
			if (compare != null)
			{ 
				return data.sort(compare, options);
			}
			else
			{
				return data.sort(options);
			}
		}

		/**
		 * @inheritDoc
		 * 
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#sortOn()
		 */
		public function sortOn(fieldName:*, options:* = null): Array
		{
			return data.sortOn(fieldName, options);
		}

		/**
		 * @private
		 */
		protected function _sort(): void
		{
			if (_comparator)
			{
				sort(_comparator.compare, _options);
			}
			else
			{
				sort(null, _options);
			}
		}

	}

}