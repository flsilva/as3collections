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

package org.as3collections
{
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.CloneNotSupportedError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * This class provides a skeletal implementation of the <code>ICollection</code> interface, to minimize the effort required to implement this interface. 
	 * <p>This is an abstract class and shouldn't be instantiated directly.</p>
	 * <p>The documentation for each non-abstract method in this class describes its implementation in detail.
	 * Each of these methods may be overridden if the collection being implemented admits a more efficient implementation.</p>
	 * <p>This class maintains a native <code>Array</code> object as its source.</p>
	 * <p><b>IMPORTANT:</b></p>
	 * <p>This class implements equality through <code>org.as3coreaddendum.system.IEquatable</code> interface in the <code>equals</code> method and in all methods that compares the elements inside this collection (i.e. <code>contains</code>, <code>containsAll</code>, <code>remove</code>, <code>removeAll</code> and <code>retainAll</code>).</p>
	 * <p>In order to this collection uses the <code>equals</code> method of its elements in comparisons (rather than default '==' operator), <b>all elements in this collection must implement the</b> <code>org.as3coreaddendum.system.IEquatable</code> <b>interface and also the supplied element.</b></p>
	 * <p>For example:</p>
	 * <p>myCollection.contains(myElement);</p>
	 * <p>All elements inside <code>myCollection</code>, and <code>myElement</code>, must implement the <code>org.as3coreaddendum.system.IEquatable</code> interface so that <code>equals</code> method of each element can be used in the comparison.
	 * Otherwise '==' operator is used.</p>
	 * <p>All subclasses of this class <em>must</em> conform with this behavior.</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @see 	org.as3collections.ICollection ICollection
	 * @see 	org.as3collections.AbstractList AbstractList
	 * @see 	org.as3collections.AbstractQueue AbstractQueue
	 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
	 * @author Flávio Silva
	 */
	public class AbstractArrayCollection implements ICollection
	{
		/**
		 * @private
		 */
		protected var _totalEquatable: int;

		private var _data: Array;

		/**
		 * @inheritDoc
		 */
		public function get allEquatable(): Boolean { return _totalEquatable == size(); }

		/**
		 * @private
		 */
		protected function get data(): Array { return _data; }

		/**
		 * This is an abstract class and shouldn't be instantiated directly.
		 * 
		 * @param 	source 	an array to fill the collection.
		 * @throws 	IllegalOperationError 	If this class is instantiated directly. In other words, if there is <em>not</em> another class extending this class.
		 */
		public function AbstractArrayCollection(source:Array = null)
		{
			if (ReflectionUtil.classPathEquals(this, AbstractArrayCollection))  throw new IllegalOperationError(ReflectionUtil.getClassName(this) + " is an abstract class and shouldn't be instantiated directly.");
			
			_data = [];
			
			if (source && source.length > 0)
			{
				_data.push.apply(_data, source);
				
				var it:IIterator = iterator();
				var e:*;
				
				while(it.hasNext())
				{
					e = it.next();
					elementAdded(e);
				}
			}
		}

		/**
		 * Ensures that this collection contains the specified element (optional operation). 
		 * <p>Collections that support this operation may place limitations on what elements may be added to this collection.
		 * In particular, some collections will refuse to add <code>null</code> elements, and others will impose restrictions on the type of elements that may be added.
		 * Collection classes should clearly specify in their documentation any restrictions on what elements may be added.</p>
		 * <p>If a collection refuses to add a particular element for any reason other than that it already contains the element, it <em>must</em> throw an error (rather than returning <code>false</code>).
		 * This preserves the invariant that a collection always contains the specified element after this call returns.</p>
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>add</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this collection.
		 * @throws 	ArgumentError  	 										if the specified element is <code>null</code> and this collection does not permit <code>null</code> elements.
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
		 * @throws 	ArgumentError  	 		if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @return 	<code>true</code> if this collection changed as a result of the call.
		 */
		public function addAll(collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
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
		 * Removes all of the elements from this collection (optional operation).
		 * The collection will be empty after this method returns.
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
		 * <p>This implementation always throws a <code>org.as3coreaddendum.errors.CloneNotSupportedError</code>.</p>
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
		 * <p>If all elements in this collection and <code>o</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation will iterate over this collection using <code>equals</code> method of the elements.
		 * Otherwise this implementation uses native <code>Array.indexOf</code> method.</p>
		 * 
		 * @param  	o 	object whose presence in this collection is to be tested.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	ArgumentError  	if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
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
		 * <p>This implementation iterates over the specified collection, checking each element returned by the iterator in turn to see if it's contained in this collection.
		 * If all elements are so contained <code>true</code> is returned, otherwise <code>false</code>.</p>
		 * <p>If all elements in this collection and all elements in <code>collection</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, <code>equals</code> method of the elements will be used.
		 * Otherwise this implementation uses native <code>Array.indexOf</code> method.</p>
		 * 
		 * @param  	collection 	the collection to be checked for containment in this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in the specified collection are incompatible with this collection (optional).
		 * @throws 	ArgumentError  	 										if the specified collection contains one or more <code>null</code> elements and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection contains all of the elements in the specified collection.
		 */
		public function containsAll(collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
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
		 * This method uses <code>CollectionUtil.equalNotConsideringOrder</code> method to perform equality, sending this collection and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalNotConsideringOrder() CollectionUtil.equalNotConsideringOrder()
		 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
		 */
		public function equals(other:*): Boolean
		{
			return CollectionUtil.equalNotConsideringOrder(this, other);
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
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	this method must be overridden in subclass.
		 * @see 	org.as3collections.IIterator IIterator
 		 */
		public function iterator(): IIterator
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this collection, if it is present (optional operation).
		 * <p>If all elements in this collection and <code>o</code> argument implement <code>org.as3coreaddendum.system.IEquatable</code>, this implementation iterates over this collection looking for the specified element.
		 * If it finds the element, it removes the element from the collection using the iterator's remove method.
		 * In this case, note that this implementation throws an <code>UnsupportedOperationError</code> if the iterator returned by this collection's iterator method does not implement the <code>remove</code> method.</p>
		 * <p>Otherwise this implementation uses native <code>Array.indexOf</code> method to get the index of the element and then uses native <code>Array.splice</code> method to remove it.</p>
		 * 
		 * @param  	o 	the object to be removed from this collection, if present.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	ArgumentError  	 										if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 */
		public function remove(o:*): Boolean
		{
			if (allEquatable && o is IEquatable)
			{
				return removeByEquality(o);
			}
			else
			{
				return removeByInstance(o);
			}
		}

		/**
		 * Removes all of this collection's elements that are also contained in the specified collection (optional operation).
		 * After this call returns, this collection will contain no elements in common with the specified collection.
		 * <p>This implementation iterates over this collection, checking each element returned by the iterator in turn to see if it's contained in the specified collection (using <code>contains</code> method of the <code>collection</code> argument).
		 * If it's so contained, it's removed from this collection with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this collection contains one or more elements in common with the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the removeAll operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in the specified collection are incompatible with this collection (optional).
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call.
		 */
		public function removeAll(collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if (collection.contains(e))
				{
					it.remove();
					elementRemoved(e);
				}
			}
			
			return prevSize != size();
		}

		/**
		 * Retains only the elements in this collection that are contained in the specified collection (optional operation).
		 * In other words, removes from this collection all of its elements that are not contained in the specified collection.
		 * <p>This implementation iterates over this collection, checking each element returned by the iterator in turn to see if it's contained in the specified collection (using <code>contains</code> method of the <code>collection</code> argument).
		 * If it's not so contained, it's removed from this collection with the iterator's <code>remove</code> method.</p>
		 * <p>Note that this implementation will throw an <code>UnsupportedOperationError</code> if the iterator returned by the iterator method does not implement the <code>remove</code> method and this collection contains one or more elements not present in the specified collection.</p>
		 * 
		 * @param  	collection 	the collection containing elements to be retained in this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in this collection are incompatible with the specified collection (optional).
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call. 	
		 */
		public function retainAll(collection:ICollection): Boolean
		{
			if (!collection) throw new ArgumentError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var prevSize:int = size();
			var it:IIterator = iterator();
			var e:*;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if (!collection.contains(e))
				{
					it.remove();
					elementRemoved(e);
				}
			}
			
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
		 * <p>This method uses <code>CollectionUtil.toString</code> method.</p>
		 * 
		 * @return the string representation of this instance.
		 * @see 	org.as3collections.utils.CollectionUtil#toString() CollectionUtil.toString()
 		 */
		public function toString(): String 
		{
			return CollectionUtil.toString(this);
		}
		
		/**
		 * @private
		 */
		protected function elementAdded(element:*): void
		{
			if (element && element is IEquatable) _totalEquatable++;
		}
		
		/**
		 * @private
		 */
		protected function elementRemoved(element:*): void
		{
			if (element && element is IEquatable) _totalEquatable--;
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
		
		/**
		 * @private
		 */
		private function removeByEquality(o:*): Boolean
		{
			var it:IIterator = iterator();
			var e:IEquatable;
			var removed:Boolean;
			
			while (it.hasNext())
			{
				e = it.next();
				
				if (e.equals(o))
				{
					it.remove();
					elementRemoved(e);
					removed = true;
					break;
				}
			}
			
			return removed;
		}
		
		/**
		 * @private
		 */
		private function removeByInstance(o:*): Boolean
		{
			var index:int = _data.indexOf(o);
			if (index == -1) return false;
			
			_data.splice(index, 1);
			elementRemoved(o);
			
			return true;
		}

	}

}