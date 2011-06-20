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
	import org.as3coreaddendum.errors.ClassCastError;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3coreaddendum.system.ITypeable;
	import org.as3utils.ReflectionUtil;

	/**
	 * <p><code>TypedCollection</code> works as a wrapper for a collection.</p>
	 * <p>Since ActionScript 3.0 does not support typed arrays, <code>TypedCollection</code> is a way to create typed collections.</p>
	 * <p>It stores the <code>wrapCollection</code> constructor's argument internally.
	 * So every method call to this class is forwarded to the <code>wrappedCollection</code> object.
	 * The methods that need to be checked for the type of the elements are previously validated with the <code>validateType</code> or <code>validateCollection</code> method before forward the call.
	 * If the type of an element requested to be added to this collection is incompatible with the type of the collection a <code>org.as3coreaddendum.errors.ClassCastError</code> is thrown.
	 * The calls that are forwarded to the <code>wrappedCollection</code> returns the return of the <code>wrappedCollection</code> call.</p>
	 * <p>The <code>TypedCollection.type</code> setter is not supported and will thrown an <code>UnsupportedOperationError</code> if used.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class TypedCollection implements ICollection, ITypeable
	{
		private var _wrappedCollection: ICollection;
		private var _type: *;

		/**
		 * @inheritDoc
		 */
		public function get allEquatable(): Boolean { return _wrappedCollection.allEquatable; }

		/**
		 * Defines the acceptable type of the elements by this collection.
		 * <p>The setter is not supported and will thrown an <code>UnsupportedOperationError</code> if used.</p>
		 */
		public function get type(): * { return _type; }

		public function set type(value:*): void { throw new UnsupportedOperationError("Cannot change the collection type."); }

		/**
		 * @private
		 */
		protected function get wrappedCollection(): ICollection { return _wrappedCollection; }

		/**
		 * Constructor, creates a new <code>TypedCollection</code> object.
		 * 
		 * @param 	wrapCollection 	the target collection to wrap.
		 * @param 	type 			the type of the elements allowed by this collection.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>wrapCollection</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>type</code> argument is <code>null</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>wrapCollection</code> argument are incompatible with the <code>type</code> argument.
		 */
		public function TypedCollection(wrapCollection:ICollection, type:*)
		{
			if (!wrapCollection) throw new NullPointerError("The 'wrapCollection' argument must not be 'null'.");
			if (type == null) throw new NullPointerError("The 'type' argument must not be 'null'.");
			
			_type = type;
			validateCollection(wrapCollection);
			_wrappedCollection = wrapCollection;
		}

		/**
		 * The element is validated with the <code>validateType</code> method to be forwarded to <code>wrappedCollection.add</code>.
		 * 
		 * @param  	element 	the element to forward to <code>wrappedCollection.add</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the type of the element is incompatible with the type of this collection.
		 * @return 	the return of the call <code>wrappedCollection.add</code>.
		 */
		public function add(element:*): Boolean
		{
			validateElement(element);
			return _wrappedCollection.add(element);
		}

		/**
		 * The collection is validated with the <code>validateCollection</code> method to be forwarded to <code>wrappedCollection.addAll</code>.
		 * 
		 * @param  	collection 	the collection to forward to <code>wrappedCollection.addAll</code>.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  		if the types of one or more elements in the <code>collection</code> argument are incompatible with the type of this collection.
		 * @return 	the return of the call <code>wrappedCollection.addAll</code>.
		 */
		public function addAll(collection:ICollection): Boolean
		{
			validateCollection(collection);
			return _wrappedCollection.addAll(collection);
		}

		/**
		 * Forwards the call to <code>wrappedCollection.clear</code>.
		 */
		public function clear(): void
		{
			_wrappedCollection.clear();
		}

		/**
		 * Creates and return a new <code>TypedCollection</code> object with the clone of the <code>wrappedCollection</code> object.
		 * 
		 * @return 	a new <code>TypedCollection</code> object with the clone of the <code>wrappedCollection</code> object.
 		 */
		public function clone(): *
		{
			return new TypedCollection(_wrappedCollection.clone(), _type);
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
		 * This method first checks if <code>other</code> argument is a <code>TypedCollection</code>.
		 * If not it returns <code>false</code>. If <code>true</code> it checks the <code>type</code> property of both lists.
		 * If they are different it returns <code>false</code>.
		 * Otherwise it uses <code>CollectionUtil.equalNotConsideringOrder</code> method to perform equality, sending this list and <code>other</code> argument.
		 * 
		 * @param  	other 	the object to be compared for equality.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 * @see 	org.as3collections.utils.CollectionUtil#equalNotConsideringOrder() CollectionUtil.equalNotConsideringOrder()
		 */
		public function equals(other:*): Boolean
		{
			if (this == other) return true;
			if (!ReflectionUtil.classPathEquals(this, other)) return false;
			
			var otherList:TypedCollection = other as TypedCollection;
			if (type != otherList.type) return false;
			
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
		 * 
		 * @return the string representation of this instance.
 		 */
		public function toString():String 
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
		protected function isValidElement(element:*): Boolean
		{
			return element is _type;
		}
		
		/**
		 * @private
		 */
		protected function validateCollection(collection:ICollection): void
		{
			if (!collection || collection.isEmpty()) return;
			
			var containsOnlyType:Boolean = CollectionUtil.containsOnlyType(collection, type, false);
			if (containsOnlyType) return;
			
			var it:IIterator = collection.iterator();
			var element:*;
			
			while (it.hasNext())
			{
				element = it.next();
				if (!isValidElement(element)) break;
			}
			
			var error:ClassCastError = getInvalidElementError(element);
			throw error;
		}
		
		/**
		 * @private
		 */
		protected function validateElement(element:*): void
		{
			if (isValidElement(element)) return;
			
			var error:ClassCastError = getInvalidElementError(element);
			throw error;
		}
		
		/**
		 * @private
		 */
		private function getInvalidElementError(element:*): ClassCastError
		{
			var message:String = "Invalid element type. element: <" + element + ">\n";
			message += "element type: <" + ReflectionUtil.getClassPath(element) + ">\n";
			message += "expected type: <" + ReflectionUtil.getClassPath(_type) + ">";
			
			return new ClassCastError(message);
		}

	}

}