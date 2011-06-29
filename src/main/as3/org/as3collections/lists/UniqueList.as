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

package org.as3collections.lists 
{
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.UniqueCollection;
	import org.as3collections.iterators.ListIterator;
	import org.as3collections.utils.CollectionUtil;

	/**
	 * <code>UniqueList</code> works as a wrapper for a list.
	 * It does not allow duplicated elements in the collection.
	 * It stores the <code>wrapList</code> constructor's argument in the <code>wrappedList</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedList</code> object.
	 * The methods that need to be checked for duplication are previously validated before forward the call.
	 * No error is thrown by the validation of duplication.
	 * The calls that are forwarded to the <code>wrappedList</code> returns the return of the <code>wrappedList</code> call.
	 * <p>You can also create unique and typed lists. See below the link "ListUtil.getUniqueTypedList()".</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.IListIterator;
	 * import org.as3collections.lists.ArrayList;
	 * import org.as3collections.lists.UniqueList;
	 * import org.as3collections.utils.ListUtil;
	 * 
	 * var l1:IList = new ArrayList([3, 5, 1, 7]);
	 * 
	 * var list1:IList = new UniqueList(l1); // you can use this way
	 * 
	 * //var list1:IList = ListUtil.getUniqueList(l1); // or you can use this way
	 * 
	 * list1                       // [3,5,1,7]
	 * list1.size()                // 4
	 * 
	 * list1.addAt(1, 4)           // true
	 * list1                       // [3,4,5,1,7]
	 * list1.size()                // 5
	 * 
	 * list1.addAt(2, 3)           // false
	 * list1                       // [3,4,5,1,7]
	 * list1.size()                // 5
	 * 
	 * list1.add(5)                // false
	 * list1                       // [3,4,5,1,7]
	 * list1.size()                // 5
	 * 
	 * var it:IListIterator = list1.listIterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 * 
	 *     e = it.next()
	 *     e                       // 3
	 * 
	 *     e = it.next()
	 *     e                       // 4
	 * 
	 *     e = it.next()
	 *     e                       // 5
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.add(0)
	 * 
	 *         list1               // [3,4,5,0,1,7]
	 *         list1.size()        // 6
	 *     }
	 * 
	 *     e = it.next()
	 *     e                       // 1
	 * 
	 *     if (e == 1)
	 *     {
	 *         it.add(3)
	 * 
	 *         list1               // [3,4,5,0,1,7]
	 *         list1.size()        // 6
	 *     }
	 * 
	 *     e = it.next()
	 *     e                       // 7
	 * }
	 * 
	 * list1                       // [3,4,5,0,1,7]
	 * list1.size()                // 6
	 * 
	 * var l2:IList = new ArrayList([1, 2, 3, 4, 5, 1, 3, 5]);
	 * 
	 * var list2:IList = new UniqueList(l2); // you can use this way
	 * 
	 * //var list2:IList = ListUtil.getUniqueList(l2); // or you can use this way
	 * 
	 * list2                       // [1,2,3,4,5]
	 * list2.size()                // 5
	 * </listing>
	 * 
	 * @see org.as3collections.utils.ListUtil#getUniqueList() ListUtil.getUniqueList()
	 * @see org.as3collections.utils.ListUtil#getUniqueTypedList() ListUtil.getUniqueTypedList()
	 * @author Flávio Silva
	 */
	public class UniqueList extends UniqueCollection implements IList
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
		 * Constructor, creates a new <code>UniqueList</code> object.
		 * 
		 * @param 	wrapList 	the target list to wrap.
		 * @throws 	ArgumentError  	if the <code>wrappedList</code> argument is <code>null</code>.
		 */
		public function UniqueList(wrapList:IList)
		{
			super(wrapList);
		}

		/**
		 * If the specified collection is empty returns <code>false</code>.
		 * Otherwise, it clones the specified collection, removes from the cloned collection all elements that already are in the <code>wrappedList</code> and removes all duplicates.
		 * Then it forwards the call to <code>wrappedList.addAllAt</code> sending the cloned (and filtered) collection.
		 * 
		 * @param  	index 		index at which to insert the first element from the specified collection.
		 * @param  	collection 	the collection to forward to <code>wrappedList.addAllAt</code>.
		 * @throws 	ArgumentError  	 if the specified collection contains a <code>null</code> element and <code>wrappedList</code> does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>false</code> if the specified collection is <code>null</code> or empty. Otherwise returns the return of the call <code>wrappedList.addAllAt</code>.
		 */
		public function addAllAt(index:int, collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var c:ICollection = collection.clone();
			filterCollection(c);
			
			if (c.isEmpty()) return false;
			
			return wrappedList.addAllAt(index, c);
		}

		/**
		 * If <code>wrappedList.contains(element)</code> returns <code>true</code> then returns <code>false</code>.
		 * Otherwise, it forwards the call to <code>wrappedList.addAt</code>.
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @return 	<code>false</code> if <code>wrappedList.contains(element)</code> returns <code>true</code>. Otherwise returns the return of the call <code>wrappedList.addAt</code>.
		 */
		public function addAt(index:int, element:*): Boolean
		{
			if (wrappedList.contains(element)) return false;
			return wrappedList.addAt(index, element);
		}

		/**
		 * Creates and return a new <code>UniqueList</code> object with the clone of the <code>wrappedList</code> object.
		 * 
		 * @return 	a new <code>UniqueList</code> object with the clone of the <code>wrappedList</code> object.
 		 */
		override public function clone(): *
		{
			return new UniqueList(wrappedList.clone());
		}

		/**
		 * This method uses <code>CollectionUtil.equalConsideringOrder</code> method to perform equality, sending this list and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalConsideringOrder() CollectionUtil.equalConsideringOrder()
		 */
		override public function equals(other:*): Boolean
		{
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
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * The specified index indicates the first element that would be returned by an initial call to <code>next</code>.
		 * An initial call to <code>previous</code> would return the element with the specified index minus one. 
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
		 * If <code>wrappedList.contains(element)</code> returns <code>true</code> then returns <code>false</code>. Otherwise, it forwards the call to <code>wrappedList.setAt</code>.
		 * 
		 * @param  	index
		 * @param  	element
		 * @return 	<code>false</code> if <code>wrappedList.contains(element)</code> returns <code>true</code>. Otherwise returns the return of the call <code>wrappedList.setAt</code>.
		 */
		public function setAt(index:int, element:*): *
		{
			if (wrappedList.contains(element)) return false;
			return wrappedList.setAt(index, element);
		}

		/**
		 * Returns a new <code>UniqueList(wrappedList.subList(fromIndex, toIndex))</code>. 
		 * <p>Modifications in the returned <code>UniqueList</code> object does not affect this list.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>UniqueList(wrappedList.subList(fromIndex, toIndex))</code>.
		 */
		public function subList(fromIndex:int, toIndex:int): IList
		{
			return new UniqueList(wrappedList.subList(fromIndex, toIndex));
		}

	}

}