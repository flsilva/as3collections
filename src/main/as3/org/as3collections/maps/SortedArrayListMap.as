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

package org.as3collections.maps 
{
	import org.as3collections.IListMap;
	import org.as3collections.IMap;
	import org.as3collections.ISortedMap;
	import org.as3collections.SortMapBy;
	import org.as3collections.lists.ArrayList;
	import org.as3coreaddendum.system.IComparator;
	import org.as3utils.ArrayUtil;
	import org.as3utils.ReflectionUtil;

	/**
	 * A map that provides a <em>total ordering</em> on its mappings.
	 * The map is ordered according to the <em>natural ordering</em> of its keys or values, by a <em>IComparator</em> typically provided at sorted map creation time, or by the arguments provided to the <code>sort</code> or <code>sortOn</code> methods.
	 * <p>For each change that occurs the map is automatically ordered using the <code>comparator</code> and <code>options</code>.
	 * If none was provided the default behavior of the <code>sort</code> method is used.</p>
	 * The <code>sortBy</code> property defines whether the sorting will be made by <code>key</code> or <code>value</code>.
	 * <p>The user of this map may change their order at any time by calling the <code>sort</code> or <code>sortOn</code> method and imposing others arguments to change the sort behaviour.</p>
	 * <p>It's possible to create typed sorted maps.
	 * You just sends the <code>SortedArrayListMap</code> object to the wrapper <code>TypedSortedMap</code> or uses the <code>MapUtil.getTypedSortedMap</code>.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedMap;
	 * import org.as3collections.maps.SortedArrayListMap;
	 * 
	 * var map1:ISortedMap = new SortedArrayListMap();
	 * 
	 * map1.put("e", 1)            // null
	 * map1.put("d", 2)            // null
	 * map1.put("c", 3)            // null
	 * map1.put("b", 4)            // null
	 * map1.put("a", 5)            // null
	 * 
	 * map1                        // {a=5,b=4,c=3,d=2,e=1}
	 * 
	 * map1.firstKey()             // a
	 * map1.lastKey()              // e
	 * 
	 * map1.sortBy = SortMapBy.VALUE;
	 * 
	 * map1                        // {e=1,d=2,c=3,b=4,a=5}
	 * 
	 * map1.firstKey()             // e
	 * map1.lastKey()              // a
	 * 
	 * map1.sort(null, Array.NUMERIC);
	 * 
	 * map1                        // {e=1,d=2,c=3,b=4,a=5}
	 * 
	 * map1.sort(null, Array.NUMERIC | Array.DESCENDING);
	 * 
	 * map1                        // {a=5,b=4,c=3,d=2,e=1}
	 * 
	 * map1.sortBy = SortMapBy.KEY;
	 * 
	 * map1                        // {a=5,b=4,c=3,d=2,e=1}
	 * 
	 * map1.headMap("d")           // {a=5,b=4,c=3}
	 * map1.tailMap("b")           // {b=4,c=3,d=2,e=1}
	 * map1.subMap("b", "d")       // {b=4,c=3}
	 * </listing>
	 * 
	 * @see org.as3collections.utils.MapUtil#getTypedSortedMap() MapUtil.getTypedSortedMap()
	 * @author Flávio Silva
	 */
	public class SortedArrayListMap extends ArrayListMap implements ISortedMap
	{
		private var _comparator: IComparator;
		private var _options: uint;
		private var _sortBy: SortMapBy;

		/**
		 * Defines the comparator object to be used automatically to sort.
		 * <p>If this value change the map is automatically reordered with the new value.</p>
		 */
		public function get comparator(): IComparator { return _comparator; }

		public function set comparator(value:IComparator): void
		{
			_comparator = value;
			_sort();
		}

		/**
		 * Defines the options to be used automatically to sort.
		 * <p>If this value change the list is automatically reordered with the new value.</p>
		 */
		public function get options(): uint { return _options; }

		public function set options(value:uint): void
		{
			_options = value;
			_sort();
		}

		/**
		 * Defines whether the map should be sorted by its keys or values. The default is <code>SortMapBy.KEY</code>.
		 * <p>If this value change the map is automatically reordered with the new value.</p>
		 * 
		 * @throws 	ArgumentError  	 if try to set a <code>null</code> value.
		 */
		public function get sortBy(): SortMapBy { return _sortBy; }

		public function set sortBy(value:SortMapBy): void
		{
			if (!value) throw new ArgumentError("Argument must no be null.");
			_sortBy = value;
			_sort();
		}

		/**
		 * Constructor, creates a new <code>SortedArrayListMap</code> object.
		 * 
		 * @param 	source 		a map with wich fill this map.
		 * @param 	comparator 	the comparator object to be used internally to sort.
		 * @param 	options 	the options to be used internally to sort.
		 */
		public function SortedArrayListMap(source:IMap = null, comparator:IComparator = null, options:uint = 0)
		{
			super(source);
			
			_comparator = comparator;
			_options = options;
			_sortBy = SortMapBy.KEY;
			_sort();
		}

		/**
		 * Creates and return a new <code>SortedArrayListMap</code> object containing all elements in this map (in the same order).
		 * 
		 * @return 	a new <code>SortedArrayListMap</code> object containing all elements in this map (in the same order).
 		 */
		override public function clone(): *
		{
			return new SortedArrayListMap(this, _comparator, _options);
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all mappings of object B</li>
		 * <li>object B contains all mappings of object A</li>
		 * <li>mappings have exactly the same order</li>
		 * <li>object A and object B has the same type of comparator</li>
		 * <li>object A and object B has the same options</li>
		 * <li>object A and object B has the same sortBy</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the mappings in the map.
		 * So, for two maps are equal the order of mappings returned by the iterator must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var m:ISortedMap = other as ISortedMap;
			
			if (_sortBy != m.sortBy) return false;
			if (_options != m.options) return false;
			if (!_comparator && m.comparator) return false;
			if (_comparator && !m.comparator) return false;
			if (!ReflectionUtil.classPathEquals(_comparator, m.comparator)) return false;
			
			return super.equals(other);
		}

		/**
		 * @inheritDoc
		 */
		override public function put(key:*, value:*): *
		{
			var old:* = super.put(key, value);
			_sort();
			return old;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function putAt(index:int, key:*, value:*): void
		{
			super.putAt(index, key, value);
			_sort();
		}

		/**
		 * @inheritDoc
		 */
		override public function setKeyAt(index:int, key:*): *
		{
			var old:* = super.setKeyAt(index, key);
			if (_sortBy == SortMapBy.KEY) _sort();
			return old;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setValueAt(index:int, value:*): *
		{
			var old:* = super.setValueAt(index, value);
			if (_sortBy == SortMapBy.VALUE) _sort();
			return old;
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
			var sortArray:Array;
			var otherArray:Array;
			
			if (_sortBy == SortMapBy.KEY)
			{
				sortArray = keys.toArray();
				otherArray = values.toArray();
			}
			else
			{
				sortArray = values.toArray();
				otherArray = keys.toArray();
			}
			
			var arr:Array;
			
			if (compare != null)
			{ 
				arr = sortArray.sort(compare, options | Array.RETURNINDEXEDARRAY);
			}
			else
			{
				arr = sortArray.sort(options | Array.RETURNINDEXEDARRAY);
			}
			
			ArrayUtil.swapPositions(sortArray, arr);
			ArrayUtil.swapPositions(otherArray, arr);
			
			if (_sortBy == SortMapBy.KEY)
			{
				keys = new ArrayList(sortArray);
				values = new ArrayList(otherArray);
			}
			else
			{
				keys = new ArrayList(otherArray);
				values = new ArrayList(sortArray);
			}
			
			return arr;
		}

		/**
		 * @inheritDoc
		 * 
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#sortOn()
		 */
		public function sortOn(fieldName:*, options:* = null): Array
		{
			var sortArray:Array;
			var otherArray:Array;
			
			if (_sortBy == SortMapBy.KEY)
			{
				sortArray = keys.toArray();
				otherArray = values.toArray();
			}
			else
			{
				sortArray = values.toArray();
				otherArray = keys.toArray();
			}
			
			var arr:Array = sortArray.sortOn(fieldName, options | Array.RETURNINDEXEDARRAY);
			
			ArrayUtil.swapPositions(sortArray, arr);
			ArrayUtil.swapPositions(otherArray, arr);
			
			if (_sortBy == SortMapBy.KEY)
			{
				keys = new ArrayList(sortArray);
				values = new ArrayList(otherArray);
			}
			else
			{
				keys = new ArrayList(otherArray);
				values = new ArrayList(sortArray);
			}
			
			return arr;
		}
		
		/**
		 *@inheritDoc 
		 * 
		 * @param  	fromIndex 	the index to start retrieving mappings (inclusive).
		 * @param  	toIndex 	the index to stop retrieving mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subMap</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		override public function subMap(fromIndex:int, toIndex:int): IListMap
		{
			var map:ISortedMap = super.subMap(fromIndex, toIndex) as ISortedMap;
			map.comparator = comparator;
			map.options = options;
			
			return map;
		}
		
		/**
		 * @private
		 */
		override protected function createEmptyMap(): IListMap
		{
			return new SortedArrayListMap();
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