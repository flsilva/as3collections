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
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.lists.ArrayList;
	import org.as3collections.utils.MapUtil;
	import org.as3coreaddendum.errors.CloneNotSupportedError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides a skeletal implementation of the <code>IListMap</code> interface, to minimize the effort required to implement this interface.
	 * <p>This class maintains two <code>ArrayList</code> objects as its source, one for <code>keys</code> and one for <code>values</code>.</p>
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>This class makes guarantees as to the order of the map.
	 * The order in which elements are stored is the order in which they were inserted.</p>
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
	 * 
	 * @see 	org.as3collections.IListMap IListMap
	 * @see 	org.as3collections.IList IList
	 * @see 	org.as3collections.lists.ArrayList ArrayList
	 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
	 * @author Flávio Silva
	 */
	public class AbstractListMap implements IListMap
	{
		/**
		 * @private
		 */
		protected var _modCount: int;

		private var _keys: IList;
		private var _values: IList;
		
		/**
		 * @inheritDoc
		 */
		public function get allKeysEquatable(): Boolean { return _keys.allEquatable; }

		/**
		 * @inheritDoc
		 */
		public function get allValuesEquatable(): Boolean { return _values.allEquatable; }
		
		/**
		 * @inheritDoc
		 */
		public function get modCount(): int { return _modCount; }
		
		/**
		 * @private
		 */
		protected function get keys(): IList { return _keys; }
		protected function set keys(value:IList): void { _keys = value; }

		/**
		 * @private
		 */
		protected function get values(): IList { return _values; }
		protected function set values(value:IList): void { _values = value; }

		/**
		 * Constructor, creates a new AbstractListMap object.
		 * 
		 * @param 	source 	a map with wich fill this map.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractListMap(source:IMap = null)
		{
			if (ReflectionUtil.classPathEquals(this, AbstractListMap))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
			
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
		 * @throws 	ArgumentError	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 */
		public function containsKey(key:*): Boolean
		{
			return indexOfKey(key) != -1;
		}

		/**
		 * @inheritDoc
		 * 
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified value is incompatible with this map (optional).
		 * @throws 	ArgumentError	if the specified value is <code>null</code> and this map does not permit <code>null</code> values (optional).
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
		public function entryCollection(): ICollection
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
		 * This method uses <code>MapUtil.equalConsideringOrder</code> method to perform equality, sending this map and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.MapUtil#equalConsideringOrder() MapUtil.equalConsideringOrder()
		 */
		public function equals(other:*): Boolean
		{
			return MapUtil.equalConsideringOrder(this, other);
		}
		
		/**
		 * Returns the key at the specified position in this map.
		 * <p>This implementation forwards the call to <code>keys.getAt(index)</code>.</p>
		 * 
		 * @param 	index 	index of the key to return.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the key at the specified position in this map.
		 */
		public function getKeyAt(index:int): *
		{
			return keys.getAt(index);
		}
		
		/**
		 * Returns the value at the specified position in this map.
		 * <p>This implementation forwards the call to <code>values.getAt(index)</code>.</p>
		 * 
		 * @param 	index 	index of the value to return.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the value at the specified position in this map.
		 */
		public function getValueAt(index:int): *
		{
			return values.getAt(index);
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
			return _keys.clone();
		}

		/**
		 * Returns the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 * <p>If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contains no mapping for the key.
		 * It's possible that the map explicitly maps the key to <code>null</code>.
		 * The <code>containsKey</code> method may be used to distinguish these two cases.</p>
		 * <p>This implementation uses <code>indexOfKey</code> method to get the index of the key/value and then calls <code>values.getAt</code> method.</p>
		 * 
		 * @param  	key 	the key whose associated value is to be returned.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 */
		public function getValue(key:*): *
		{
			var indexKey:int = indexOfKey(key);
			if (indexKey == -1) return null;
			
			return _values.getAt(indexKey);
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
			return _values.clone();
		}
		
		/**
		 * Returns a new <code>IListMap</code> object that is a view of the portion of this map whose keys are strictly less than <code>toKey</code>.
		 * The returned map supports all optional map operations that this map supports.
		 * <p>This implementation uses <code>subMap(0, indexOfKey(toKey))</code>.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> unless <code>subMap</code> is overridden.</p>
		 * 
		 * @param  	toKey 	high endpoint (exclusive) of the keys in the returned map.
		 * @throws 	ArgumentError 	if <code>toKey</code> is <code>null</code> and this map does not permit <code>null</code> keys.
		 * @throws 	ArgumentError 	if <code>containsKey(toKey)</code> returns <code>false</code>.
		 * @return 	a new <code>IListMap</code> that is a view of the portion of this map whose keys are strictly less than <code>toKey</code>.
		 */
		public function headMap(toKey:*): IListMap
		{
			if (!containsKey(toKey)) throw new ArgumentError("This maps does not contains the specified key: " + toKey);
			
			var fromIndex:int = 0;
			var toIndex:int = indexOfKey(toKey);
			
			var map:IListMap = subMap(fromIndex, toIndex);
			return map;
		}
		
		/**
		 * Returns the position of the specified key.
		 * <p>This implementation forwards the call to <code>keys.indexOf(key)</code>.</p>
		 * 
		 * @param  	key 	the key to search for.
		 * @return 	the position of the specified key.
 		 */
		public function indexOfKey(key:*): int
		{
			return _keys.indexOf(key);
		}

		/**
		 * Returns the position of the specified value.
		 * <p>This implementation forwards the call to <code>values.indexOf(value)</code>.</p>
		 * 
		 * @param  	value 	the value to search for.
		 * @return 	the position of the specified value.
 		 */
		public function indexOfValue(value:*): int
		{
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
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Associates the specified value with the specified key in this map (optional operation).
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value, and the order of the key is not affected.
		 * (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>put</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key or value is incompatible with this map.
		 * @throws 	ArgumentError											if the specified key or value is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for key. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with key, if the implementation supports <code>null</code> values.)
		 */
		public function put(key:*, value:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * Associates the specified value with the specified key at the specified position in this map (optional operation).
		 * Shifts the entry currently at that position (if any) and any subsequent entries to the right (adds one to their indices).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index at which the specified entry is to be inserted.
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key or value is incompatible with this map.
		 * @throws 	ArgumentError  											if the specified key or value is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @throws 	ArgumentError  											if this map already contains the specified key.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 */
		public function putAt(index:int, key:*, value:*): void
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 * The effect of this call is equivalent to that of calling <code>put(k, v)</code> on this map once for each mapping from key <code>k</code> to value <code>v</code> in the specified map.
		 * <p>This implementation calls <code>putAllAt(size(), collection)</code>.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> unless <code>putAt</code> is overridden (assuming the specified map is non-empty).</p>
		 * 
		 * @param  	map 	mappings to be stored in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified map is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 */
		public function putAll(map:IMap): void
		{
			putAllAt(size(), map);
		}
		
		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 * Shifts the entry currently at that position (if any) and any subsequent entries to the right (increases their indices).
		 * The new entries will appear in this map in the order that they are returned by the specified map's iterator.
		 * <p>This implementation iterates over the specified map, and calls this map's <code>putAt</code> operation once for each entry returned by the iteration.</p>
		 * 
		 * @param  	index 	index at which to insert the first entry from the specified map.
		 * @param  	map 	mappings to be stored in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAllAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified map is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 */
		public function putAllAt(index:int, map:IMap): void
		{
			if (!map) throw new ArgumentError("The 'map' argument must not be 'null'.");
			if (map.isEmpty()) return;
			checkIndex(index, size());
			
			var it:IIterator = map.iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				
				putAt(index, it.pointer(), value);
				index++;
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
		 * If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contained no mapping for the key.
		 * It's possible that the map explicitly mapped the key to <code>null</code>.</p>
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
		 * <p>This implementation iterates over this map, checking each key returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's so contained, it's removed from this map with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this map contains one or more keys in common with the specified collection.</p>
		 * <p>The map will not contain mappings for the elements in the specified collection once the call returns.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of an element in the specified collection is incompatible with this map (optional).
		 * @throws 	ArgumentError  			if the specified collection is <code>null</code>, or if this map does not permit <code>null</code> keys, and the specified collections contains <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		public function removeAll(keys:ICollection): Boolean
		{
			if (!keys) throw new ArgumentError("The 'keys' argument must not be 'null'.");
			if (keys.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				
				if (keys.contains(it.pointer())) it.remove();
			}
			
			return prevSize != size();
		}
		
		/**
		 * Removes the mapping at the specified position in this map (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts one from their indices).
		 * Returns an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p> 
		 * 
		 * @param  	index 	the index of the mapping to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map.
		 */
		public function removeAt(index:int): IMapEntry
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
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
		public function reverse(): void
		{
			if (size() < 2) return;
			keys.reverse();
			values.reverse();
		}
		
		/**
		 * Removes all of the mappings whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing mappings (inclusive).
		 * @param  	toIndex 	the index to stop removing mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new map containing all the removed mappings.
		 */
		public function removeRange(fromIndex:int, toIndex:int): IListMap
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * Replaces the key at the specified position in this map with the specified key (optional operation).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index of the key to replace.
		 * @param  	key 	key to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setKeyAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified key prevents it from being added to this map.
		 * @throws 	ArgumentError  	 										if the specified key is <code>null</code> and this map does not permit <code>null</code> keys.
		 * @throws 	ArgumentError  											if this map already contains the specified key.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the key previously at the specified position.
		 */
		public function setKeyAt(index:int, key:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * Replaces the value at the specified position in this map with the specified value (optional operation).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index of the value to replace.
		 * @param  	value 	value to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setValueAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified value prevents it from being added to this map.
		 * @throws 	ArgumentError  	 										if the specified value is <code>null</code> and this map does not permit <code>null</code> values.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the value previously at the specified position.
		 */
		public function setValueAt(index:int, value:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * @inheritDoc
 		 */
		public function size(): int
		{
			return _keys.size();
		}
		
		/**
		 * Returns a new map that is a view of the portion of this map between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>The returned map supports all of the optional map operations supported by this map.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving mappings (inclusive).
		 * @param  	toIndex 	the index to stop retrieving mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subMap</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		public function subMap(fromIndex:int, toIndex:int): IListMap
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * @inheritDoc
		 * 
		 * @throws 	ArgumentError 	if <code>containsKey(fromKey)</code> returns <code>false</code>.
		 */
		public function tailMap(fromKey:*): IListMap
		{
			if (!containsKey(fromKey)) throw new ArgumentError("This maps does not contains the specified key: " + fromKey);
			
			var fromIndex:int = indexOfKey(fromKey);
			var toIndex:int = size();
			
			var map:IListMap = subMap(fromIndex, toIndex);
			return map;
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
		protected function checkIndex(index:int, max:int):void
		{
			if (index < 0 || index > max) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: " + index + " (min: 0, max: " + max + ")");
		}
		
		/**
		 * @private
		 */
		protected function createEmptyMap(): IListMap
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		/**
		 * @private
		 */
		protected function keyAdded(key:*): void
		{
			_modCount++;
		}
		
		/**
		 * @private
		 */
		protected function keyRemoved(key:*): void
		{
			_modCount++;
		}
		
		/**
		 * @private
		 */
		protected function valueAdded(value:*): void
		{
			
		}
		
		/**
		 * @private
		 */
		protected function valueRemoved(value:*): void
		{
			
		}

		/**
		 * @private
		 */
		private function _init(): void
		{
			_keys 		= new ArrayList();
			_values 	= new ArrayList();
		}

	}

}