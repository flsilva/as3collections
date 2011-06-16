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
	 * An ordered collection. The user of this interface has precise control over where in the list each element is inserted. The user can access elements by their integer index (position in the list), and search for elements in the list.
	 * <p>Lists typically allow duplicate elements and multiple <code>null</code> elements if they allow <code>null</code> elements at all.
	 * But there are lists that prohibits duplicates and/or <code>null</code> elements, by throwing runtime errors when the user attempts to insert them.</p>
	 * <p>The <code>IList</code> interface provides the special <code>IListIterator</code> iterator, that allows element insertion and replacement, and bidirectional access in addition to the normal operations that the <code>IIterator</code> interface provides.
	 * The <code>listIterator()</code> method is provided to obtain a <code>IListIterator</code> implementation that may start at a specified position in the list.</p>
	 * <p>The methods that modify the list are specified to throw <code>org.as3coreaddendum.errors.UnsupportedOperationError</code> if the list does not support the operation.
	 * These methods are documented as "optional operation".</p>
	 * 
	 * @author Flávio Silva
	 */
	public interface IList extends ICollection
	{
		/**
		 * The number of times this list has been <em>structurally modified</em>. Structural modifications are those that change the size of the list.
		 * <p>This field is used by the list iterator implementation returned by the <code>listIterator</code> method.
		 * If the value of this field changes unexpectedly, the list iterator will throw a <code>org.as3coreaddendum.errors.ConcurrentModificationError</code> in response to the <code>next</code>, <code>remove</code>, <code>previous</code>, <code>set</code> or <code>add</code> operations.</p>
		 * <p>Implementations merely has to increment this field in its <code>add</code>, <code>remove</code> and any other methods that result in structural modifications to the list.
		 * A single call to <code>add</code> or <code>remove</code> must add no more than one to this field.</p>
		 * 
		 */
		function get modCount(): int;

		/**
		 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation). Shifts the element currently at that position (if any) and any subsequent elements to the right (increases their indices). The new elements will appear in this list in the order that they are returned by the specified collection's iterator.
		 * 
		 * @param  	index 		index at which to insert the first element from the specified collection.
		 * @param  	collection 	the collection containing elements to be added to this list.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAllAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		function addAllAt(index:int, collection:ICollection): Boolean;

		/**
		 * Inserts the specified element at the specified position in this list (optional operation). Shifts the element currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 * @return 	<code>true</code> if this list changed as a result of the call. Returns <code>false</code> if this list does not permit duplicates and already contains the specified element.
		 */
		function addAt(index:int, element:*): Boolean;

		/**
		 * Returns the element at the specified position in this list.
		 * 
		 * @param index 	index of the element to return.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element at the specified position in this list.
		 */
		function getAt(index:int): *;

		/**
		 * Returns the index of the <b>first occurrence</b> of the specified element in this list, or -1 if this list does not contain the element.
		 * 
		 * @param element 		the element to search for.
		 * @param fromIndex 	the position in the list from which to start searching for the element (inclusive).
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		function indexOf(element:*, fromIndex:int = 0): int;

		/**
		 * Returns the index of the <b>last occurrence</b> of the specified element in this list, or -1 if this list does not contain the element.
		 * 
		 * @param element 		the element to search for.
		 * @param fromIndex 	the position in the list from which to start searching for the element (inclusive). The default is the maximum value allowed for an index. If you do not specify <code>fromIndex</code>, the search starts at the last item in the list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		function lastIndexOf(element:*, fromIndex:int = 0x7fffffff): int;

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list. The specified index indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified index minus one. 
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 */
		function listIterator(index:int = 0): IListIterator;

		/**
		 * Removes the element at the specified position in this list (optional operation). Shifts any subsequent elements to the left (subtracts one from their indices). Returns the element that was removed from the list. 
		 * 
		 * @param  	index 	the index of the element to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		function removeAt(index:int): *;

		/**
		 * Removes all of the elements whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation). Shifts any subsequent elements to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing elements (inclusive).
		 * @param  	toIndex 	the index to stop removing elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new collection containing all the removed elements.
		 */
		function removeRange(fromIndex:int, toIndex:int): ICollection;

		/**
		 * Reverses the order of the elements in this list.
		 */
		function reverse(): void;

		/**
		 * Replaces the element at the specified position in this list with the specified element (optional operation).
		 * 
		 * @param  	index 		index of the element to replace.
		 * @param  	element 	element to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		function setAt(index:int, element:*): *;

		/**
		 * Returns a new list that is a view of the portion of this list between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>The returned list supports all of the optional list operations supported by this list.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subList</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		function subList(fromIndex:int, toIndex:int): IList;
	}

}