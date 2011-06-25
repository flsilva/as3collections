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

package org.as3collections.utils
{
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3collections.ISortedMap;
	import org.as3collections.maps.TypedMap;
	import org.as3collections.maps.TypedSortedMap;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with implementations of the <code>IMap</code> interface.
	 * 
	 * @author Flávio Silva
	 */
	public class MapUtil
	{
		/**
		 * <code>MapUtil</code> is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	<code>MapUtil</code> is a static class and shouldn't be instantiated.
		 */
		public function MapUtil()
		{
			throw new IllegalOperationError("MapUtil is a static class and shouldn't be instantiated.");
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between the two arguments.
		 * If one of the collections or both collections are <code>null</code> it will be returned <code>false</code>.
		 * <p>Two different objects are considered equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation <b>takes care</b> of the order of the elements in the collections.
		 * So, for two collections are equal the order of elements returned by the iterator object must be equal.</p>
		 * 
		 * @param  	collection1 	the first collection.
		 * @param  	collection2 	the second collection.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * If one of the maps or both maps are <code>null</code> it will be returned <code>false</code>.
		 * <p>Two different objects are considered equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all mappings of object B</li>
		 * <li>object B contains all mappings of object A</li>
		 * <li>mappings have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation <b>takes care</b> of the order of the mappings in the maps.
		 * So, for two maps are equal the order of entries returned by the iterator object must be equal.</p>
		 * 
		 * @param  	map1 	the first map.
		 * @param  	map2 	the second map.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public static function equalConsideringOrder(map1:IMap, map2:IMap): Boolean
		{
			if (!map1 || !map2) return false;
			if (map1 == map2) return true;
			
			if (!ReflectionUtil.classPathEquals(map1, map2)) return false;
			if (map1.size() != map2.size()) return false;
			
			var itEntryList1:IIterator = map1.entryList().iterator();
			var itEntryList2:IIterator = map2.entryList().iterator();
			var mapEntry1:IMapEntry;
			var mapEntry2:IMapEntry;
			
			while (itEntryList1.hasNext())
			{
				mapEntry1 = itEntryList1.next();
				mapEntry2 = itEntryList2.next();
				
				if (!mapEntry1.equals(mapEntry2)) return false;
			}
			
			return true;
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * If one of the maps or both maps are <code>null</code> it will be returned <code>false</code>.
		 * <p>Two different objects are considered equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all mappings of object B</li>
		 * <li>object B contains all mappings of object A</li>
		 * </ul></p>
		 * <p>This implementation <b>does not takes care</b> of the order of the mappings in the map.</p>
		 * 
		 * @param  	map1 	the first map.
		 * @param  	map2 	the second map.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public static function equalNotConsideringOrder(map1:IMap, map2:IMap): Boolean
		{
			if (!map1 || !map2) return false;
			if (map1 == map2) return true;
			
			if (!ReflectionUtil.classPathEquals(map1, map2)) return false;
			if (map1.size() != map2.size()) return false;
			
			var itMap1:IIterator = map1.entryList().iterator();
			var entryListMap2:IList = map2.entryList();
			
			// because maps has same size
			// it's not necessary to perform bidirectional validation
			// i.e. if map1 contains all entries of map2
			// consequently map2 contains all entries of map1
			while (itMap1.hasNext())
			{
				if (!entryListMap2.contains(itMap1.next())) return false;
			}
			
			return true;
		}
		
		/**
		 * Returns a new <code>TypedMap</code> with the <code>wrapMap</code> argument wrapped.
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.IMap;
		 * import org.as3collections.maps.ArrayMap;
		 * import org.as3collections.maps.TypedMap;
		 * import org.as3collections.maps.utils.MapUtil;
		 * 
		 * var map1:IMap = new ArrayMap();
		 * 
		 * map1.put("e", 1)            // null
		 * map1.put("d", 2)            // null
		 * map1.put("c", 3)            // null
		 * map1.put("b", 4)            // null
		 * map1.put("a", 5)            // null
		 * 
		 * map1                        // {e=1,d=2,c=3,b=4,a=5}
		 * map1.size()                 // 5
		 * 
		 * var map2:IMap = MapUtil.getTypedMap(map1, String, Number);
		 * 
		 * map2                        // {e=1,d=2,c=3,b=4,a=5}
		 * map2.size()                 // 5
		 * 
		 * map2.equals(map1)           // false
		 * 
		 * map2.put("f", 6)            // null
		 * map2                        // {e=1,d=2,c=3,b=4,a=5,f=6}
		 * map2.size()                 // 6
		 * 
		 * map2.put("g", "h")          // ClassCastError: Invalid value type. value: h | type: String | expected value type: Number
		 * map2.put(7, 8)              // ClassCastError: Invalid key type. key: 7 | type: int | expected key type: String
		 * </listing>
		 * 
		 * @param  	wrapMap 	the target map to be wrapped by the <code>TypedMap</code>.
		 * @param 	typeKeys	the type of the keys allowed by the returned <code>TypedMap</code>.
		 * @param 	typeValues	the type of the values allowed by the returned <code>TypedMap</code>.
		 * @throws 	ArgumentError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 * @return 	a new <code>TypedMap</code> with the <code>wrapMap</code> argument wrapped.
		 */
		public static function getTypedMap(wrapMap:IMap, typeKeys:*, typeValues:*): TypedMap
		{
			return new TypedMap(wrapMap, typeKeys, typeValues);
		}

		/**
		 * Returns a new <code>TypedSortedMap</code> with the <code>wrapMap</code> argument wrapped.
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
		 * var map2:ISortedMap = MapUtil.getTypedSortedMap(map1, String, Number);
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
		 * @param  	wrapMap 	the target map to be wrapped by the <code>TypedSortedMap</code>.
		 * @param 	typeKeys	the type of the keys allowed by the returned <code>TypedSortedMap</code>.
		 * @param 	typeValues	the type of the values allowed by the returned <code>TypedSortedMap</code>.
		 * @throws 	ArgumentError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 * @return 	a new <code>TypedSortedMap</code> with the <code>wrapMap</code> argument wrapped.
		 */
		public static function getTypedSortedMap(wrapMap:ISortedMap, typeKeys:*, typeValues:*): TypedSortedMap
		{
			return new TypedSortedMap(wrapMap, typeKeys, typeValues);
		}
		
		/**
		 * Returns the string representation of the <code>map</code> argument.
		 * 
		 * @param  	map the target map.
		 * @return 	the string representation of the target map.
 		 */
		public static function toString(map:IMap): String 
		{
			var s:String = "[";
			var it:IIterator = map.iterator();
			var value	:*;
			
			while (it.hasNext())
			{
				value 	= it.next();
				
				s 		+= it.pointer() + "=" + value;
				if (it.hasNext()) s += ",";
			}
			
			s += "]";
			
			return s;
		}

	}

}