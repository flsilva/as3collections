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
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IListMap;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3collections.ISortedMap;
	import org.as3collections.maps.TypedListMap;
	import org.as3collections.maps.TypedMap;
	import org.as3collections.maps.TypedSortedMap;
	import org.as3utils.BooleanUtil;
	import org.as3utils.NumberUtil;
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
			
			var itEntryList1:IIterator = map1.entryCollection().iterator();
			var itEntryList2:IIterator = map2.entryCollection().iterator();
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
			
			var itMap1:IIterator = map1.entryCollection().iterator();
			var entryListMap2:ICollection = map2.entryCollection();
			
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
		 * Feeds argument <code>map</code> with argument <code>list</code>.
		 * <p>The name of the nodes become keys and the values of the nodes become values of the <code>IMap</code> object.</p>
		 * 
		 * @example
		 * 
		 * <listing version="3.0">
		 * import org.as3collections.maps.HashMap;
		 * import org.as3collections.utils.MapUtil;
		 * 
		 * var map:IMap = new HashMap();
		 * var xml:XML = &lt;index&gt;&lt;key1&gt;value1&lt;/key1&gt;&lt;key2&gt;value2&lt;/key2&gt;&lt;/index&gt;;
		 * 
		 * MapUtil.feedMapFromXmlList(map, xml.children());
		 * 
		 * trace(map); // [key1=value1,key2=value2]
		 * </listing>
		 * 
		 * @param  	map 			the map to be fed.
		 * @param  	list 			the list to retrieve entries.
		 * @param  	typeCoercion 	if <code>true</code> performs a type coercion to Boolean if some String is "true" or "false", or a type coercion to Number if some String is a Number <code>(i.e. !isNaN(Number(string)) == true)</code>.
		 */
		public static function feedMapWithXmlList(map:IMap, list:XMLList, typeCoercion:Boolean = true): void
		{
			if (!map) throw new ArgumentError("Argument <map> must not be null.");
			if (!list) return;
			
			var nodeName:*;
			var nodeValue:*;
			
			for each (var node:XML in list)
			{
				nodeName = node.localName();
				
				if (node.hasComplexContent())
				{
					if (!isNaN(node.children().length()) && node.children().length() > 0)
					{
						nodeValue = feedMapWithXmlList(map, node.children(), typeCoercion);
					}
					else
					{
						nodeValue = node;
					}
				}
				else
				{
					nodeValue = node.toString();
				}
				
				if (typeCoercion)
				{
					if (BooleanUtil.isBooleanString(nodeName))
					{
						nodeName = BooleanUtil.string2Boolean(nodeName);
					}
					else if (NumberUtil.isNumber(Number(nodeName)))
					{
						nodeName = Number(nodeName);
					}
					
					if (BooleanUtil.isBooleanString(nodeValue))
					{
						nodeValue = BooleanUtil.string2Boolean(nodeValue);
					}
					else if (NumberUtil.isNumber(Number(nodeValue)))
					{
						nodeValue = Number(nodeValue);
					}
				}
				
				map.put(nodeName, nodeValue);
			}
		}
		
		/**
		 * Returns a new <code>TypedMap</code> with the <code>wrapMap</code> argument wrapped.
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
		 * Returns a new <code>TypedListMap</code> with the <code>wrapMap</code> argument wrapped.
		 * 
		 * @param  	wrapMap 	the target map to be wrapped by the <code>TypedListMap</code>.
		 * @param 	typeKeys	the type of the keys allowed by the returned <code>TypedListMap</code>.
		 * @param 	typeValues	the type of the values allowed by the returned <code>TypedListMap</code>.
		 * @throws 	ArgumentError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 * @return 	a new <code>TypedListMap</code> with the <code>wrapMap</code> argument wrapped.
		 */
		public static function getTypedListMap(wrapMap:IListMap, typeKeys:*, typeValues:*): TypedListMap
		{
			return new TypedListMap(wrapMap, typeKeys, typeValues);
		}

		/**
		 * Returns a new <code>TypedSortedMap</code> with the <code>wrapMap</code> argument wrapped.
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