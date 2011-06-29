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
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides a skeletal implementation of the <code>IList</code> interface, to minimize the effort required to implement this interface.
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the collection being implemented admits a more efficient implementation.</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p> 
	 * 
	 * @see 	org.as3collections.IList IList
	 * @see 	org.as3collections.lists.ArrayList ArrayList
	 * @author Flávio Silva
	 */
	public class AbstractList extends AbstractCollection implements IList
	{
		/**
		 * @private
		 */
		protected var _modCount: int;
		
		/**
		 * @inheritDoc
		 */
		public function get modCount(): int { return _modCount; }
		
		/**
		 * This is an abstract class and shouldn't be instantiated directly.
		 * 
		 * @param 	source 	an array to fill the list.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractList(source:Array = null)
		{
			super(source);
			if (ReflectionUtil.classPathEquals(this, AbstractList)) throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
		}

		/**
		 * Appends the specified element to the end of this list (optional operation).
		 * <p>Lists that support this operation may place limitations on what elements may be added to this list.
		 * In particular, some lists will refuse to add <code>null</code> elements, and others will impose restrictions on the type of elements that may be added.
		 * Lists classes should clearly specify in their documentation any restrictions on what elements may be added.</p>
		 * <p>If a list refuses to add a particular element for any reason other than that it already contains the element, it <em>must</em> throw an error (rather than returning <code>false</code>).
		 * This preserves the invariant that a list always contains the specified element after this call returns.</p>
		 * <p>This implementation calls <code>addAt(size(), element)</code>.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> unless <code>addAt</code> is overridden.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>add</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	ArgumentError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @return 	<code>true</code> if this list changed as a result of the call. Returns <code>false</code> if this list does not permit duplicates and already contains the specified element.
		 */
		override public function add(element:*): Boolean
		{
			return addAt(size(), element);
		}

		/**
		 * Adds all of the elements in the specified collection to this list (optional operation).
		 * <p>This implementation calls <code>addAllAt(size(), collection)</code>.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> unless <code>addAt</code> is overridden (assuming the specified collection is non-empty).</p>
		 * 
		 * @param  	collection 	the collection containing elements to be added to this list.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAll</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this list.
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function addAll(collection:ICollection): Boolean
		{
			return addAllAt(size(), collection);
		}

		/**
		 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation).
		 * Shifts the element currently at that position (if any) and any subsequent elements to the right (increases their indices).
		 * The new elements will appear in this list in the order that they are returned by the specified collection's iterator.
		 * <p>This implementation gets an iterator over the specified collection and iterates over it, inserting the elements obtained from the iterator into this list at the appropriate position, one at a time, using <code>addAt</code>.
		 * Other implementations can override this method for efficiency.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> unless <code>addAt</code> is overridden.</p>
		 * 
		 * @param  	index 		index at which to insert the first element from the specified collection.
		 * @param  	collection 	the collection containing elements to be added to this list.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAllAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this list.
		 * @throws 	ArgumentError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		public function addAllAt(index:int, collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			checkIndex(index, size());
			
			var prevSize:int = size();
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (addAt(index, it.next())) index++;
			}
			
			return prevSize != size();
		}

		/**
		 * Inserts the specified element at the specified position in this list (optional operation).
		 * Shifts the element currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	ArgumentError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 * @return 	<code>true</code> if this list changed as a result of the call. Returns <code>false</code> if this list does not permit duplicates and already contains the specified element.
		 */
		public function addAt(index:int, element:*): Boolean
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
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
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 */
		public function getAt(index:int): *
		{
			checkIndex(index, size() - 1);
			return data[index];
		}

		/**
		 * Returns the index of the <em>first occurrence</em> of the specified element in this list, or -1 if this list does not contain the element.
		 * <p>If all elements in this list and <code>element</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this list using <code>equals</code> method of the elements.
		 * Otherwise this implementation uses native <code>Array.indexOf</code> method.</p>
		 * 
		 * @param 	element 	the element to search for.
		 * @param 	fromIndex 	the position in the list from which to start searching for the element.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	ArgumentError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		public function indexOf(element:*, fromIndex:int = 0): int
		{
			if (allEquatable && element is IEquatable)
			{
				return indexOfByEquality(element, fromIndex);
			}
			else
			{
				return data.indexOf(element, fromIndex);
			}
		}

		/**
		 * Returns the index of the <em>last occurrence</em> of the specified element in this list, or -1 if this list does not contain the element.
		 * <p>If all elements in this list and <code>element</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this list using <code>equals</code> method of the elements.
		 * Otherwise this implementation uses native <code>Array.lastIndexOf</code> method.</p>
		 * 
		 * @param element 		the element to search for.
		 * @param fromIndex 	the position in the list from which to start searching for the element. The default is the maximum value allowed for an index. If you do not specify <code>fromIndex</code>, the search starts at the last item in the list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	ArgumentError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		public function lastIndexOf(element:*, fromIndex:int = 0x7fffffff): int
		{
			if (allEquatable && element is IEquatable)
			{
				return lastIndexOfByEquality(element, fromIndex);
			}
			else
			{
				return data.lastIndexOf(element, fromIndex);
			}
		}

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * The specified index indicates the first element that would be returned by an initial call to <code>next</code>.
		 * An initial call to <code>previous</code> would return the element with the specified index minus one.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * @see 	org.as3collections.IListIterator IListIterator
		 */
		public function listIterator(index:int = 0): IListIterator
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes the element at the specified position in this list (optional operation).
		 * Shifts any subsequent elements to the left (subtracts one from their indices).
		 * Returns the element that was removed from the list. 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	the index of the element to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this list.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		public function removeAt(index:int): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes all of the elements whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation).
		 * Shifts any subsequent elements to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing elements (inclusive).
		 * @param  	toIndex 	the index to stop removing elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this list.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new collection containing all the removed elements.
		 */
		public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Reverses the order of the elements in this list.
		 * This implementation uses native <code>Array.reverse</code> method.
		 */
		public function reverse(): void
		{
			if (size() < 2) return;
			data.reverse();
		}

		/**
		 * Replaces the element at the specified position in this list with the specified element (optional operation).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 		index of the element to replace.
		 * @param  	element 	element to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	ArgumentError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		public function setAt(index:int, element:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Returns a new list that is a view of the portion of this list between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>This list should not be modified.</p>
		 * <p>The returned list should support all of the optional list operations supported by this list.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subList</code> operation is not supported by this list.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		public function subList(fromIndex:int, toIndex:int): IList
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
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
		override protected function elementAdded(element:*): void
		{
			super.elementAdded(element);
			_modCount++;
		}
		
		/**
		 * @private
		 */
		override protected function elementRemoved(element:*): void
		{
			super.elementRemoved(element);
			_modCount++;
		}

		/**
		 * @private
		 */
		private function indexOfByEquality(element:*, fromIndex:int = 0): int
		{
			var it:IListIterator = listIterator(fromIndex);
			var e:IEquatable;
			
			while (it.hasNext())
			{
				e = it.next();
				if (e.equals(element)) return it.pointer();
			}
			
			return -1;
		}
		
		/**
		 * @private
		 */
		private function lastIndexOfByEquality(element:*, fromIndex:int = 0x7fffffff): int
		{
			if (fromIndex < 0x7fffffff) fromIndex++;
			if (fromIndex > size()) fromIndex = size();
			
			var it:IListIterator = listIterator(fromIndex);
			var e:IEquatable;
			
			while (it.hasPrevious())
			{
				e = it.previous();
				if (e.equals(element)) return it.nextIndex();
			}
			
			return -1;
		}

	}

}