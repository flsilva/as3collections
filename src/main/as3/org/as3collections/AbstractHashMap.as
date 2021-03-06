﻿/*
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
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	/**
	 * This class provides a skeletal hash table based implementation of the <code>IMap</code> interface, to minimize the effort required to implement this interface.
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>This class maintains a native <code>flash.utils.Dictionary</code> object as its source.</p>
	 * <p>This class makes no guarantees as to the order of the map.
	 * In particular, it does not guarantee that the order will remain constant over time.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the map being implemented admits a more efficient implementation.</p>
	 * <p><b>IMPORTANT:</b></p>
	 * <p>This class implements equality through <code>org.as3coreaddendum.system.IEquatable</code> interface in the <code>equals</code> method and in all methods that compares the elements inside this collection (i.e. <code>containsKey</code>, <code>containsValue</code>, <code>put</code>, <code>remove</code>, <code>removeAll</code> and <code>retainAll</code>).</p>
	 * <p>In order to this map uses the <code>equals</code> method of its keys and/or values in comparisons (rather than default '==' operator), <b>all keys and/or values in this map must implement the</b> <code>org.as3coreaddendum.system.IEquatable</code> <b>interface and also the supplied key and/or value.</b></p>
	 * <p>For example:</p>
	 * <p>myMap.containsKey(myKey);</p>
	 * <p>All keys (but in this case only keys) inside <code>myMap</code>, and <code>myKey</code>, must implement the <code>org.as3coreaddendum.system.IEquatable</code> interface so that <code>equals</code> method of each key can be used in the comparison.
	 * Otherwise '==' operator is used. The same is true for values.
	 * The use of equality for keys and values are independent.
	 * It's possible to use only keys that implement <code>IEquatable</code>, only values, both, or none.
	 * This usage varies according to application needs.</p>
	 * <p>All subclasses of this class <em>must</em> conform with this behavior.</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @see 	org.as3collections.IMap IMap
	 * @see 	org.as3collections.HashMap HashMap
	 * @see 	org.as3collections.AbstractListMap AbstractListMap
	 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
	 * @author Flávio Silva
	 */
	public class AbstractHashMap implements IMap
	{
		/**
		 * @private
		 */
		private var _totalKeysEquatable: int;
		private var _totalValuesEquatable: int;

		/**
		 * @private
		 */
		protected var _size: int;

		private var _map: Dictionary;
		private var _values: Dictionary;// used only by containsValue() IF allValuesEquatable = false
		private var _weakKeys: Boolean;

		/**
		 * @inheritDoc
		 */
		public function get allKeysEquatable(): Boolean { return _totalKeysEquatable == size(); }

		/**
		 * @inheritDoc
		 */
		public function get allValuesEquatable(): Boolean { return _totalValuesEquatable == size(); }

		/**
		 * @private
		 */
		protected function get map(): Dictionary { return _map; }

		/**
		 * @private
		 */
		protected function get values(): Dictionary { return _values; }

		/**
		 * Constructor, creates a new <code>AbstractHashMap</code> object.
		 * 
		 * @param 	source 		a map with wich fill this map.
		 * @param 	weakKeys 	instructs the backed <code>Dictionary</code> object to use "weak" references on object keys. If the only reference to an object is in the specified <code>Dictionary</code> object, the key is eligible for garbage collection and is removed from the table when the object is collected.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractHashMap(source:IMap = null, weakKeys:Boolean = false)
		{
			if (ReflectionUtil.classPathEquals(this, AbstractHashMap))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
			
			_weakKeys = weakKeys;
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
		 * Returns <code>true</code> if this map contains a mapping for the specified key.
		 * <p>If all keys in this map and <code>key</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this map using <code>equals</code> method of the keys.
		 * Otherwise this implementation uses <code>Dictionary[key] !== undefined</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 */
		public function containsKey(key:*): Boolean
		{
			if (allKeysEquatable && key is IEquatable) return containsKeyByEquality(key);
			return _map[key] !== undefined;
		}

		/**
		 * Returns <code>true</code> if this map maps one or more keys to the specified value.
		 * <p>If all values in this map and <code>value</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this map using <code>equals</code> method of the values.
		 * Otherwise this implementation uses <code>Dictionary[value] !== undefined</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified value is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified value is <code>null</code> and this map does not permit <code>null</code> values (optional).
		 */
		public function containsValue(value:*): Boolean
		{
			if (allValuesEquatable && value is IEquatable) return containsValueByEquality(value);
			return _values[value] !== undefined;
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the mappings contained in this map.
		 * The type of the objects within the list is <code>IMapEntry</code>
		 * <p>There's no guarantee that the order will remain constant over time.</p>
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the mappings contained in this map.
		 * @see org.as3collections.IMapEntry IMapEntry
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function entryCollection(): ICollection
		{
			var list:IList = new ArrayList();
			var entry:IMapEntry;
			
			for (var key:* in _map)
			{
				entry = new MapEntry(key, _map[key]);
				list.add(entry);
			}
			
			return list;
		}
		
		/**
		 * This method uses <code>MapUtil.equalNotConsideringOrder</code> method to perform equality, sending this map and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.MapUtil#equalNotConsideringOrder() MapUtil.equalNotConsideringOrder()
		 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
		 */
		public function equals(other:*): Boolean
		{
			return MapUtil.equalNotConsideringOrder(this, other);
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the keys contained in this map.
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the keys contained in this map.
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function getKeys(): ICollection
		{
			var list:IList = new ArrayList();
			
			for (var key:* in _map)
			{
				list.add(key);
			}
			
			return list;
		}

		/**
		 * Returns the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 * <p>If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contains no mapping for the key.
		 * It's possible that the map explicitly maps the key to <code>null</code>.
		 * The <code>containsKey</code> method may be used to distinguish these two cases.</p>
		 * <p>If all keys in this map and <code>key</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this map using <code>equals</code> method of the keys.
		 * Otherwise this implementation returns <code>Dictionary[key]</code>.</p>
		 * 
		 * @param  	key 	the key whose associated value is to be returned.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 */
		public function getValue(key:*): *
		{
			if (allKeysEquatable && key is IEquatable) return getValueByEquality(key);
			return _map[key];
		}

		/**
		 * Returns an <code>ArrayList</code> object that is a view of the values contained in this map.
		 * <p>Modifications in the <code>ArrayList</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ArrayList</code> object that is a view of the values contained in this map.
		 * @see org.as3collections.IList IList
		 * @see org.as3collections.lists.ArrayList ArrayList
 		 */
		public function getValues(): ICollection
		{
			var list:IList = new ArrayList();
			
			for each (var value:* in _map)
			{
				list.add(value);
			}
			
			return list;
		}

		/**
		 * @inheritDoc
 		 */
		public function isEmpty(): Boolean
		{
			return _size == 0;
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
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value.
		 * (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>put</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key or value is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified key or value is <code>null</code> and this map does not permit <code>null</code> keys or values.
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
		 * @throws 	ArgumentError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 */
		public function putAll(map:IMap): void
		{
			if (!map) throw new ArgumentError("The 'map' argument must not be 'null'.");
			
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
		 * @throws 	ArgumentError  			if the specified object is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified object contains <code>null</code> keys or values.
		 */
		public function putAllByObject(o:Object): void
		{
			if (!o) throw new ArgumentError("The 'o' argument must not be 'null'.");
			
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
		 * @throws 	ArgumentError  			if the specified entry is <code>null</code>, or if the specified <code>entry.key</code> or <code>entry.value</code> is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with <code>entry.key</code>, or <code>null</code> if there was no mapping for <code>entry.key</code>. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with <code>entry.key</code>, if the implementation supports <code>null</code> values.)
		 */
		public function putEntry(entry:IMapEntry): *
		{
			if (!entry) throw new ArgumentError("The 'entry' argument must not be 'null'.");
			
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
		 * @throws 	ArgumentError  			if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for <code>key</code>.
		 */
		public function remove(key:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes the mapping for a key from this map (if it is present) for each element in the specified collection (optional operation).
		 * The elements in the specified collection are interpreted as keys.
		 * <p>This implementation iterates over this map, checking each key returned by the iterator in turn to see if it's contained in the specified <code>keys</code> collection (using <code>contains</code> method of the <code>keys</code> argument).
		 * If it's so contained, it's removed from this map with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this map contains one or more keys in common with the specified collection.</p>
		 * <p>The map will not contain mappings for the elements in the specified collection once the call returns.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of an element in the specified collection is incompatible with this map (optional).
		 * @throws 	ArgumentError  											if the specified collection is <code>null</code>, or if this map does not permit <code>null</code> keys, and the specified collections contains <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		public function removeAll(keys:ICollection): Boolean
		{
			if (!keys) throw new ArgumentError("The 'keys' argument must not be 'null'.");
			if (keys.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if (keys.contains(it.pointer())) it.remove();
			}
			
			return prevSize != size();
		}

		/**
		 * Retains only the mappings in this map that the keys are contained (as elements) in the specified collection (optional operation).
		 * In other words, removes from this map all of its mappings whose keys are not contained (as elements) in the specified <code>keys</code> collection (using <code>contains</code> method of the <code>keys</code> argument).
		 * The elements in the specified collection are interpreted as keys.
		 * <p>This implementation iterates over this map and calls <code>IIterator.remove</code> once for each key that are not contained in the specified collection.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this map contains one or more keys not present in the specified collection.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be retained in the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more keys in this map are incompatible with the specified collection (optional).
		 * @throws 	ArgumentError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> keys (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		public function retainAll(keys:ICollection): Boolean
		{
			if (!keys) throw new ArgumentError("The 'keys' argument must not be 'null'.");
			if (keys.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				
				if (!keys.contains(it.pointer())) it.remove();
			}
			
			return prevSize != size();
		}

		/**
		 * @inheritDoc
 		 */
		public function size(): int
		{
			return _size;
		}

		/**
		 * Returns the string representation of this instance.
		 * <p>This method uses <code>MapUtil.toString</code> method.</p>
		 * 
		 * @return 	the string representation of this instance.
		 * @see 	org.as3collections.utils.MapUtil#toString() MapUtil.toString()
 		 */
		public function toString():String 
		{
			return MapUtil.toString(this);
		}
		
		/**
		 * @private
		 */
		private function containsKeyByEquality(key:*): Boolean
		{
			var it:IIterator = iterator();
			var $key:IEquatable;
			
			while (it.hasNext())
			{
				it.next();
				$key = it.pointer();
				if ($key.equals(key)) return true;
			}
			
			return false;
		}

		/**
		 * @private
		 */
		private function containsValueByEquality(value:*): Boolean
		{
			var it:IIterator = iterator();
			var $value:IEquatable;
			
			while (it.hasNext())
			{
				$value = it.next();
				if ($value.equals(value)) return true;
			}
			
			return false;
		}

		/**
		 * @private
		 */
		protected function getValueByEquality(key:*) :*
		{
			var it:IIterator = iterator();
			var $key:IEquatable;
			var value:*;
			var returnValue:*;
			
			while (it.hasNext())
			{
				value = it.next();
				$key = it.pointer();
				
				if ($key.equals(key))
				{
					returnValue = value;
					break;
				}
			}
			
			return returnValue;
		}
		
		/**
		 * @private
		 */
		protected function keyAdded(key:*): void
		{
			if (key && key is IEquatable) _totalKeysEquatable++;
		}
		
		/**
		 * @private
		 */
		protected function keyRemoved(key:*): void
		{
			if (key && key is IEquatable) _totalKeysEquatable--;
		}
		
		/**
		 * @private
		 */
		protected function valueAdded(value:*): void
		{
			if (value && value is IEquatable) _totalValuesEquatable++;
		}
		
		/**
		 * @private
		 */
		protected function valueRemoved(value:*): void
		{
			if (value && value is IEquatable) _totalValuesEquatable--;
		}
		
		/**
		 * @private
		 */
		protected function _init(): void
		{
			_map 		= new Dictionary(_weakKeys);
			_values 	= new Dictionary(_weakKeys);
			_size 		= 0;
			_totalKeysEquatable = 0;
			_totalValuesEquatable = 0;
		}

	}

}