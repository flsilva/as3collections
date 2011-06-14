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

package org.as3collections.lists {
	import org.as3collections.AbstractCollection;
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.iterators.ReadOnlyArrayListIterator;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides a skeletal implementation of the <code>IList</code> interface, to minimize the effort required to implement this interface.
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the collection being implemented admits a more efficient implementation.</p> 
	 * 
	 * @author Flávio Silva
	 */
	public class AbstractList extends AbstractCollection implements IList
	{
		protected var _modCount: int;
		
		/**
		 * @inheritDoc
		 */
		public function get modCount(): int { return _modCount; }
		
		/**
		 * Constructor, creates a new AbstractList object.
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
		 * <p>If a list refuses to add a particular element for any reason other than that it alread contains the element, it <b>must</b> throw an error (rather than returning <code>false</code>).
		 * This preserves the invariant that a list always contains the specified element after this call returns.</p>
		 * <p>This implementation calls <code>addAt(size(), element)</code>.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> unless <code>addAt</code> is overridden.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>add</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @return 	<code>true</code> if this list changed as a result of the call. Returns <code>false</code> if this list does not permit duplicates and alread contains the specified element.
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
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function addAll(collection:ICollection): Boolean
		{
			return addAllAt(size(), collection);
		}

		/**
		 * Inserts all of the elements in the specified collection into this list at the specified position (optional operation). Shifts the element currently at that position (if any) and any subsequent elements to the right (increases their indices). The new elements will appear in this list in the order that they are returned by the specified collection's iterator.
		 * <p>This implementation gets an iterator over the specified collection and iterates over it, inserting the elements obtained from the iterator into this list at the appropriate position, one at a time, using <code>addAt</code>.
		 * Other implementations can override this method for efficiency.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> unless <code>addAt</code> is overridden.</p>
		 * 
		 * @param  	index 		index at which to insert the first element from the specified collection.
		 * @param  	collection 	the collection containing elements to be added to this list.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAllAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		public function addAllAt(index:int, collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
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
		 * Inserts the specified element at the specified position in this list (optional operation). Shifts the element currently at that position (if any) and any subsequent elements to the right (adds one to their indices).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 		index at which the specified element is to be inserted.
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 * @return 	<code>true</code> if this list changed as a result of the call. Returns <code>false</code> if this list does not permit duplicates and alread contains the specified element.
		 */
		public function addAt(index:int, element:*): Boolean
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation takes care of the order of the elements in the list.
		 * So, for two collections are equal the order of elements returned by the iterator object must be equal.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		override public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var c:ICollection = other as ICollection;
			
			if (c.size() != size()) return false;
			
			var it:IIterator = iterator();
			var itOther:IIterator = c.iterator();
			var o1:*;
			var o2:*;
			
			while (it.hasNext())
			{
				o1 = it.next();
				o2 = itOther.next();
				
				if (allEquatable && c.allEquatable)
				{
					if (!(o1 as IEquatable).equals(o2)) return false;
				}
				else if (o1 != o2)
				{
					return false;
				}
			}
			
			return true;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 	if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 */
		public function getAt(index:int): *
		{
			checkIndex(index, size() - 1);
			return data[index];
		}

		/**
		 * Returns the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 * <p>This implementation uses the native <code>Array.indexOf</code> method.</p>
		 * 
		 * @param element 		the element to search for.
		 * @param fromIndex 	the position in the list from which to start searching for the element.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the first occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		public function indexOf(element:*, fromIndex:int = 0): int
		{
			if (allEquatable && element is IEquatable)
			{
				var it:IIterator = iterator();
				var e:*;
				
				while (it.hasNext())
				{
					e = it.next();
					if (it.pointer() >= fromIndex && (e as IEquatable).equals(element)) return it.pointer();
				}
			}
			
			return data.indexOf(element, fromIndex);
		}

		/**
		 * Returns the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 * <p>This implementation uses the native <code>Array.lastIndexOf</code> method.</p>
		 * 
		 * @param element 		the element to search for.
		 * @param fromIndex 	the position in the list from which to start searching for the element. The default is the maximum value allowed for an index. If you do not specify <code>fromIndex</code>, the search starts at the last item in the list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the class of the specified element is incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified element is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	the index of the last occurrence of the specified element in this list, or -1 if this list does not contain the element.
		 */
		public function lastIndexOf(element:*, fromIndex:int = 0x7fffffff): int
		{
			if (allEquatable && element is IEquatable)
			{
				var it:IListIterator = listIterator();
				var e:*;
				
				while (it.hasNext()) it.next();
				
				while (it.hasPrevious())
				{
					e = it.previous();
					if (it.pointer() >= fromIndex && (e as IEquatable).equals(element)) return it.pointer();
				}
			}
			
			return data.lastIndexOf(element, fromIndex);
		}

		/**
		 * Returns a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list. The specified index indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified index minus one.
		 * <p>This implementation returns a <code>ReadOnlyArrayListIterator</code> object.</p>
		 * 
		 * @param  	index 	index of first element to be returned from the list iterator (by a call to the <code>next</code> method) 
		 * @return 	a list iterator of the elements in this list (in proper sequence), starting at the specified position in this list.
		 * @see 	org.as3collections.iterators.ReadOnlyArrayListIterator ReadOnlyArrayListIterator
		 */
		public function listIterator(index:int = 0): IListIterator
		{
			return new ReadOnlyArrayListIterator(this, index);
		}

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this list, if it is present (optional operation).
		 * <p>This implementation iterates over the list looking for the specified element. If it finds the element, it removes the element from the list using the iterator's remove method.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> if the iterator returned by this list's iterator method does not implement the <code>remove</code> method and this list contains the specified object.</p>
		 * 
		 * @param  	o 	the object to be removed from this list, if present.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified object is incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified object is <code>null</code> and this list does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 */
		override public function remove(o:*): Boolean
		{
			/*
			if (!contains(o)) return false;
			
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if ((allEquatable && o is IEquatable && (e as IEquatable).equals(o)) || e == o)
				{
					it.remove();
					_modCount++;
					return true;
				}
			}
			
			return false;
			*/
			
			var b:Boolean = super.remove(o);
			if (b) _modCount++;
			
			return b;
		}

		/**
		 * Removes all of this list's elements that are also contained in the specified collection (optional operation). After this call returns, this list will contain no elements in common with the specified collection.
		 * <p>This implementation iterates over this list, checking each element returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's so contained, it's removed from this list with the iterator's <code>remove</code> method. </p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this list contains one or more elements in common with the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this list.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the removeAll operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements the specified colleciton are incompatible with this list (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this list changed as a result of the call.
		 */
		override public function removeAll(collection:ICollection): Boolean
		{
			/*
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			
			while (it.hasNext())
			{
				if (collection.contains(it.next()))
				{
					it.remove();
					_modCount++;
				}
			}
			
			return prevSize != size();
			*/
			
			var prevSize:int = size();
			
			var b:Boolean = super.removeAll(collection);
			if (b) _modCount += prevSize - size();
			
			return b;
		}

		/**
		 * Removes the element at the specified position in this list (optional operation). Shifts any subsequent elements to the left (subtracts one from their indices). Returns the element that was removed from the list. 
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	the index of the element to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		public function removeAt(index:int): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes all of the elements whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation). Shifts any subsequent elements to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing elements (inclusive).
		 * @param  	toIndex 	the index to stop removing elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new collection containing all the removed elements.
		 */
		public function removeRange(fromIndex:int, toIndex:int): ICollection
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * @inheritDoc
		 */
		public function reverse(): void
		{
			data.reverse();
		}

		/**
		 * Retains only the elements in this list that are contained in the specified collection (optional operation). In other words, removes from this list all of its elements that are not contained in the specified collection.
		 * <p>This implementation iterates over this list, checking each element returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's not so contained, it's removed from this collection with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this list contains one or more elements not present in the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be retained in this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in this list are incompatible with the specified collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this list does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call. 	
		 */
		override public function retainAll(collection:ICollection): Boolean
		{
			/*
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			
			while (it.hasNext())
			{
				if (!collection.contains(it.next()))
				{
					it.remove();
					_modCount++;
				}
			}
			
			return prevSize != size();
			*/
			
			var prevSize:int = size();
			
			var b:Boolean = super.retainAll(collection);
			if (b) _modCount += prevSize - size();
			
			return b;
		}

		/**
		 * Replaces the element at the specified position in this list with the specified element (optional operation).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 		index of the element to replace.
		 * @param  	element 	element to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setAt</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this list does not permit <code>null</code> elements.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the element previously at the specified position.
		 */
		public function setAt(index:int, element:*): *
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Returns a new list that is a view of the portion of this list between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>The returned list supports all of the optional list operations supported by this list.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving elements (inclusive).
		 * @param  	toIndex 	the index to stop retrieving elements (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subList</code> operation is not supported by this list.
		 * @throws 	org.as3coreaddendum.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
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

	}

}