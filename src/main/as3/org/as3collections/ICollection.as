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
	import org.as3collections.IIterable;
	import org.as3coreaddendum.system.ICloneable;
	import org.as3coreaddendum.system.IEquatable;

	/**
	 * The root interface in the <em>collection hierarchy</em>.
	 * A collection represents a group of objects, known as its <em>elements</em>.
	 * <p>Some collections allow duplicate elements and others do not. Some are ordered and others unordered.</p>
	 * <p>This interface is typically used to pass collections around and manipulate them where maximum generality is desired.</p>
	 * <p>The methods that modify the collection are specified to throw org.as3coreaddendum.errors.UnsupportedOperationError if the collection does not support the operation.
	 * These methods are documented as "optional operation".</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @see 	org.as3collections.AbstractCollection AbstractCollection
	 * @see 	org.as3collections.IIterable IIterable
	 * @see 	org.as3collections.IList IList
	 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/IEquatable.html	org.as3coreaddendum.system.IEquatable
	 * @see 	http://as3coreaddendum.org/en-us/documentation/asdoc/org/as3coreaddendum/system/ICloneable.html	org.as3coreaddendum.system.ICloneable
	 * @author Flávio Silva
	 */
	public interface ICollection extends IIterable, ICloneable, IEquatable
	{
		/**
		 * Indicates whether all elements in this collection implement the interface <code>org.as3coreaddendum.system.IEquatable</code>.
		 */
		function get allEquatable(): Boolean;

		/**
		 * Ensures that this collection contains the specified element (optional operation). 
		 * <p>Collections that support this operation may place limitations on what elements may be added to this collection.
		 * In particular, some collections will refuse to add <code>null</code> elements, and others will impose restrictions on the type of elements that may be added.
		 * Collection classes should clearly specify in their documentation any restrictions on what elements may be added.</p>
		 * <p>If a collection refuses to add a particular element for any reason other than that it already contains the element, it <em>must</em> throw an error (rather than returning <code>false</code>).
		 * This preserves the invariant that a collection always contains the specified element after this call returns.</p>
		 * 
		 * @param  	element 	the element to be added.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>add</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this collection.
		 * @throws 	ArgumentError  	 										if the specified element is <code>null</code> and this collection does not permit <code>null</code> elements.
		 * @return 	<code>true</code> if this collection changed as a result of the call. Returns <code>false</code> if this collection does not permit duplicates and already contains the specified element.
		 */
		function add(element:*): Boolean;

		/**
		 * Adds all of the elements in the specified collection to this collection (optional operation).
		 * 
		 * @param  	collection 	collection containing elements to be added to this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>addAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of an element of the specified collection prevents it from being added to this collection.
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements, or if the specified collection is <code>null</code>. 
		 * @return 	<code>true</code> if this collection changed as a result of the call.
		 */
		function addAll(collection:ICollection): Boolean;

		/**
		 * Removes all of the elements from this collection (optional operation).
		 * The collection will be empty after this method returns.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>clear</code> operation is not supported by this collection.
		 */
		function clear(): void;

		/**
		 * Returns <code>true</code> if this collection contains the specified object.
		 * 
		 * @param  	o 	object whose presence in this collection is to be tested.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	ArgumentError  	if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if this collection contains the specified object.
		 */
		function contains(o:*): Boolean;

		/**
		 * Returns <code>true</code> if this collection contains all of the elements in the specified collection. 
		 * 
		 * @param  	collection 	the collection to be checked for containment in this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in the specified collection are incompatible with this collection (optional).
		 * @throws 	ArgumentError  	 		if the specified collection contains one or more <code>null</code> elements and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection contains all of the elements in the specified collection.
		 */
		function containsAll(collection:ICollection): Boolean;

		/**
		 * Returns <code>true</code> if this collection contains no elements.
		 * 
		 * @return 	<code>true</code> if this collection contains no elements.
 		 */
		function isEmpty(): Boolean;

		/**
		 * Removes a single instance (only one occurrence) of the specified object from this collection, if it is present (optional operation).
		 * 
		 * @param  	o 	the object to be removed from this collection, if present.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the type of the specified object is incompatible with this collection (optional).
		 * @throws 	ArgumentError  	 										if the specified object is <code>null</code> and this collection does not permit <code>null</code> elements (optional).
		 * @return 	<code>true</code> if an object was removed as a result of this call.
		 * @see 	org.as3collections.utils.CollectionUtil#removeAllOccurances() 	CollectionUtil.removeAllOccurances()
		 */
		function remove(o:*): Boolean;

		/**
		 * Removes all elements of this collection that are also contained in the specified collection (optional operation).
		 * After this call returns, this collection will contain no elements in common with the specified collection.
		 * 
		 * @param  	collection 	the collection containing elements to be removed from this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in this collection are incompatible with the specified collection (optional).
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection has changed as a result of the call.
		 */
		function removeAll(collection:ICollection): Boolean;

		/**
		 * Retains only the elements in this collection that are contained in the specified collection (optional operation).
		 * In other words, removes from this collection all of its elements that are not contained in the specified collection.
		 * 
		 * @param  	collection 	the collection containing elements to be retained in this collection.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>retainAll</code> operation is not supported by this collection.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the types of one or more elements in this collection are incompatible with the specified collection (optional).
		 * @throws 	ArgumentError  	 										if the specified collection contains a <code>null</code> element and this collection does not permit <code>null</code> elements (optional), or if the specified collection is <code>null</code>.
		 * @return 	<code>true</code> if this collection changed as a result of the call. 	
		 */
		function retainAll(collection:ICollection): Boolean;

		/**
		 * Returns the number of elements in this collection.
		 * 
		 * @return 	the number of elements in this collection.
 		 */
		function size(): int;

		/**
		 * Returns an array containing all of the elements in this collection.
		 * <p>If this collection makes any guarantees as to what order its elements are returned by its iterator, this method must return the elements in the same order.</p>
		 * <p>The returned array will be "safe" in that no references to it are maintained by this collection.
		 * (In other words, this method must allocate a new array even if this collection is backed by an array).
		 * The caller is thus free to modify the returned array.</p>
		 * 
		 * @return 	a new array object containing all of the elements in this collection.
 		 */
		function toArray(): Array;
	}

}