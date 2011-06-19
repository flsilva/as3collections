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
	import flash.errors.IllegalOperationError;
	import org.as3coreaddendum.errors.CloneNotSupportedError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	/**
	 * This class provides a skeletal implementation of the <code>ICollection</code> interface, to minimize the effort required to implement this interface. 
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the collection being implemented admits a more efficient implementation.</p>
	 * <p><b>IMPORTANT:</b></p>
	 * <p>This class implements equality through the interface <code>org.as3coreaddendum.system.IEquatable</code> in the method <code>equals</code> and in all methods that compare the elements inside this collection (i.e. <code>contains</code>, <code>containsAll</code>, <code>remove</code>, <code>removeAll</code> and <code>retainAll</code>).</p>
	 * <p>In order to this collection uses the <code>equals</code> method of its elements in comparisons (rather than the default '==' operator), <b>all elements in this collection must implement the interface</b> <code>org.as3coreaddendum.system.IEquatable</code> <b>and also the supplied element.</b></p>
	 * <p>For example:</p>
	 * <p>myCollection.contains(myElement);</p>
	 * <p>All elements inside the collection and <code>myElement</code> must implement the <code>org.as3coreaddendum.system.IEquatable</code> interface so that <code>equals</code> method of each element can be used in the comparison.
	 * Otherwise '==' operator is used.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class AbstractCollection implements ICollection
	{
		/**
		 * @private
		 */
		protected var _allEquatable: Boolean = true;

		private var _data: Array = [];

		/**
		 * @inheritDoc
		 */
		public function get allEquatable(): Boolean { return _allEquatable; }

		/**
		 * @private
		 */
		protected function get data(): Array { return _data; }

		/**
		 * Constructor, creates a new AbstractCollection object.
		 * 
		 * @param 	source 	an array to fill the collection.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly, in other words, if there is <b>not</b> another class extending this class.
		 */
		public function AbstractCollection(source:Array = null)
		{
			if (ReflectionUtil.classPathEquals(this, AbstractCollection))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
			if (source)
			{
				_data.push.apply(_data, source);
				checkAllEquatable();
			}
		}

		/**
		 * Ensures that this collection contains the specified element (optional operation). 
		 * <p>Collections that support this operation may place limitations on what elements may be added to this collection.
		 * In particular, some collections will refuse to add <code>null</code> elements, and others will impose restrictions on the type of elements that may be added.
		 * Collection classes should clearly specify in their documentation any restrictions on what elements may be added.</p>
		 * <p>If a collection refuses to add a particular element for any reason other than that it already contains the element, it <b>must</b> throw an error (rather than returning <code>false</code>).
		 * This preserves the invariant that a collection always contains the specified element after this call returns.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>add</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this collection.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified element is <code>null</code> and this collection does not permit <code>null</code> elements.
		 * @return 	<code>true</code> if this collection changed as a result of the call. Returns <code>false</code> if this collection does not permit duplicates and already contains the specified element.
		 */
		public function add(element:*): Boolean
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Adds all of the elements in the specified collection to this collection (optional operation).
		 * <p>This implementation iterates over the specified collection, and adds each object returned by the iterator to this collection, in turn.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> unless <code>add</code> is overridden (assuming the specified collection is non-empty).</p>
		 * 
		 * @param  	collection 	the collection containing elements to be added to this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this collection.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @return 	<code>true</code> if this collection changed as a result of the call.
		 */
		public function addAll(collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				add(it.next());
			}
			
			return prevSize != size();
		}

		/**
		 * Removes all of the elements from this collection (optional operation). The collection will be empty after this method returns.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the clear operation is not supported by this collection.
		 */
		public function clear(): void
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Creates and return a shallow copy of this collection.
		 * <p>This implementation always throws a <code>CloneNotSupportedError</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.CloneNotSupportedError  	if this collection doesn't support clone.
		 * @return 	A new object that is a shallow copy of this instance.
 		 */
		public function clone(): *
		{
			throw new CloneNotSupportedError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Returns <code>true</code> if this collection contains the specified object.
		 * <p>This implementation uses the native <code>Array.indexOf</code> method.</p>
		 * 
		 * @param  	o 	object whose presence in this collection is to be tested.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this collection contains the specified object.
		 */
		public function contains(o:*): Boolean
		{
			if (isEmpty()) return false;
			
			if (allEquatable && o is IEquatable) return containsByEquality(o);
			
			return _data.indexOf(o) != -1;
		}

		/**
		 * Returns <code>true</code> if this collection contains all of the elements in the specified collection. 
		 * <p>This implementation iterates over the specified collection, checking each element returned by the iterator in turn to see if it's contained in this collection. If all elements are so contained <code>true</code> is returned, otherwise <code>false</code>.</p>
		 * 
		 * @param  	collection 	the collection to be checked for containment in this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in the specified collection are incompatible with this collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains one or more <code>null</code> elements and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection contains all of the elements in the specified collection.
		 */
		public function containsAll(collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return true;
			if (isEmpty()) return false;
			
			if (allEquatable && collection.allEquatable) return containsAllByEquality(collection);
			
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (!contains(it.next())) return false;
			}
			
			return true;
		}

		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * <p>This implementation considers two differente objects equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * </ul></p>
		 * <p>This implementation does not takes care of the order of the elements in the collections.
		 * For an equality that considers the order of the elements, this method should be overriden.</p>
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var c:ICollection = other as ICollection;
			
			if (c.size() != size()) return false;
			
			return containsAll(c) && c.containsAll(this);
		}

		/**
		 * @inheritDoc
 		 */
		public function isEmpty(): Boolean
		{
			return size() == 0;
		}

		/**
		 * Returns an iterator over a set of elements.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @return 	an iterator over a set of elements.
 		 */
		public function iterator(): IIterator
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this collection, if it is present (optional operation).
		 * <p>This implementation iterates over the collection looking for the specified element. If it finds the element, it removes the element from the collection using the iterator's remove method.</p>
		 * <p>Note that this implementation throws an <code>UnsupportedOperationError</code> if the iterator returned by this collection's iterator method does not implement the <code>remove</code> method and this collection contains the specified object.</p>
		 * 
		 * @param  	o 	the object to be removed from this collection, if present.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 */
		public function remove(o:*): Boolean
		{
			if (!contains(o)) return false;
			
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if ((allEquatable && o is IEquatable && (e as IEquatable).equals(o)) || e == o)
				{
					it.remove();
					checkAllEquatable();
					return true;
				}
			}
			
			return false;
		}

		/**
		 * Removes all of this collection's elements that are also contained in the specified collection (optional operation). After this call returns, this collection will contain no elements in common with the specified collection.
		 * <p>This implementation iterates over this collection, checking each element returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's so contained, it's removed from this collection with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this collection contains one or more elements in common with the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the removeAll operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in the specified collection are incompatible with this collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call.
		 */
		public function removeAll(collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			
			while (it.hasNext())
			{
				if (collection.contains(it.next())) it.remove();
			}
			
			checkAllEquatable();
			return prevSize != size();
		}

		/**
		 * Retains only the elements in this collection that are contained in the specified collection (optional operation). In other words, removes from this collection all of its elements that are not contained in the specified collection.
		 * <p>This implementation iterates over this collection, checking each element returned by the iterator in turn to see if it's contained in the specified collection.
		 * If it's not so contained, it's removed from this collection with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this collection contains one or more elements not present in the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be retained in this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in this collection are incompatible with the specified collection (optional).
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call. 	
		 */
		public function retainAll(collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			
			while (it.hasNext())
			{
				if (!collection.contains(it.next())) it.remove();
			}
			
			checkAllEquatable();
			return prevSize != size();
		}

		/**
		 * @inheritDoc
		 */
		public function size(): int
		{
			return _data.length;
		}

		/**
		 * @inheritDoc
		 */
		public function toArray(): Array
		{
			return _data.concat();
		}

		/**
		 * Returns the string representation of this instance.
		 * 
		 * @return the string representation of this instance.
 		 */
		public function toString(): String 
		{
			var s:String = "[";
			var it:IIterator = iterator();
			
			while (it.hasNext())
			{
				s += it.next();
				if (it.hasNext()) s += ",";
			}
			
			s += "]";
			
			return s;
		}

		/**
		 * @private
		 */
		protected function checkEquatable(element:*): void
		{
			if (!(element is IEquatable)) _allEquatable = false;
		}

		/**
		 * @private
		 */
		protected function checkAllEquatable(): void
		{
			_allEquatable = true;
			
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				checkEquatable(e);
				if (!_allEquatable) return;
			}
		}

		/**
		 * @private
		 */
		private function containsAllByEquality(collection:ICollection): Boolean
		{
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (!containsByEquality(it.next())) return false;
			}
			
			return true;
		}

		/**
		 * @private
		 */
		private function containsByEquality(o:*): Boolean
		{
			var it:IIterator = iterator();
			var e:IEquatable;
			
			while (it.hasNext())
			{
				e = it.next();
				if (e.equals(o)) return true;
			}
			
			return false;
		}

	}

}