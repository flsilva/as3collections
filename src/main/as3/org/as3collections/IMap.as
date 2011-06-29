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
	import org.as3coreaddendum.system.ICloneable;
	import org.as3coreaddendum.system.IEquatable;

	/**
	 * An object that maps keys to values.
	 * A map cannot contain duplicate keys, each key can map to at most one value.
	 * <p>This interface provides three collection views, which allow a map's contents to be viewed as a list of keys, a list of values, or a list of key-value mappings (<code>IMapEntry</code>).
	 * Some map implementations, like the <code>ArrayListMap</code> class, make specific guarantees as to their order; others, like the <code>HashMap</code> class, do not.</p>
	 * <p>These views, plus <code>IMap.iterator()</code>, enable various forms of iteration over the keys and values of the map.
	 * To iterate over the keys/values the user can use <code>IMap.iterator()</code> or <code>IMap.entryList().iterator()</code>.
	 * To iterate over the keys the user can use <code>IMap.getKeys().iterator()</code>.
	 * To iterate over the values the user can use <code>IMap.getValues().iterator()</code>.</p>
	 * <p>Some map implementations have restrictions on the keys and values they may contain.
	 * For example, some implementations prohibit <code>null</code> keys and values, and some have restrictions on the types of their keys or values.</p>
	 * <p>The methods that modify the map are specified to throw <code>org.as3coreaddendum.errors.UnsupportedOperationError</code> if the map does not support the operation.
	 * These methods are documented as "optional operation".</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @see org.as3collections.AbstractHashMap AbstractHashMap
	 * @see org.as3collections.AbstractListMap AbstractListMap
	 * @see org.as3collections.IMapEntry IMapEntry
	 * @see org.as3collections.IListMap IListMap
	 * @author Flávio Silva
	 */
	public interface IMap extends IIterable, ICloneable, IEquatable
	{
		/**
		 * Indicates whether all keys in this map implements <code>org.as3coreaddendum.system.IEquatable</code> interface.
		 */
		function get allKeysEquatable(): Boolean;

		/**
		 * Indicates whether all values in this map implements <code>org.as3coreaddendum.system.IEquatable</code> interface.
		 */
		function get allValuesEquatable(): Boolean;

		/**
		 * Removes all of the mappings from this map (optional operation).
		 * The map will be empty after this call returns.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>clear</code> operation is not supported by this map.
		 */
		function clear(): void;

		/**
		 * Returns <code>true</code> if this map contains a mapping for the specified key.
		 * 
		 * @param  	key 	key whose presence in this map is to be tested.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	<code>true</code> if this map contains a mapping for the specified key.
		 */
		function containsKey(key:*): Boolean;

		/**
		 * Returns <code>true</code> if this map maps one or more keys to the specified value.
		 * 
		 * @param  	value 	value whose presence in this map is to be tested.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified value is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified value is <code>null</code> and this map does not permit <code>null</code> values (optional).
		 * @return 	<code>true</code> if this map maps one or more keys to the specified value.
		 */
		function containsValue(value:*): Boolean;

		/**
		 * Returns an <code>ICollection</code> object that is a view of the mappings contained in this map.
		 * The type of the objects within the map is <code>IMapEntry</code>
		 * <p>Modifications in the <code>ICollection</code> object does not affect this map.</p>
		 * 
		 * @return 	an <code>ICollection</code> object that is a view of the mappings contained in this map.
		 * @see org.as3collections.IMapEntry IMapEntry
		 * @see org.as3collections.ICollection ICollection
 		 */
		function entryCollection(): ICollection;

		/**
		 * Returns an <code>ICollection</code> object that is a view of the keys contained in this map.
		 * <p>Modifications in the <code>ICollection</code> object doesn't affect this map.</p>
		 * 
		 * @return 	an <code>ICollection</code> object that is a view of the keys contained in this map.
 		 */
		function getKeys(): ICollection;

		/**
		 * Returns the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 * <p>If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contains no mapping for the key.
		 * It's possible that the map explicitly maps the key to <code>null</code>.
		 * The <code>containsKey</code> method may be used to distinguish these two cases.</p>
		 * 
		 * @param  	key 	the key whose associated value is to be returned.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the value to which the specified key is mapped, or <code>null</code> if this map contains no mapping for the key.
		 */
		function getValue(key:*): *;

		/**
		 * Returns an <code>ICollection</code> object that is a view of the values contained in this map.
		 * <p>Modifications in the <code>ICollection</code> object does not affect this map.</p>
		 * 
		 * @return 	an <code>ICollection</code> object that is a view of the values contained in this map.
 		 */
		function getValues(): ICollection;

		/**
		 * Returns <code>true</code> if this map contains no key-value mappings.
		 * 
		 * @return 	<code>true</code> if this map contains no key-value mappings.
 		 */
		function isEmpty(): Boolean;

		/**
		 * Associates the specified value with the specified key in this map (optional operation).
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value. (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>put</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key or value is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified key or value is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for key. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with key, if the implementation supports <code>null</code> values.)
		 */
		function put(key:*, value:*): *;

		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 * The effect of this call is equivalent to that of calling <code>put(k, v)</code> on this map once for each mapping from key <code>k</code> to value <code>v</code> in the specified map.
		 * 
		 * @param  	map 	mappings to be stored in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified map is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 */
		function putAll(map:IMap): void;

		/**
		 * Retrieves each property of the specified object, calling <code>put</code> on this map once for each property (optional operation).
		 * 
		 * @param  	o the object to retrieve the properties.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAllByObject</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified object is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified object is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified object contains <code>null</code> keys or values.
		 */
		function putAllByObject(o:Object): void;

		/**
		 * Associates the specified <code>entry.value</code> with the specified <code>entry.key</code> in this map (optional operation).
		 * If the map previously contained a mapping for the <code>entry.key</code>, the old value is replaced by the specified <code>entry.value</code>. (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * <p>The effect of this call is equivalent to that of calling <code>put(entry.key, entry.value)</code> on this map.</p>
		 * 
		 * @param  	entry 	entry to put in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putEntry</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified <code>entry.key</code> or <code>entry.value</code> is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified entry is <code>null</code>, or if the specified <code>entry.key</code> or <code>entry.value</code> is <code>null</code> and this map does not permit <code>null</code> keys or values.
		 * @return 	the previous value associated with <code>entry.key</code>, or <code>null</code> if there was no mapping for <code>entry.key</code>. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with <code>entry.key</code>, if the implementation supports <code>null</code> values.)
		 */
		function putEntry(entry:IMapEntry): *;

		/**
		 * Removes the mapping for a key from this map if it is present (optional operation).
		 * <p>Returns the value to which this map previously associated the key, or <code>null</code> if the map contained no mapping for the key.
		 * If this map permits <code>null</code> values, then a return value of <code>null</code> does not <em>necessarily</em> indicate that the map contained no mapping for the key. It's possible that the map explicitly mapped the key to <code>null</code>.</p>
		 * <p>The map will not contain a mapping for the specified key once the call returns.</p>
		 * 
		 * @param  	key 	the key whose mapping is to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  			if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for <code>key</code>.
		 */
		function remove(key:*): *;

		/**
		 * Removes the mapping for a key from this map (if it is present) for each element in the specified collection (optional operation).
		 * The elements in the specified collection are interpreted as keys.
		 * <p>The effect of this call is equivalent to that of calling <code>remove</code> on this map once for each element in the speficied collection.</p>
		 * <p>The map will not contain mappings for the elements in the specified collection once the call returns.</p>
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be removed from the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of an element in the specified collection is incompatible with this map (optional).
		 * @throws 	ArgumentError  			if the specified collection is <code>null</code>, or if this map does not permit <code>null</code> keys, and the specified collections contains <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		function removeAll(keys:ICollection): Boolean;

		/**
		 * Retains only the mappings in this map that the keys are contained (as elements) in the specified collection (optional operation).
		 * In other words, removes from this map all of its mappings whose keys are not contained (as elements) in the specified collection.
		 * The elements in the specified collection are interpreted as keys.
		 * 
		 * @param  	keys 	the collection whose elements are interpreted as keys to be retained in the map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more keys in this map are incompatible with the specified collection (optional).
		 * @throws 	ArgumentError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> keys (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this map changed as a result of the call.
		 */
		function retainAll(keys:ICollection): Boolean;

		/**
		 * Returns the number of key-value mappings in this map. 
		 * 
		 * @return 	the number of key-value mappings in this map.
 		 */
		function size(): int;
	}

}