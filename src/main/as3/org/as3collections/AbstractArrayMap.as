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

package org.as3collections
{
	import org.as3collections.lists.ArrayList;
	import org.as3collections.utils.MapUtil;
	import org.as3coreaddendum.errors.CloneNotSupportedError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides a skeletal array-based implementation of the <code>IMap</code> interface, to minimize the effort required to implement this interface.
	 * It's backed by the <code>Array</code> class.
	 * <p>This class makes guarantees as to the order of the map.
	 * The order in which elements are stored is the order in which they were inserted.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the map being implemented admits a more efficient implementation.</p>
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p> 
	 * 
	 * @author Flávio Silva
	 */
	public class AbstractArrayMap implements IMap
	{
		/**
		 * @private
		 */
		protected var _allKeysEquatable: Boolean = true;
		protected var _allValuesEquatable: Boolean = true;

		private var _keys: Array;
		private var _values: Array;

		/**
		 * @inheritDoc
		 */
		public function get allKeysEquatable(): Boolean { return _allKeysEquatable; }

		/**
		 * @inheritDoc
		 */
		public function get allValuesEquatable(): Boolean { return _allValuesEquatable; }

		/**
		 * @private
		 */
		protected function get keys(): Array { return _keys; }

		/**
		 * @private
		 */
		protected function get values(): Array { return _values; }

		/**
		 * Constructor, creates a new AbstractArrayMap object.
		 * 
		 * @param 	source 	a map with wich fill this map.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractArrayMap(source:IMap = null)
		{
			if (ReflectionUtil.classPathEquals(this, AbstractArrayMap))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
			
			_init();
			
			if (source && !source.isEmpty()) putAll(source);
		}

		/**
		 * Removes all of the mappings from this map (optional operation).
		 * The map will be empty after this call returns.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>clear</code> operation is not supported by this map.
		 */
		public function clear(): void
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Creates and return a shallow copy of this collection.
		 * <p>This implementation always throws a <code>CloneNotSupportedError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.CloneNotSupportedError  	if this map doesn't support clone.
		 * @return 	A new object that is a shallow copy of this instance.
 		 */
		public function clone(): *
		{
			throw new CloneNotSupportedError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * @inheritDoc
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 */
		public function containsKey(key:*): Boolean
		{
			return indexOfKey(key) != -1;
		}

		/**
		 * @inheritDoc
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified value is incompatible with this map (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified value is <code>null</code> and this map does not permit <code>null</code> values (optional).
		 */
		public function containsValue(value:*): Boolean
		{
			return indexOfValue(value) != -1;
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the mappings contained in this map (in the same order).
		 * The type of the objects within the list is <code>IMapEntry</code>
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the mappings contained in this map.
		 * @see org.as3collections.IMapEntry IMapEntry
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function entryList(): IList
		{
			var list:IList = new ArrayList();
			var it:IIterator = iterator();
			var value:*;
			var entry:IMapEntry;
			
			while (it.hasNext())
			{
				value = it.next();
				entry = new MapEntry(it.pointer(), value);
				list.add(entry);
			}
			
			return list;
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all mappings of object B</li>
		 * <li>object B contains all mappings of object A</li>
		 * <li>mappings have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the mappings in the map.
		 * So, for two maps are equal the order of mappings returned by the iterator must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var o:IMap = other as IMap;
			
			if (o.size() != size()) return false;
			
			var it:IIterator = entryList().iterator();
			var itOther:IIterator = o.entryList().iterator();
			
			while (it.hasNext())
			{
				if (!(it.next() as IMapEntry).equals(itOther.next())) return false;
			}
			
			return true;
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the keys contained in this map.
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the keys contained in this map.
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function getKeys(): IList
		{
			return new ArrayList(_keys);
		}

		/**
		 * @inheritDoc
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 */
		public function getValue(key:*): *
		{
			if (!containsKey(key)) return null;
			return _values[indexOfKey(key)];
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the values contained in this map.
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the values contained in this map.
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function getValues(): IList
		{
			return new ArrayList(_values);
		}

		/**
		 * Returns the position of the specified key.
		 * 
		 * @param  	key 	the key to search for.
		 * @return 	the position of the specified key.
 		 */
		public function indexOfKey(key:*): int
		{
			if (allKeysEquatable && key is IEquatable) return indexOfKeyByEquality(key);
			return _keys.indexOf(key);
		}

		/**
		 * Returns the position of the specified value.
		 * 
		 * @param  	value 	the value to search for.
		 * @return 	the position of the specified value.
 		 */
		public function indexOfValue(value:*): int
		{
			if (allValuesEquatable && value is IEquatable) return indexOfValueByEquality(value);
			return _values.indexOf(value);
		}

		/**
		 * @inheritDoc
 		 */
		public function isEmpty(): Boolean
		{
			return size() == 0;
		}

		/**
		 * Returns an iterator over a set of mappings.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @return 	an iterator over a set of values.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	this method must be overridden in subclass.
 		 */
		public function iterator(): IIterator
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Associates the specified value with the specified key in this map (optional operation).
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value, and the order of the key is not affected. (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>put</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key or value is incompatible with this map.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified key or value is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for key. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with key, if the implementation supports <code>null</code> values.)
		 */
		public function put(key:*, value:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 * The effect of this call is equivalent to that of calling <code>put(k, v)</code> on this map once for each mapping from key <code>k</code> to value <code>v</code> in the specified map.
		 * <p>This implementation iterates over the specified map, and calls this map's <code>put</code> operation once for each entry returned by the iteration.</p>
		 * 
		 * @param  	map 	mappings to be stored in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified map is incompatible with this map.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 */
		public function putAll(map:IMap): void
		{
			if (!map) throw new NullPointerError("The 'map' argument must not be 'null'.");
			
			var it:IIterator = map.iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				put(it.pointer(), value);
			}
		}

		/**
		 * This implementation performs a <code>for..in</code> in the specified object, calling <code>put</code> on this map once for each iteration (optional operation).
		 * 
		 * @param  	o 	the object to retrieve the properties.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAllByObject</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified object is incompatible with this map.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified object is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified object contains <code>null</code> keys or values.
		 */
		public function putAllByObject(o:Object): void
		{
			if (!o) throw new NullPointerError("The 'o' argument must not be 'null'.");
			
			for (var key:* in o)
			{
				put(key, o[key]);
			}
		}

		/**
		 * Associates the specified <code>entry.value</code> with the specified <code>entry.key</code> in this map (optional operation).
		 * If the map previously contained a mapping for the <code>entry.key</code>, the old value is replaced by the specified <code>entry.value</code>. (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * <p>This implementation calls <code>put(entry.key, entry.value)</code>.</p>
		 * 
		 * @param  	entry 	entry to put in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putEntry</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified <code>entry.key</code> or <code>entry.value</code> is incompatible with this map.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified entry is <code>null</code>, or if the specified <code>entry.key</code> or <code>entry.value</code> is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with <code>entry.key</code>, or <code>null</code> if there was no mapping for <code>entry.key</code>. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with <code>entry.key</code>, if the implementation supports <code>null</code> values.)
		 */
		public function putEntry(entry:IMapEntry): *
		{
			if (!entry) throw new NullPointerError("The 'entry' argument must not be 'null'.");
			
			return put(entry.key, entry.value);
		}

		/**
		 * Removes the mapping for a key from this map if it is present (optional operation).
		 * <p>Returns the value to which this map previously associated the key, or <code>null</code> if the map contained no mapping for the key.
		 * If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contained no mapping for the key. It's possible that the map explicitly mapped the key to <code>null</code>.</p>
		 * <p>The map will not contain a mapping for the specified key once the call returns.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	key 	the key whose mapping is to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key is incompatible with this map (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for <code>key</code>.
		 */
		public function remove(key:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes the mapping for a key from this map (if it is present) for each element in the specified collection (optional operation).
		 * The elements in the specified collection are interpreted as keys.
		 * <p>This implementation iterates over this map, checking each key returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's so contained, it's removed from this map with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this map contains one or more keys in common with the specified collection.</p>
		 * <p>The map will not contain mappings for the elements in the specified collection once the call returns.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of an element in the specified collection is incompatible with this map (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  			if the specified collection is <code>null</code>, or if this map does not permit <code>null</code> keys, and the specified collections contains <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		public function removeAll(keys:ICollection): Boolean
		{
			if (!keys) throw new NullPointerError("The 'keys' argument must not be 'null'.");
			if (keys.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				if (keys.contains(it.pointer())) it.remove();
			}
			
			checkAllKeysEquatable();
			checkAllValuesEquatable();
			
			return prevSize != size();
		}

		/**
		 * Retains only the mappings in this map that the keys are contained (as elements) in the specified collection (optional operation).
		 * In other words, removes from this map all of its mappings whose keys are not contained (as elements) in the specified collection.
		 * The elements in the specified collection are interpreted as keys.
		 * <p>This implementation iterates over this map and calls <code>IIterator.remove</code> once for each key that are not contained in the specified collection.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this map contains one or more keys not present in the specified collection.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be retained in the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more keys in this map are incompatible with the specified collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> keys (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		public function retainAll(keys:ICollection): Boolean
		{
			if (!keys) throw new NullPointerError("The 'keys' argument must not be 'null'.");
			if (keys.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				
				if (!keys.contains(it.pointer())) it.remove();
			}
			
			checkAllKeysEquatable();
			checkAllValuesEquatable();
			
			return prevSize != size();
		}

		/**
		 * @inheritDoc
 		 */
		public function size(): int
		{
			return _keys.length;
		}

		/**
		 * Returns the string representation of this instance.
		 * 
		 * @return 	the string representation of this instance.
 		 */
		public function toString():String 
		{
			return MapUtil.toString(this);
		}

		/**
		 * @private
		 */
		protected function checkAllKeysEquatable(): void
		{
			_allKeysEquatable = true;
			
			var it:IIterator = getKeys().iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				if (!isEquatable(e))
				{
					_allKeysEquatable = false;
					return;
				}
			}
		}

		/**
		 * @private
		 */
		protected function checkAllValuesEquatable(): void
		{
			_allValuesEquatable = true;
			
			var it:IIterator = getValues().iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				if (!isEquatable(e))
				{
					_allValuesEquatable = false;
					return;
				}
			}
		}

		/**
		 * @private
		 */
		protected function checkKeyEquatable(key:*): void
		{
			if (!isEquatable(key)) _allKeysEquatable = false;
		}

		/**
		 * @private
		 */
		protected function checkValueEquatable(value:*): void
		{
			if (!isEquatable(value)) _allValuesEquatable = false;
		}

		/**
		 * @private
		 */
		protected function indexOfKeyByEquality(key:*): int
		{
			var it:IIterator = getKeys().iterator();
			var e:IEquatable;
			
			while (it.hasNext())
			{
				e = it.next();
				if (e.equals(key)) return it.pointer();
			}
			
			return -1;
		}

		/**
		 * @private
		 */
		protected function indexOfValueByEquality(value:*): int
		{
			var it:IIterator = getValues().iterator();
			var e:IEquatable;
			
			while (it.hasNext())
			{
				e = it.next();
				if (e.equals(value)) return it.pointer();
			}
			
			return -1;
		}

		/**
		 * @private
		 */
		protected function isEquatable(element:*): Boolean
		{
			if (element is IEquatable) return true;
			return false;
		}

		/**
		 * @private
		 */
		protected function _init(): void
		{
			_keys 		= [];
			_values 	= [];
			_allKeysEquatable = true;
			_allValuesEquatable = true;
		}

	}

}