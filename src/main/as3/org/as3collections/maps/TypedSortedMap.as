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
	import org.as3collections.ISortedMap;
	import org.as3collections.SortMapBy;
	import org.as3coreaddendum.system.IComparator;

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
	public class TypedSortedMap extends TypedMap implements ISortedMap
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
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeValues</code> argument is <code>null</code>.
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
		 * Forwards the call to <code>wrappedMap.firstKey</code>.
		 * 
		 * @return
 		 */
		public function firstKey(): *
		{
			return wrappedSortedMap.firstKey();
		}

		/**
		 * Forwards the call to <code>wrappedMap.headMap</code>.
		 * 
		 * @param toKey
		 * @return
		 */
		public function headMap(toKey:*): ISortedMap
		{
			return new TypedSortedMap(wrappedSortedMap.headMap(toKey), typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.indexOfKey</code>.
		 * 
		 * @param key
		 * @return
		 */
		public function indexOfKey(key:*): int
		{
			return wrappedSortedMap.indexOfKey(key);
		}

		/**
		 * Forwards the call to <code>wrappedMap.indexOfValue</code>.
		 * 
		 * @param value
		 * @return
		 */
		public function indexOfValue(value:*): int
		{
			return wrappedSortedMap.indexOfValue(value);
		}

		/**
		 * Forwards the call to <code>wrappedMap.lastKey</code>.
		 * 
		 * @return
 		 */
		public function lastKey(): *
		{
			return wrappedSortedMap.lastKey();
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
		 * @param fromKey
		 * @param toKey
		 * @return
		 */
		public function subMap(fromKey:*, toKey:*): ISortedMap
		{
			return new TypedSortedMap(wrappedSortedMap.subMap(fromKey, toKey), typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.tailMap</code>.
		 * 
		 * @param fromKey
		 * @return
		 */
		public function tailMap(fromKey:*): ISortedMap
		{
			return new TypedSortedMap(wrappedSortedMap.tailMap(fromKey), typeKeys, typeValues);
		}

	}

}