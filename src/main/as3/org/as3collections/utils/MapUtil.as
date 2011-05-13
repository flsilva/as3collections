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
	import flash.errors.IllegalOperationError;
	
	import org.as3collections.IMap;
	import org.as3collections.ISortedMap;
	import org.as3collections.maps.TypedMap;
	import org.as3collections.maps.TypedSortedMap;

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
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeValues</code> argument is <code>null</code>.
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
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 * @return 	a new <code>TypedSortedMap</code> with the <code>wrapMap</code> argument wrapped.
		 */
		public static function getTypedSortedMap(wrapMap:ISortedMap, typeKeys:*, typeValues:*): TypedSortedMap
		{
			return new TypedSortedMap(wrapMap, typeKeys, typeValues);
		}

	}

}