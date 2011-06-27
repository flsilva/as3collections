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
	/**
	 * description
	 * 
	 * @author Flávio Silva
	 */
	public interface IListMap extends IMap
	{
		/**
		 * The number of times this map has been <em>structurally modified</em>. Structural modifications are those that change the size of the map.
		 * <p>This field is used by the <code>IListMapIterator</code> implementation returned by the <code>listIterator</code> method.
		 * If the value of this field changes unexpectedly, the <code>IListMapIterator</code> object will throw a <code>org.as3collections.errors.ConcurrentModificationError</code> in response to the <code>next</code>, <code>remove</code>, <code>previous</code> or <code>put</code> operations.</p>
		 * <p>Implementations merely has to increment this field in its <code>put</code>, <code>remove</code> and any other methods that result in structural modifications to the map.
		 * A single call to <code>put</code> or <code>remove</code> must add no more than one to this field.</p>
		 * 
		 */
		function get modCount(): int;
		
		/**
		 * Returns the key at the specified position in this map.
		 * 
		 * @param index 	index of the key to return.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the key at the specified position in this map.
		 */
		function getKeyAt(index:int): *;
		
		/**
		 * Returns the value at the specified position in this map.
		 * 
		 * @param 	index 	index of the value to return.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the value at the specified position in this map.
		 */
		function getValueAt(index:int): *;
		
		/**
		 * Returns a new <code>IListMap</code> object that is a view of the portion of this map whose keys are strictly less than <code>toKey</code>.
		 * The returned map supports all optional map operations that this map supports.
		 * 
		 * @param  	toKey 	high endpoint (exclusive) of the keys in the returned map.
		 * @throws 	ArgumentError 	if <code>toKey</code> is <code>null</code> and this map does not permit <code>null</code> keys.
		 * @throws 	ArgumentError 	if <code>containsKey(toKey)</code> returns <code>false</code>.
		 * @return 	a new <code>IListMap</code> that is a view of the portion of this map whose keys are strictly less than <code>toKey</code>.
		 */
		function headMap(toKey:*): IListMap;
		
		/**
		 * Returns the index of the <b>first occurrence</b> of the specified key in this map, or -1 if this map does not contain the key.
		 * 
		 * @param  	key 	the key to search for.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified key is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified key is <code>null</code> and this map does not permit <code>null</code> keys (optional).
		 * @return 	the index of the first occurrence of the specified key in this map, or -1 if this map does not contain the key.
 		 */
		function indexOfKey(key:*): int;

		/**
		 * Returns the index of the <b>first occurrence</b> of the specified value in this map, or -1 if this map does not contain the value.
		 * 
		 * @param  	value 	the value to search for.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified value is incompatible with this map (optional).
		 * @throws 	ArgumentError  	if the specified value is <code>null</code> and this map does not permit <code>null</code> values (optional).
		 * @return 	the index of the first occurrence of the specified value in this map, or -1 if this map does not contain the value.
 		 */
		function indexOfValue(value:*): int;
		
		/**
		 * Returns a <code>IListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 * The specified index indicates the first value that would be returned by an initial call to <code>next</code>.
		 * An initial call to <code>previous</code> would return the value with the specified index minus one.
		 * 
		 * @param  	index 	index of first value to be returned from the iterator (by a call to the <code>next</code> method) 
		 * @return 	a <code>IListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 */
		function listMapIterator(index:int = 0): IListMapIterator;
		
		/**
		 * Copies all of the mappings from the specified map to this map (optional operation).
		 * Shifts the entry currently at that position (if any) and any subsequent entries to the right (increases their indices).
		 * The new entries will appear in this map in the order that they are returned by the specified map's iterator.
		 * 
		 * @param  	index 	index at which to insert the first entry from the specified map.
		 * @param  	map 	mappings to be stored in this map.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>putAllAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of a key or value in the specified map is incompatible with this map.
		 * @throws 	ArgumentError  			if the specified map is <code>null</code>, or if this map does not permit <code>null</code> keys or values, and the specified map contains <code>null</code> keys or values.
		 * @throws 	ArgumentError  			if the specified map contains one or more keys already added in this map.
		 */
		function putAllAt(index:int, map:IMap): void;

		/**
		 * Associates the specified value with the specified key at the specified position in this map (optional operation).
		 * Shifts the entry currently at that position (if any) and any subsequent entries to the right (adds one to their indices).
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
		function putAt(index:int, key:*, value:*): void;
		
		/**
		 * Removes the mapping at the specified position in this map (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts one from their indices).
		 * Returns an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map. 
		 * 
		 * @param  	index 	the index of the mapping to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map.
		 */
		function removeAt(index:int): IMapEntry;

		/**
		 * Removes all of the mappings whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing mappings (inclusive).
		 * @param  	toIndex 	the index to stop removing mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new map containing all the removed mappings.
		 */
		function removeRange(fromIndex:int, toIndex:int): IListMap;

		/**
		 * Reverses the order of the mappings in this map.
		 */
		function reverse(): void;

		/**
		 * Replaces the key at the specified position in this map with the specified key (optional operation).
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
		function setKeyAt(index:int, key:*): *;
		
		/**
		 * Replaces the value at the specified position in this map with the specified value (optional operation).
		 * 
		 * @param  	index 	index of the value to replace.
		 * @param  	value 	value to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setValueAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified value prevents it from being added to this map.
		 * @throws 	ArgumentError  	 										if the specified value is <code>null</code> and this map does not permit <code>null</code> values.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the value previously at the specified position.
		 */
		function setValueAt(index:int, value:*): *;

		/**
		 * Returns a new <code>IListMap</code> object that is a view of the portion of this map between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>The returned map supports all of the optional map operations supported by this map.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving mappings (inclusive).
		 * @param  	toIndex 	the index to stop retrieving mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subMap</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		function subMap(fromIndex:int, toIndex:int): IListMap;

		/**
		 * Returns a new <code>IListMap</code> object that is a view of the portion of this map whose keys are greater than or equal to <code>fromKey</code>.
		 * The returned map supports all optional map operations that this map supports.
		 * 
		 * @param  	fromKey 	low endpoint (inclusive) of the keys in the returned map.
		 * @throws 	ArgumentError 	if <code>fromKey</code> is <code>null</code> and this map does not permit <code>null</code> keys.
		 * @throws 	ArgumentError 	if <code>containsKey(fromKey)</code> returns <code>false</code>.
		 * @return 	a new sorted map that is a view of the portion of this map whose keys are greater than or equal to <code>fromKey</code>.
		 */
		function tailMap(fromKey:*): IListMap;
	}

}