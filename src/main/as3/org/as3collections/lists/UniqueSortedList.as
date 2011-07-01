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
	import org.as3collections.IList;
	import org.as3collections.ISortedList;
	import org.as3coreaddendum.system.IComparator;
	import org.as3utils.ReflectionUtil;

	/**
	 * <code>UniqueSortedList</code> works as a wrapper for a <code>ISortedList</code> object.
	 * It does not allow duplicated elements in the collection.
	 * It stores the <code>wrapList</code> constructor's argument in the <code>wrappedList</code> variable.
	 * So every method call to this class is forwarded to the <code>wrappedList</code> object.
	 * The methods that need to be checked for duplication are previously validated before forward the call.
	 * No error is thrown by the validation of duplication.
	 * The calls that are forwarded to the <code>wrappedList</code> returns the return of the <code>wrappedList</code> call.
	 * <p>You can also create unique and typed sorted lists.
	 * See below the link "ListUtil.getUniqueTypedSortedList()".</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.ISortedList;
	 * import org.as3collections.IListIterator;
	 * import org.as3collections.lists.SortedArrayList;
	 * import org.as3collections.lists.UniqueSortedList;
	 * import org.as3collections.utils.ListUtil;
	 * 
	 * var l1:ISortedList = new SortedArrayList([3, 5, 1, 7], null, Array.NUMERIC);
	 * 
	 * var list1:ISortedList = new UniqueSortedList(l1); // you can use this way
	 * 
	 * //var list1:ISortedList = ListUtil.getUniqueSortedList(l1); // or you can use this way
	 * 
	 * list1                       // [1,3,5,7]
	 * list1.size()                // 4
	 * 
	 * list1.addAt(1, 4)           // true
	 * list1                       // [1,3,4,5,7]
	 * list1.size()                // 5
	 * 
	 * list1.addAt(2, 3)           // false
	 * list1                       // [1,3,4,5,7]
	 * list1.size()                // 5
	 * 
	 * list1.add(5)                // false
	 * list1                       // [1,3,4,5,7]
	 * list1.size()                // 5
	 * </listing>
	 * 
	 * @see org.as3collections.utils.ListUtil#getUniqueSortedList() ListUtil.getUniqueSortedList()
	 * @see org.as3collections.utils.ListUtil#getUniqueTypedSortedList() ListUtil.getUniqueTypedSortedList()
	 * @author Flávio Silva
	 */
	public class UniqueSortedList extends UniqueList implements ISortedList
	{
		/**
		 * Defines the <code>wrappedList</code> comparator object to be used automatically to sort.
		 * <p>If this value change the <code>wrappedList</code> is automatically reordered with the new value.</p>
		 */
		public function get comparator(): IComparator { return wrappedSortedList.comparator; }

		public function set comparator(value:IComparator): void { wrappedSortedList.comparator = value; }

		/**
		 * Defines the <code>wrappedList</code> options to be used automatically to sort.
		 * <p>If this value change the list is automatically reordered with the new value.</p>
		 */
		public function get options(): uint { return wrappedSortedList.options; }

		public function set options(value:uint): void { wrappedSortedList.options = value; }
		
		/**
		 * @private
		 */
		protected function get wrappedSortedList(): ISortedList { return wrappedList as ISortedList; }
		
		/**
		 * Constructor, creates a new <code>TypedList</code> object.
		 * 
		 * @param 	wrapList 	the target list to wrap.
		 * @param 	type 		the type of the elements allowed by this list.
		 * @throws 	ArgumentError  	if the <code>wrapList</code> argument is <code>null</code>.
		 * @throws 	ArgumentError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapList</code> argument are incompatible with the <code>type</code> argument.
		 */
		public function UniqueSortedList(wrapList:ISortedList)
		{
			super(wrapList);
		}

		/**
		 * Creates and return a new <code>UniqueSortedList</code> object with the clone of the <code>wrappedMap</code> object.
		 * 
		 * @return 	a new <code>UniqueSortedList</code> object with the clone of the <code>wrappedMap</code> object.
 		 */
		override public function clone(): *
		{
			return new UniqueSortedList(wrappedSortedList.clone());
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * <li>object A and object B has the same type of comparator</li>
		 * <li>object A and object B has the same options</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the elements in the list.
		 * So, for two lists are equal the order of elements returned by the iterator must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var l:ISortedList = other as ISortedList;
			
			if (options != l.options) return false;
			if (!comparator && l.comparator) return false;
			if (comparator && !l.comparator) return false;
			if (!ReflectionUtil.classPathEquals(comparator, l.comparator)) return false;
			
			return super.equals(other);
		}

		/**
		 * Forwards the call to <code>wrappedList.sort</code>.
		 * 
		 * @param compare
		 * @param options
		 * @return
		 */
		public function sort(compare:Function = null, options:uint = 0): Array
		{
			return wrappedSortedList.sort(compare, options);
		}

		/**
		 * Forwards the call to <code>wrappedList.sortOn</code>.
		 * 
		 * @param fieldName
		 * @param options
		 * @return
		 */
		public function sortOn(fieldName:*, options:* = null): Array
		{
			return wrappedSortedList.sortOn(fieldName, options);
		}
		
		/**
		 * Forwards the call to <code>wrappedList.subList</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @return
		 */
		override public function subList(fromIndex:int, toIndex:int): IList
		{
			var subList:IList = wrappedSortedList.subList(fromIndex, toIndex);
			var sortedSubList:ISortedList = new SortedArrayList(subList.toArray(), comparator, options);
			
			return new UniqueSortedList(sortedSubList);
		}

	}

}