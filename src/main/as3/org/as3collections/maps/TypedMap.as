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

package org.as3collections.maps {
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3coreaddendum.errors.ClassCastError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3utils.ReflectionUtil;

	/**
	 * <code>TypedMap</code> works as a wrapper for a map.
	 * It stores the <code>wrapMap</code> constructor's argument in the <code>wrappedMap</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedMap</code> object.
	 * The methods that need to be checked for the type of the keys and values are previously validated with the <code>validateKeyType</code>, <code>validateValueType</code> or <code>validateMap</code> method before forward the call.
	 * If the type of a key or value requested to be inserted to this map is incompatible with the type of the map a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * The calls that are forwarded to the <code>wrappedMap</code> returns the return of the <code>wrappedMap</code> call.
	 * <p><code>TypedMap</code> does not allow <code>null</code> keys or values.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IMap;
	 * import org.as3collections.maps.ArrayMap;
	 * import org.as3collections.maps.TypedMap;
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
	 * var map2:IMap = new TypedMap(map1, String, Number); // you can use this way
	 * 
	 * //var map2:IMap = MapUtil.getTypedMap(map1, String, Number); // or you can use this way
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
	 * @see org.as3collections.utils.MapUtil#getTypedMap() MapUtil.getTypedMap()
	 * @author Flávio Silva
	 */
	public class TypedMap implements IMap
	{
		private var _typeKeys: *;
		private var _typeValues: *;
		private var _wrappedMap: IMap;

		/**
		 * @inheritDoc
		 */
		public function get allKeysEquatable(): Boolean { return _wrappedMap.allKeysEquatable; }

		/**
		 * @inheritDoc
		 */
		public function get allValuesEquatable(): Boolean { return _wrappedMap.allValuesEquatable; }

		/**
		 * Defines the acceptable type of the keys by this map.
		 */
		public function get typeKeys(): * { return _typeKeys; }

		/**
		 * Defines the acceptable type of the values by this map.
		 */
		public function get typeValues(): * { return _typeValues; }

		/**
		 * @private
		 */
		protected function get wrappedMap(): IMap { return _wrappedMap; }

		/**
		 * Constructor, creates a new <code>TypedMap</code> object.
		 * 
		 * @param 	wrapMap 	the target map to wrap.
		 * @param 	typeKeys	the type of the keys allowed by this map.
		 * @param 	typeValues	the type of the values allowed by this map.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapMap</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeKeys</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>typeValues</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>wrapMap</code> argument are incompatible with the <code>typeKeys</code> or <code>typeValues</code> argument.
		 */
		public function TypedMap(wrapMap:IMap, typeKeys:*, typeValues:*)
		{
			if (!wrapMap) throw new NullPointerError("The 'wrapMap' argument must not be 'null'.");
			if (typeKeys == null) throw new NullPointerError("The 'typeKeys' argument must not be 'null'.");
			if (typeValues == null) throw new NullPointerError("The 'typeValues' argument must not be 'null'.");
			
			_typeKeys = typeKeys;
			_typeValues = typeValues;
			
			validateMap(wrapMap);
			_wrappedMap = wrapMap;
		}

		/**
		 * Forwards the call to <code>wrappedMap.clear</code>.
		 */
		public function clear(): void
		{
			_wrappedMap.clear();
		}

		/**
		 * Creates and return a new <code>TypedMap</code> object with the clone of the <code>wrappedMap</code> object.
		 * 
		 * @return 	a new <code>TypedMap</code> object with the clone of the <code>wrappedMap</code> object.
 		 */
		public function clone(): *
		{
			return new TypedMap(_wrappedMap.clone(), _typeKeys, _typeValues);
		}

		/**
		 * Forwards the call to <code>wrappedMap.containsKey</code>.
		 * 
		 * @param  	key
		 * @return 	the return of the call <code>wrappedMap.containsKey</code>.
		 */
		public function containsKey(key:*): Boolean
		{
			return _wrappedMap.containsKey(key);
		}

		/**
		 * Forwards the call to <code>wrappedMap.containsValue</code>.
		 * 
		 * @param  	value
		 * @return 	the return of the call <code>wrappedMap.containsValue</code>.
		 */
		public function containsValue(value:*): Boolean
		{
			return _wrappedMap.containsValue(value);
		}

		/**
		 * Forwards the call to <code>wrappedMap.entryList</code>.
		 * 
		 * @return
 		 */
		public function entryList(): IList
		{
			return wrappedMap.entryList();
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all mappings of object B</li>
		 * <li>object B contains all mappings of object A</li>
		 * <li>if <code>wrappedMap</code> is <code>ISortedMap</code> or <code>wrappedMap</code> is <code>ArrayMap</code>, order is considered, otherwise not.</li>
		 * </ul></p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var o:IMap = other as IMap;
			
			if (!o) return false;
			
			if (getKeys().size() != o.getKeys().size()) return false;
			
			return _wrappedMap.equals(other);
			
			/*
			var it:IIterator = iterator();
			var itOther:IIterator = o.iterator();
			var value:*;
			
			if (wrappedMap is ISortedMap || wrappedMap is ArrayMap)
			{
				while (it.hasNext())
				{
					value = it.next();
					
					if (value != itOther.next()) return false;
				}
			}
			else
			{
				while (it.hasNext())
				{
					value = it.next();
					
					if (!o.containsKey(it.pointer()) || o.getValue(it.pointer()) != value) return false;
				}
			}
			
			return true;
			*/
		}

		/**
		 * Forwards the call to <code>wrappedMap.getKeys</code>.
		 * 
		 * @return
 		 */
		public function getKeys(): IList
		{
			return wrappedMap.getKeys();
		}

		/**
		 * Forwards the call to <code>wrappedMap.getValue</code>.
		 * 
		 * @param key
		 */
		public function getValue(key:*): *
		{
			return wrappedMap.getValue(key);
		}

		/**
		 * Forwards the call to <code>wrappedMap.getValues</code>.
		 * 
		 * @return
 		 */
		public function getValues(): IList
		{
			return wrappedMap.getValues();
		}

		/**
		 * Forwards the call to <code>wrappedMap.isEmpty</code>.
		 * 
		 * @return
 		 */
		public function isEmpty(): Boolean
		{
			return wrappedMap.isEmpty();
		}

		/**
		 * Returns <code>true</code> if the type of all keys and values of the <code>map</code> argument is compatible with the type of this map.
		 * 
		 * @param  	map 	the map to check the type of the keys and values.
		 * @return 	<code>true</code> if the type of all keys and values of the <code>map</code> argument is compatible with the type of this map.
		 */
		public function isValidMap(map:IMap): Boolean
		{
			if (!map) return false;
			if (map.isEmpty()) return true;
			
			var it:IIterator = map.iterator();
			
			while (it.hasNext())
			{
				if (!isValidValueType(it.next())) return false;
				if (!isValidKeyType(it.pointer())) return false;
			}
			
			return true;
		}

		/**
		 * Returns <code>true</code> if the type of the key is compatible with the type of this map.
		 * 
		 * @param  	key 	the key to check the type.
		 * @return 	<code>true</code> if the type of the key is compatible with the type of this map.
		 */
		public function isValidKeyType(key:*): Boolean
		{
			return key is _typeKeys;
		}

		/**
		 * Returns <code>true</code> if the type of the value is compatible with the type of this map.
		 * 
		 * @param  	value 	the value to check the type.
		 * @return 	<code>true</code> if the type of the value is compatible with the type of this map.
		 */
		public function isValidValueType(value:*): Boolean
		{
			return value is _typeValues;
		}

		/**
		 * Forwards the call to <code>wrappedMap.iterator</code>.
		 * 
		 * @return
 		 */
		public function iterator(): IIterator
		{
			return wrappedMap.iterator();
		}

		/**
		 * The key and value are validated with the <code>validateKeyType</code> and <code>validateValueType</code> methods to be forwarded to <code>wrappedMap.put</code>.
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key or value is incompatible with this map.
		 * @return 	the return of the call <code>wrappedMap.put</code>.
		 */
		public function put(key:*, value:*): *
		{
			validateKeyType(key);
			validateValueType(value);
			return _wrappedMap.put(key, value);
		}

		/**
		 * The map is validated with the <code>validateMap</code> method to be forwarded to <code>wrappedMap.putAll</code>.
		 * 
		 * @param map
		 */
		public function putAll(map:IMap): void
		{
			validateMap(map);
			_wrappedMap.putAll(map);
		}

		/**
		 * The objects is validated to be forwarded to <code>wrappedMap.putAllByObject</code>.
		 * 
		 * @param o
		 */
		public function putAllByObject(o:Object): void
		{
			var map:IMap = new HashMap();
			map.putAllByObject(o);
			validateMap(map);
			
			_wrappedMap.putAllByObject(o);
		}

		/**
		 * The entry is validated with the <code>validateKeyType</code> and <code>validateValueType</code> methods to be forwarded to <code>wrappedMap.putEntry</code>.
		 * 
		 * @param entry
		 */
		public function putEntry(entry:IMapEntry): *
		{
			validateKeyType(entry.key);
			validateValueType(entry.value);
			return _wrappedMap.putEntry(entry);
		}

		/**
		 * Forwards the call to <code>wrappedMap.remove</code>.
		 * 
		 * @param key
		 */
		public function remove(key:*): *
		{
			return _wrappedMap.remove(key);
		}

		/**
		 * Forwards the call to <code>wrappedMap.removeAll</code>.
		 * 
		 * @param keys
		 * @return
		 */
		public function removeAll(keys:ICollection): Boolean
		{
			return _wrappedMap.removeAll(keys);
		}

		/**
		 * Forwards the call to <code>wrappedMap.retainAll</code>.
		 * 
		 * @param keys
		 * @return
		 */
		public function retainAll(keys:ICollection): Boolean
		{
			return _wrappedMap.retainAll(keys);
		}

		/**
		 * Forwards the call to <code>wrappedMap.size</code>.
		 * 
		 * @return
 		 */
		public function size(): int
		{
			return _wrappedMap.size();
		}

		/**
		 * Returns the string representation of this instance.
		 * 
		 * @return 	the string representation of this instance.
 		 */
		public function toString():String 
		{
			var s		:String = "{";
			var it		:IIterator = iterator();
			var value	:*;
			
			while (it.hasNext())
			{
				value 	= it.next();
				
				s 		+= it.pointer() + "=" + value;
				if (it.hasNext()) s += ",";
			}
			
			s += "}";
			
			return s;
		}

		/**
		 * Checks if the type of all keys and values of the <code>map</code> argument is compatible with the type of this map.
		 * 
		 * @param  map 	the map to check the type of the keys and values.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more keys or values in the <code>map</code> argument are incompatible with the type of this map. 	
		 */
		public function validateMap(map:IMap): void
		{
			if (!map) return;
			if (map.isEmpty()) return;
			
			var it:IIterator = map.iterator();
			
			while (it.hasNext())
			{
				validateValueType(it.next());
				validateKeyType(it.pointer());
			}
		}

		/**
		 * Checks if the type of the key is compatible with the type of this map.
		 * 
		 * @param  	key 	the key to check the type.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the key is incompatible with the type of this map.
		 */
		public function validateKeyType(key:*): void
		{
			if (!isValidKeyType(key)) throw new ClassCastError("Invalid key type. key: " + key + " | type: " + ReflectionUtil.getClassPath(key) + " | expected key type: " + ReflectionUtil.getClassPath(_typeKeys));
		}

		/**
		 * Checks if the type of the value is compatible with the type of this map.
		 * 
		 * @param  	value 	the value to check the type.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the value is incompatible with the type of this map.
		 */
		public function validateValueType(value:*): void
		{
			if (!isValidValueType(value)) throw new ClassCastError("Invalid value type. value: " + value + " | type: " + ReflectionUtil.getClassPath(value) + " | expected value type: " + ReflectionUtil.getClassPath(_typeValues));
		}

	}

}