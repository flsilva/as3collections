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
	import org.as3coreaddendum.system.IComparator;
	import org.as3utils.ReflectionUtil;

	/**
	 * <code>TypedSortedMap</code> works as a wrapper for a map.
	 * It stores the <code>wrapMap</code> constructor's argument in the <code>wrappedMap</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedMap</code> object.
	 * The methods that need to be checked for the type of the keys and values are previously validated with the <code>validateKeyType</code>, <code>validateValueType</code> or <code>validateMap</code> method before forward the call.
	 * If the type of a key or value requested to be inserted to this map is incompatible with the type of the map a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * The calls that are forwarded to the <code>wrappedMap</code> returns the return of the <code>wrappedMap</code> call.
	 * <p><code>TypedSortedMap</code> does not allow <code>null</code> keys or values.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedMap;
	 * import org.as3collections.maps.SortedArrayMap;
	 * import org.as3collections.maps.TypedSortedMap;
	 * 
	 * var map1:ISortedMap = new SortedArrayMap();
	 * 
	 * map1.put("e", 1)            // null
	 * map1.put("d", 2)            // null
	 * map1.put("c", 3)            // null
	 * map1.put("b", 4)            // null
	 * map1.put("a", 5)            // null
	 * 
	 * map1                        // {a=5,b=4,c=3,d=2,e=1}
	 * map1.size()                 // 5
	 * 
	 * var map2:ISortedMap = new TypedSortedMap(map1, String, Number); // you can use this way
	 * 
	 * //var map2:ISortedMap = MapUtil.getTypedSortedMap(map1, String, Number); // or you can use this way
	 * 
	 * map2                        // {a=5,b=4,c=3,d=2,e=1}
	 * map2.size()                 // 5
	 * 
	 * map2.equals(map1)           // false
	 * 
	 * map2.put("f", 6)            // null
	 * map2                        // {a=5,b=4,c=3,d=2,e=1,f=6}
	 * map2.size()                 // 6
	 * 
	 * map2.put("g", "h")          // ClassCastError: Invalid value type. value: h | type: String | expected value type: Number
	 * map2.put(7, 8)              // ClassCastError: Invalid key type. key: 7 | type: int | expected key type: String
	 * </listing>
	 * 
	 * @see org.as3collections.utils.MapUtil#getTypedSortedMap() MapUtil.getTypedSortedMap()
	 * @author Flávio Silva
	 */
	public class TypedSortedMap extends TypedListMap implements ISortedMap
	{
		/**
		 * Defines the <code>wrappedMap</code> comparator object to be used automatically to sort.
		 * <p>If this value change the <code>wrappedMap</code> is automatically reordered with the new value.</p>
		 */
		public function get comparator(): IComparator { return wrappedSortedMap.comparator; }

		public function set comparator(value:IComparator): void { wrappedSortedMap.comparator = value; }

		/**
		 * Defines the <code>wrappedMap</code> options to be used automatically to sort.
		 * <p>If this value change the list is automatically reordered with the new value.</p>
		 */
		public function get options(): uint { return wrappedSortedMap.options; }

		public function set options(value:uint): void { wrappedSortedMap.options = value; }

		/**
		 * Defines whether the <code>wrappedMap</code> should be sorted by its keys or values. The default is <code>SortMapBy.KEY</code>.
		 * <p>If this value change the <code>wrappedMap</code> is automatically reordered with the new value.</p>
		 */
		public function get sortBy(): SortMapBy { return wrappedSortedMap.sortBy; }

		public function set sortBy(value:SortMapBy): void { wrappedSortedMap.sortBy = value; }

		/**
		 * @private
		 */
		protected function get wrappedSortedMap(): ISortedMap { return wrappedMap as ISortedMap; }

		/**
		 * Constructor, creates a new <code>TypedSortedMap</code> object.
		 * 
		 * @param 	wrapMap 	the target map to wrap.
		 * @param 	typeKeys	the type of the keys allowed by this map.
		 * @param 	typeValues	the type of the values allowed by this map.
		 * @throws 	ArgumentError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 */
		public function TypedSortedMap(wrapMap:ISortedMap, typeKeys:*, typeValues:*): void
		{
			super(wrapMap, typeKeys, typeValues);
		}

		/**
		 * Creates and return a new <code>TypedSortedMap</code> object with the clone of the <code>wrappedMap</code> object.
		 * 
		 * @return 	a new <code>TypedSortedMap</code> object with the clone of the <code>wrappedMap</code> object.
 		 */
		override public function clone(): *
		{
			return new TypedSortedMap(wrappedSortedMap.clone(), typeKeys, typeValues);
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
			
			if (sortBy != m.sortBy) return false;
			if (options != m.options) return false;
			if (!comparator && m.comparator) return false;
			if (comparator && !m.comparator) return false;
			if (!ReflectionUtil.classPathEquals(comparator, m.comparator)) return false;
			
			return super.equals(other);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.headMap</code>.
		 * 
		 * @param toKey
		 * @return
		 */
		override public function headMap(toKey:*): IListMap
		{
			var headMap:IMap = wrappedSortedMap.headMap(toKey);
			var sortedSubMap:ISortedMap = new SortedArrayMap(headMap, comparator, options);
			
			return new TypedSortedMap(sortedSubMap, typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.sort</code>.
		 * 
		 * @param compare
		 * @param options
		 * @return
		 */
		public function sort(compare:Function = null, options:uint = 0): Array
		{
			return wrappedSortedMap.sort(compare, options);
		}

		/**
		 * Forwards the call to <code>wrappedMap.sortOn</code>.
		 * 
		 * @param fieldName
		 * @param options
		 * @return
		 */
		public function sortOn(fieldName:*, options:* = null): Array
		{
			return wrappedSortedMap.sortOn(fieldName, options);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.subMap</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @return
		 */
		override public function subMap(fromIndex:int, toIndex:int): IListMap
		{
			var subMap:IMap = wrappedSortedMap.subMap(fromIndex, toIndex);
			var sortedSubMap:ISortedMap = new SortedArrayMap(subMap, comparator, options);
			
			return new TypedSortedMap(sortedSubMap, typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.tailMap</code>.
		 * 
		 * @param fromKey
		 * @return
		 */
		override public function tailMap(fromKey:*): IListMap
		{
			var tailMap:IMap = wrappedSortedMap.tailMap(fromKey);
			var sortedSubMap:ISortedMap = new SortedArrayMap(tailMap, comparator, options);
			
			return new TypedSortedMap(sortedSubMap, typeKeys, typeValues);
		}

	}

}