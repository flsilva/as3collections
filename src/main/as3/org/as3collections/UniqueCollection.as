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
	import org.as3collections.utils.CollectionUtil;
	import org.as3coreaddendum.errors.NullPointerError;

	/**
	 * <code>UniqueCollection</code> works as a wrapper for a collection.
	 * <p>It does not allow duplicate elements in the collection.</p>
	 * <p>It stores the <code>wrapCollection</code> constructor's argument internally.
	 * So every method call to this class is forwarded to the <code>wrappedCollection</code> object.
	 * The methods that need to be checked for duplication are previously validated before forward the call.
	 * No error is thrown by the validation of duplication.
	 * The calls that are forwarded to the <code>wrappedCollection</code> returns the return of the <code>wrappedCollection</code> call.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class UniqueCollection implements ICollection
	{
		private var _wrappedCollection: ICollection;

		/**
		 * @inheritDoc
		 */
		public function get allEquatable(): Boolean { return _wrappedCollection.allEquatable; }

		/**
		 * @private
		 */
		protected function get wrappedCollection(): ICollection { return _wrappedCollection; }
		
		/**
		 * Constructor, creates a new <code>UniqueCollection</code> object.
		 * 
		 * @param 	wrapCollection 	the target collection to wrap.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapCollection</code> argument is <code>null</code>.
		 */
		public function UniqueCollection(wrapCollection:ICollection)
		{
			if (!wrapCollection) throw new NullPointerError("The 'wrapCollection' argument must not be 'null'.");
			_wrappedCollection = CollectionUtil.removeDuplicate(wrapCollection);
		}

		/**
		 * If <code>wrappedCollection.contains(element)</code> returns <code>true</code>, then this method returns <code>false</code>. Otherwise, it forwards the call to <code>wrappedCollection.add</code>.
		 * 
		 * @param  	element 	the element to forward to <code>wrappedCollection.add</code>.
		 * @return 	<code>false</code> if <code>wrappedCollection.contains(element)</code> returns <code>true</code>. Otherwise returns the return of the call <code>wrappedCollection.add</code>.
		 */
		public function add(element:*): Boolean
		{
			if (_wrappedCollection.contains(element)) return false;
			return _wrappedCollection.add(element);
		}

		/**
		 * If the specified collection is empty returns <code>false</code>. Otherwise, it clones the specified collection, removes all elements that already are in the <code>wrappedCollection</code> and removes all duplicates. Then it forwards the call to <code>wrappedCollection.addAll</code> sending the cloned and filtered collection.
		 * 
		 * @param  	collection 	the collection to forward to <code>wrappedCollection.addAll</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	 if the specified collection contains a <code>null</code> element and <code>wrappedCollection</code> does not permit <code>null</code> elements, or if the specified collection is <code>null</code>.
		 * @return 	<code>false</code> if the specified collection is <code>null</code> or empty. Otherwise returns the return of the call <code>wrappedCollection.addAll</code>.
		 */
		public function addAll(collection:ICollection): Boolean
		{
			if (!collection) throw new NullPointerError("The 'collection' argument must not be 'null'.");
			if (collection.isEmpty()) return false;
			
			var c:ICollection = collection.clone();
			filterCollection(c);
			
			if (c.isEmpty()) return false;
			
			return _wrappedCollection.addAll(c);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.clear</code>.
		 */
		public function clear(): void
		{
			_wrappedCollection.clear();
		}

		/**
		 * Creates and return a new <code>UniqueCollection</code> object with the clone of the <code>wrappedCollection</code> object.
		 * 
		 * @return 	a new <code>UniqueCollection</code> object with the clone of the <code>wrappedCollection</code> object.
 		 */
		public function clone(): *
		{
			return new UniqueCollection(_wrappedCollection.clone());
		}

		/**
		 * Forwards the call to <code>wrappedCollection.contains</code>.
		 * 
		 * @param  	o
		 * @return 	the return of the call <code>wrappedCollection.contains</code>.
		 */
		public function contains(o:*): Boolean
		{
			return _wrappedCollection.contains(o);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.containsAll</code>.
		 * 
		 * @param collection
		 * @return 	the return of the call <code>wrappedCollection.containsAll</code>.
		 */
		public function containsAll(collection:ICollection): Boolean
		{
			return _wrappedCollection.containsAll(collection);
		}

		/**
		 * This method uses <code>CollectionUtil.equalNotConsideringOrder</code> method to perform equality, sending this collection and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalNotConsideringOrder() CollectionUtil.equalNotConsideringOrder()
		 */
		public function equals(other:*): Boolean
		{
			return CollectionUtil.equalNotConsideringOrder(this, other);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.isEmpty</code>.
		 * 
		 * @return 	the return of the call <code>wrappedCollection.isEmpty</code>.
 		 */
		public function isEmpty(): Boolean
		{
			return _wrappedCollection.isEmpty();
		}

		/**
		 * Forwards the call to <code>wrappedCollection.iterator</code>.
		 * 
		 * @return 	the return of the call <code>wrappedCollection.iterator</code>.
 		 */
		public function iterator(): IIterator
		{
			return _wrappedCollection.iterator();
		}

		/**
		 * Forwards the call to <code>wrappedCollection.remove</code>.
		 * 
		 * @param o
		 * @return 	the return of the call <code>wrappedCollection.remove</code>.
		 */
		public function remove(o:*): Boolean
		{
			return _wrappedCollection.remove(o);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.removeAll</code>.
		 * 
		 * @param collection
		 * @return 	the return of the call <code>wrappedCollection.removeAll</code>.
		 */
		public function removeAll(collection:ICollection): Boolean
		{
			return _wrappedCollection.removeAll(collection);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.retainAll</code>.
		 * 
		 * @param collection
		 * @return 	the return of the call <code>wrappedCollection.retainAll</code>.
		 */
		public function retainAll(collection:ICollection): Boolean
		{
			return _wrappedCollection.retainAll(collection);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.size</code>.
		 * 
		 * @return 	the return of the call <code>wrappedCollection.size</code>.
 		 */
		public function size(): int
		{
			return _wrappedCollection.size();
		}

		/**
		 * Forwards the call to <code>wrappedCollection.toArray</code>.
		 * 
		 * @return 	the return of the call <code>wrappedCollection.toArray</code>.
 		 */
		public function toArray(): Array
		{
			return _wrappedCollection.toArray();
		}

		/**
		 * Returns the string representation of this instance.
		 * <p>This method uses <code>CollectionUtil.toString</code> method.</p>
		 * 
		 * @return the string representation of this instance.
 		 */
		public function toString():String 
		{
			return CollectionUtil.toString(this);
		}

		/**
		 * @private
 		 */
		protected function filterCollection(collection:ICollection):void
		{
			collection.removeAll(_wrappedCollection);
			CollectionUtil.removeDuplicate(collection);
		}

	}

}