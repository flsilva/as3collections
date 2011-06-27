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
	import org.as3collections.IListMapIterator;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3collections.iterators.ListMapIterator;

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
	 * import org.as3collections.maps.SortedArrayListMap;
	 * import org.as3collections.maps.TypedSortedMap;
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
	public class TypedListMap extends TypedMap implements IListMap
	{
		/**
		 * Returns the return of the call <code>wrapMap.modCount</code>.
		 */
		public function get modCount(): int { return wrappedListMap.modCount; }
		
		/**
		 * @private
		 */
		protected function get wrappedListMap(): IListMap { return wrappedMap as IListMap; }

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
		public function TypedListMap(wrapMap:IListMap, typeKeys:*, typeValues:*): void
		{
			super(wrapMap, typeKeys, typeValues);
		}

		/**
		 * Creates and return a new <code>TypedListMap</code> object with the clone of the <code>wrappedMap</code> object.
		 * 
		 * @return 	a new <code>TypedListMap</code> object with the clone of the <code>wrappedMap</code> object.
 		 */
		override public function clone(): *
		{
			return new TypedListMap(wrappedListMap.clone(), typeKeys, typeValues);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.getKeyAt</code>.
		 * 
		 * @param index
		 * @return
		 */
		public function getKeyAt(index:int): *
		{
			return wrappedListMap.getKeyAt(index);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.getValueAt</code>.
		 * 
		 * @param index
		 * @return
		 */
		public function getValueAt(index:int): *
		{
			return wrappedListMap.getValueAt(index);
		}

		/**
		 * Forwards the call to <code>wrappedMap.headMap</code>.
		 * 
		 * @param toKey
		 * @return
		 */
		public function headMap(toKey:*): IListMap
		{
			return new TypedListMap(wrappedListMap.headMap(toKey), typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.indexOfKey</code>.
		 * 
		 * @param key
		 * @return
		 */
		public function indexOfKey(key:*): int
		{
			return wrappedListMap.indexOfKey(key);
		}

		/**
		 * Forwards the call to <code>wrappedMap.indexOfValue</code>.
		 * 
		 * @param value
		 * @return
		 */
		public function indexOfValue(value:*): int
		{
			return wrappedListMap.indexOfValue(value);
		}
		
		/**
		 * Returns a <code>IListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 * The specified index indicates the first value that would be returned by an initial call to <code>next</code>.
		 * An initial call to <code>previous</code> would return the value with the specified index minus one.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index of first value to be returned from the iterator (by a call to the <code>next</code> method) 
		 * @return 	a <code>IListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 */
		public function listMapIterator(index:int = 0): IListMapIterator
		{
			return new ListMapIterator(this, index);
		}
		
		/**
		 * The map is validated to be forwarded to <code>wrappedMap.putAllAt</code>.
		 * 
		 * @param index
		 * @param map
		 */
		public function putAllAt(index:int, map:IMap): void
		{
			validateMap(map);
			wrappedListMap.putAllAt(index, map);
		}
		
		/**
		 * The key and value are validated to be forwarded to <code>wrappedMap.putAt</code>.
		 * 
		 * @param  	index 	index at which the specified mapping is to be inserted.
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key or value is incompatible with this map.
		 * @return 	the return of the call <code>wrappedMap.put</code>.
		 */
		public function putAt(index:int, key:*, value:*): void
		{
			validateKey(key);
			validateValue(value);
			wrappedListMap.putAt(index, key, value);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.removeAt</code>.
		 * 
		 * @param index
		 */
		public function removeAt(index:int): IMapEntry
		{
			return wrappedListMap.removeAt(index);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.reverse</code>.
		 * 
		 * @param index
		 */
		public function reverse(): void
		{
			wrappedListMap.reverse();
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.removeRange</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @return 	the return of the call <code>wrappedMap.removeRange</code>.
		 */
		public function removeRange(fromIndex:int, toIndex:int): IListMap
		{
			return wrappedListMap.removeRange(fromIndex, toIndex);
		}
		
		/**
		 * The key is validated to be forwarded to <code>wrappedMap.setKeyAt</code>.
		 * 
		 * @param index
		 * @param  	key 	the key to forward to <code>wrappedMap.setKeyAt</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key or value is incompatible with this map.
		 * @return 	the return of the call <code>wrappedMap.setKeyAt</code>.
		 */
		public function setKeyAt(index:int, key:*): *
		{
			validateKey(key);
			return wrappedListMap.setKeyAt(index, key);
		}
		
		/**
		 * The value is validated to be forwarded to <code>wrappedMap.setValueAt</code>.
		 * 
		 * @param index
		 * @param  	key 	the key to forward to <code>wrappedMap.setValueAt</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key or value is incompatible with this map.
		 * @return 	the return of the call <code>wrappedMap.setValueAt</code>.
		 */
		public function setValueAt(index:int, value:*): *
		{
			validateValue(value);
			return wrappedListMap.setValueAt(index, value);
		}
		
		/**
		 * Forwards the call to <code>wrappedMap.subMap</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @return
		 */
		public function subMap(fromIndex:int, toIndex:int): IListMap
		{
			return new TypedListMap(wrappedListMap.subMap(fromIndex, toIndex), typeKeys, typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.tailMap</code>.
		 * 
		 * @param fromKey
		 * @return
		 */
		public function tailMap(fromKey:*): IListMap
		{
			return new TypedListMap(wrappedListMap.tailMap(fromKey), typeKeys, typeValues);
		}

	}

}