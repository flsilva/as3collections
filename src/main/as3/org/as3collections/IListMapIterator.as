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
	import org.as3collections.IIterator;

	/**
	 * An iterator for maps that allows the programmer to traverse the map in either direction, modify the map during iteration, and obtain the iterator's current position in the map.
	 * <p>Note that the <code>remove</code> and <code>set</code> methods are defined to operate on the last mapping returned by a call to <code>next</code> or <code>previous</code>.</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IListMapIterator extends IIterator
	{

		/**
		 * Returns <code>true</code> if the iteration has more mappings when traversing the map in the reverse direction.
		 * 
		 * @return 	<code>true</code> if the iteration has more mappings when traversing the map in the reverse direction.
 		 */
		function hasPrevious(): Boolean;

		/**
		 * Returns the index of the mapping that would be returned by a subsequent call to <code>next</code>.
		 * (Returns map size if the map iterator is at the end of the map.) 
		 * 
		 * @return 	the index of the mapping that would be returned by a subsequent call to <code>next</code>, or map size if map iterator is at end of map.
 		 */
		function nextIndex(): int;

		/**
		 * Returns the previous mapping in the iteration.
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 			if the iteration has no previous mappings.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
		 * @return 	the previous mapping in the iteration.
 		 */
		function previous(): *;

		/**
		 * Returns the index of the mapping that would be returned by a subsequent call to <code>previous</code>.
		 * (Returns -1 if the map iterator is at the beginning of the map.) 
		 * 
		 * @return 	the index of the mapping that would be returned by a subsequent call to <code>previous</code>, or -1 if map iterator is at beginning of map.
 		 */
		function previousIndex(): int;
		
		/**
		 * Associates the specified value with the specified key in this map. (optional operation)
		 * The mapping is inserted immediately before the next mapping that would be returned by <code>next</code>, if any, and after the next mapping that would be returned by <code>previous</code>, if any.
		 * (If the map contains no mappings, the new mapping becomes the sole mapping on the map.)
		 * The new mapping is inserted before the implicit cursor: a subsequent call to <code>next</code> would be unaffected, and a subsequent call to <code>previous</code> would return the new mapping.
		 * (This call increases by one the value that would be returned by a call to <code>nextIndex</code> or <code>previousIndex</code>.) 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
		 * @throws 	ArgumentError  											if the map already contains the specified key.
		 */
		function put(key:*, value:*): void;
		
		/**
		 * Replaces the last mapping returned by <code>next</code> or <code>previous</code> with the specified mapping (optional operation).
		 * This call can be made only if neither <code>IListMapIterator.remove</code> nor <code>IListMapIterator.add</code> have been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key. 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>set</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if neither <code>next</code> or <code>previous</code> have been called, or <code>remove</code> or <code>add</code> have been called after the last call to <code>next</code> or <code>previous</code>.
		 * @throws 	ArgumentError  											if the map already contains the specified key and it is not the replaced key.
		 */
		function set(key:*, value:*): void;
	}

}