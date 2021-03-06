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

package org.as3collections.lists 
{
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.TypedCollection;
	import org.as3collections.iterators.ListIterator;
	import org.as3collections.utils.CollectionUtil;
	import org.as3utils.ReflectionUtil;

	/**
	 * <code>TypedList</code> works as a wrapper for a <code>IList</code> object.
	 * Since ActionScript 3.0 does not support typed arrays, <code>TypedList</code> is a way to create typed lists.
	 * It stores the <code>wrapList</code> constructor's argument internaly.
	 * So every method call to this class is forwarded to the <code>wrappedList</code> object.
	 * The methods that need to be checked for the type of the elements are previously validated before forward the call.
	 * If the type of an element requested to be added to this list is incompatible with the type of the list a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * The calls that are forwarded to the <code>wrappedList</code> returns the return of the <code>wrappedList</code> call.
	 * <p><code>TypedList</code> does not allow <code>null</code> elements.</p>
	 * <p>You can also create unique and typed lists. See below the link "ListUtil.getUniqueTypedList()".</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.IListIterator;
	 * import org.as3collections.lists.ArrayList;
	 * import org.as3collections.lists.TypedList;
	 * import org.as3collections.utils.ListUtil;
	 * 
	 * var l1:IList = new ArrayList([3, 5, 1, 7]);
	 * 
	 * var list1:IList = new TypedList(l1, int); // you can use this way
	 * 
	 * //var list1:IList = ListUtil.getTypedList(l1, int); // or you can use this way
	 * 
	 * list1                          // [3,5,1,7]
	 * list1.size()                   // 4
	 * 
	 * list1.add(8)                   // true
	 * list1                          // [3,5,1,7,8]
	 * list1.size()                   // 5
	 * 
	 * list1.addAt(1, 4)              // true
	 * list1                          // [3,4,5,1,7,8]
	 * list1.size()                   // 6
	 * 
	 * list1.remove("abc")            // false
	 * list1                          // [3,4,5,1,7,8]
	 * list1.size()                   // 6
	 * 
	 * var it:IListIterator = list1.listIterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 * 
	 *     e = it.next()
	 *     e                          // 3
	 * 
	 *     e = it.next()
	 *     e:                         // 4
	 * 
	 *     e = it.next()
	 *     e                          // 5
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.add(0)
	 * 
	 *         list1                  // [3,4,5,0,1,7,8]
	 *         list1.size()           // 7
	 *     }
	 * 
	 *     e = it.next()
	 *     e                          // 1
	 * 
	 *     if (e == 1)
	 *     {
	 *         it.add(3)
	 * 
	 *         list1                  // [3,4,5,0,1,3,7,8]
	 *         list1.size()           // 8
	 *     }
	 * 
	 *     e = it.next()
	 *     e                          // 7
	 * 
	 *     e = it.next()
	 *     e                          // 8
	 * 
	 *     if (e == 8)
	 *     {
	 *         it.add("ghi")          // ClassCastError: Invalid element type. element: ghi | type: String | expected type: int
	 *     }
	 * }
	 * 
	 * list1                          // [3,4,5,0,1,3,7,8]
	 * list1.size()                   // 8
	 * 
	 * list1.add("def")               // ClassCastError: Invalid element type. element: def | type: String | expected type: int
	 * 
	 * list1.setAt(0, 1)              // 3
	 * list1                          // [1,4,5,0,1,3,7,8]
	 * list1.size()                   // 8
	 * 
	 * list1.setAt(0, [1,2])          // ClassCastError: Invalid element type. element: 1,2 | type: Array | expected type: int
	 * </listing>
	 * 
	 * @see org.as3collections.utils.ListUtil#getTypedList() ListUtil.getTypedList()
	 * @see org.as3collections.utils.ListUtil#getUniqueTypedList() ListUtil.getUniqueTypedList()
	 * @author Flávio Silva
	 */
	public class TypedList extends TypedCollection implements IList
	{
		/**
		 * Returns the return of the call <code>wrappedList.modCount</code>.
		 */
		public function get modCount(): int { return wrappedList.modCount; }

		/**
		 * @private
		 */
		protected function get wrappedList(): IList { return wrappedCollection as IList; }

		/**
		 * Constructor, creates a new <code>TypedList</code> object.
		 * 
		 * @param 	wrapList 	the target list to wrap.
		 * @param 	type 		the type of the elements allowed by this list.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 */
		public function TypedList(wrapList:IList, type:*)
		{
			super(wrapList, type);
		}

		/**
		 * The collection is validated to be forwarded to <code>wrappedList.addAllAt</code>.
		 * 
		 * @param index
		 * @param  	collection 	the collection to forward to <code>wrappedList.addAllAt</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>collection</code> argument are incompatible with the type of this list.
		 * @return 	the return of the call <code>wrappedList.addAllAt</code>.
		 */
		public function addAllAt(index:int, collection:ICollection): Boolean
		{
			validateCollection(collection);
			return wrappedList.addAllAt(index, collection);
		}

		/**
		 * The element is validated to be forwarded to <code>wrappedList.addAt</code>.
		 * 
		 * @param index
		 * @param  	element 	the element to forward to <code>wrappedList.addAt</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the element is incompatible with the type of this list.
		 * @return 	the return of the call <code>wrappedList.addAt</code>.
		 */
		public function addAt(index:int, element:*): Boolean
		{
			validateElement(element);
			return wrappedList.addAt(index, element);
		}

		/**
		 * Creates and return a new <code>TypedList</code> object with a clone of the <code>wrappedList</code> object.
		 * 
		 * @return 	a new <code>TypedList</code> object with a clone of the <code>wrappedList</code> object.
 		 */
		override public function clone(): *
		{
			return new TypedList(wrappedList.clone(), type);
		}

		/**
		 * This method first checks if <code>other</code> argument is a <code>TypedList</code>.
		 * If not it returns <code>false</code>.
		 * If <code>true</code> it checks the <code>type</code> property of both lists.
		 * If they are different it returns <code>false</code>.
		 * Otherwise it uses <code>CollectionUtil.equalConsideringOrder</code> method to perform equality, sending this list and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalConsideringOrder() CollectionUtil.equalConsideringOrder()
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var otherList:TypedList = other as TypedList;
			if (type != otherList.type) return false;
			
			return CollectionUtil.equalConsideringOrder(this, other);
		}

		/**
		 * Forwards the call to <code>wrappedList.getAt</code>.
		 * 
		 * @param index
		 * @return 	the return of the call <code>wrappedList.getAt</code>.
		 */
		public function getAt(index:int): *
		{
			return wrappedList.getAt(index);
		}

		/**
		 * Forwards the call to <code>wrappedList.indexOf</code>.
		 * 
		 * @param element
		 * @param fromIndex
		 * @return 	the return of the call <code>wrappedList.indexOf</code>.
		 */
		public function indexOf(element:*, fromIndex:int = 0): int
		{
			return wrappedList.indexOf(element, fromIndex);
		}

		/**
		 * Forwards the call to <code>wrappedList.lastIndexOf</code>.
		 * 
		 * @param element
		 * @param fromIndex
		 * @return 	the return of the call <code>wrappedList.lastIndexOf</code>.
		 */
		public function lastIndexOf(element:*, fromIndex:int = 0x7fffffff): int
		{
			return wrappedList.lastIndexOf(element, fromIndex);
		}

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list. The specified index indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified index minus one. 
		 * <p>This implementation returns an <code>ListIterator</code> object.</p>
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * @see 	org.as3collections.iterators.ListIterator ListIterator
		 */
		public function listIterator(index:int = 0): IListIterator
		{
			return new ListIterator(this, index);
		}

		/**
		 * Forwards the call to <code>wrappedList.removeAt</code>.
		 * 
		 * @param index
		 * @return 	the return of the call <code>wrappedList.removeAt</code>.
		 */
		public function removeAt(index:int): *
		{
			return wrappedList.removeAt(index);
		}

		/**
		 * Forwards the call to <code>wrappedList.removeRange</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @return 	the return of the call <code>wrappedList.removeRange</code>.
		 */
		public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			return wrappedList.removeRange(fromIndex, toIndex);
		}

		/**
		 * Forwards the call to <code>wrappedList.reverse</code>.
		 */
		public function reverse(): void
		{
			wrappedList.reverse();
		}

		/**
		 * The element is validated to be forwarded to <code>wrappedList.setAt</code>.
		 * 
		 * @param index
		 * @param  	element 	the element to forward to <code>wrappedList.setAt</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the element is incompatible with the type of this list.
		 * @return 	the return of the call <code>wrappedList.setAt</code>.
		 */
		public function setAt(index:int, element:*): *
		{
			validateElement(element);
			return wrappedList.setAt(index, element);
		}

		/**
		 * Returns a new <code>TypedList(wrappedList.subList(fromIndex, toIndex))</code>. 
		 * <p>Modifications in the returned <code>TypedList</code> object does not affect this list.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>TypedList(wrappedList.subList(fromIndex, toIndex))</code>.
		 */
		public function subList(fromIndex:int, toIndex:int): IList
		{
			return new TypedList(wrappedList.subList(fromIndex, toIndex), type);
		}

	}

}