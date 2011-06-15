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
	import org.as3collections.AbstractList;
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.iterators.ReadOnlyArrayIterator;
	import org.as3collections.iterators.ReadOnlyArrayListIterator;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;

	/**
	 * A list that doesn't allow modifications.
	 * It receives all the elements by its constructor and can no longer be changed.
	 * All methods that change the list will throw an <code>UnsupportedOperationError</code>.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * import org.as3collections.lists.ReadOnlyArrayList;
	 * 
	 * var list1:IList = new ArrayList([3, 5, 1, 7]);
	 * 
	 * list1                       // [3,5,1,7]
	 * 
	 * var list2:IList = new ReadOnlyArrayList(list1.toArray());
	 * 
	 * list2                       // [3,5,1,7]
	 * 
	 * list2.add(1)                // UnsupportedOperationError: ReadOnlyArrayList is a read-only list and doesn't allow modifications.
	 * list2.remove(1)             // UnsupportedOperationError: ReadOnlyArrayList is a read-only list and doesn't allow modifications.
	 * 
	 * var list3:IList = list2.clone();
	 * 
	 * list3                       // [3,5,1,7]
	 * 
	 * list3.contains(2)           // false
	 * list3.contains(5)           // true
	 * list3.indexOf(5)            // 1
	 * list3.containsAll(list1)    // true
	 * list3.equals(list1)         // false
	 * list3.getAt(2)              // 1
	 * list3.subList(1, 3)         // [5,1]
	 * 
	 * list3.addAll(list2)         // UnsupportedOperationError: ReadOnlyArrayList is a read-only list and doesn't allow modifications.
	 * list3.removeRange(1, 3)     // UnsupportedOperationError: ReadOnlyArrayList is a read-only list and doesn't allow modifications.
	 * 
	 * var it:IIterator = list3.iterator();
	 * 
	 * while (it.hasNext())
	 * {
	 *     it.next()
	 * 
	 *     it.remove()             // UnsupportedOperationError: ReadOnlyArrayIterator is a read-only iterator and doesn't allow modifications in the collection.
	 * }
	 * 
	 * var it2:IListIterator = list3.listIterator();
	 * 
	 * while (it2.hasNext())
	 * {
	 *     it2.next()
	 * 
	 *     it.add(1)               // UnsupportedOperationError: ReadOnlyArrayListIterator is a read-only iterator and doesn't allow modifications in the list.
	 * }
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class ReadOnlyArrayList extends AbstractList
	{
		/**
		 * Constructor, creates a new <code>ReadOnlyArrayList</code> object.
		 * 
		 * @param 	source 	an array to fill the list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>source</code> argument is <code>null</code>.
		 */
		public function ReadOnlyArrayList(source:Array)
		{
			super(source);
			if (!source) throw new NullPointerError("The 'source' argument must not be 'null'.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param element
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function add(element:*): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param collection
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function addAll(collection:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param index
		 * @param collection
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function addAllAt(index:int, collection:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param index
		 * @param element
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function addAt(index:int, element:*): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 */
		override public function clear(): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * Creates and return a new <code>ReadOnlyArrayList</code> object containing all elements in this list (in the same order).
		 * 
		 * @return 	a new <code>ReadOnlyArrayList</code> object containing all elements in this list (in the same order).
 		 */
		override public function clone(): *
		{
			return new ReadOnlyArrayList(data);
		}
		
		/**
		 * Returns an iterator over a set of elements.
		 * <p>This implementation returns a <code>ReadOnlyArrayIterator</code> object.</p>
		 * 
		 * @return 	an iterator over a set of elements.
		 * @see 	org.as3collections.iterators.ReadOnlyArrayIterator ReadOnlyArrayIterator
		 */
		override public function iterator(): IIterator
		{
			return new ReadOnlyArrayIterator(data);
		}
		
		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list. The specified index indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified index minus one.
		 * <p>This implementation returns a <code>ReadOnlyArrayListIterator</code> object.</p>
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * @see 	org.as3collections.iterators.ReadOnlyArrayListIterator ReadOnlyArrayListIterator
		 */
		override public function listIterator(index:int = 0): IListIterator
		{
			return new ReadOnlyArrayListIterator(this, index);
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param o
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function remove(o:*): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param collection
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function removeAll(collection:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param index
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function removeAt(index:int): *
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param fromIndex
		 * @param toIndex
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param collection
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function retainAll(collection:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}
		
		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function reverse(): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param index
		 * @param element
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayList</code> is a read-only list and doesn't allow modifications.
		 * @return
		 */
		override public function setAt(index:int, element:*): *
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only list and doesn't allow modifications.");
		}

		/**
		 * Returns a new <code>ReadOnlyArrayList</code> that is a view of the portion of this <code>ReadOnlyArrayList</code> between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new <code>ReadOnlyArrayList</code> that is a view of the specified range within this list.
		 */
		override public function subList(fromIndex:int, toIndex:int): IList
		{
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			return new ReadOnlyArrayList(data.slice(fromIndex, toIndex));
		}

	}

}