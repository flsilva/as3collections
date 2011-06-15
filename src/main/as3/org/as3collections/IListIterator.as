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
	 * An iterator for lists that allows the programmer to traverse the list in either direction, modify the list during iteration, and obtain the iterator's current position in the list.
	 * <p>Note that the <code>remove</code> and <code>set</code> methods are defined to operate on the last element returned by a call to <code>next</code> or <code>previous</code>.</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IListIterator extends IIterator
	{
		/**
		 * Inserts the specified element into the list (optional operation). The element is inserted immediately before the next element that would be returned by <code>next</code>, if any, and after the next element that would be returned by <code>previous</code>, if any. (If the list contains no elements, the new element becomes the sole element on the list.) The new element is inserted before the implicit cursor: a subsequent call to <code>next</code> would be unaffected, and a subsequent call to <code>previous</code> would return the new element. (This call increases by one the value that would be returned by a call to <code>nextIndex</code> or <code>previousIndex</code>.) 
		 * 
		 * @param  	element 	the element to add.
		 * @throws 	org.as3coreaddendum.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 * @return 	<code>true</code> if the list has changed as a result of the call. Returns <code>false</code> if the list does not permit duplicates and already contains the specified element.
		 */
		function add(element:*): Boolean;

		/**
		 * Returns <code>true</code> if the iteration has more elements when traversing the list in the reverse direction.
		 * 
		 * @return 	<code>true</code> if the iteration has more elements when traversing the list in the reverse direction.
 		 */
		function hasPrevious(): Boolean;

		/**
		 * Returns the index of the element that would be returned by a subsequent call to <code>next</code>. (Returns list size if the list iterator is at the end of the list.) 
		 * 
		 * @return 	the index of the element that would be returned by a subsequent call to <code>next</code>, or list size if list iterator is at end of list.
 		 */
		function nextIndex(): int;

		/**
		 * Returns the previous element in the iteration.
		 * 
		 * @throws 	org.as3coreaddendum.errors.NoSuchElementError 			if the iteration has no previous elements.
		 * @throws 	org.as3coreaddendum.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 * @return 	the previous element in the iteration.
 		 */
		function previous(): *;

		/**
		 * Returns the index of the element that would be returned by a subsequent call to <code>previous</code>. (Returns -1 if the list iterator is at the beginning of the list.) 
		 * 
		 * @return 	the index of the element that would be returned by a subsequent call to <code>previous</code>, or -1 if list iterator is at beginning of list.
 		 */
		function previousIndex(): int;

		/**
		 * Replaces the last element returned by <code>next</code> or <code>previous</code> with the specified element (optional operation). This call can be made only if neither <code>IListIterator.remove</code> nor <code>IListIterator.add</code> have been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @param element 	the element with which to replace the last element returned by <code>next</code> or <code>previous</code>. 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>set</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if neither <code>next</code> or <code>previous</code> have been called, or <code>remove</code> or <code>add</code> have been called after the last call to <code>next</code> or <code>previous</code>.
		 */
		function set(element:*): void;
	}

}