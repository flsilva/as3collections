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

package org.as3collections.iterators 
{
	import org.as3collections.IListMap;
	import org.as3collections.IListMapIterator;
	import org.as3collections.errors.ConcurrentModificationError;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.errors.NoSuchElementError;
	import org.as3coreaddendum.errors.IllegalStateError;

	/**
	 * description and examples
	 * 
	 * @author Flávio Silva
	 */
	public class ListMapIterator implements IListMapIterator
	{
		private var _allowModification: Boolean;
		private var _modCount: int;
		private var _pointer: int = -1;
		private var _removePointer: int;
		private var _source: IListMap;

		/**
		 * Constructor, creates a new <code>ListMapIterator</code> object.
		 * 
		 * @param  	source 		the source <code>ListMapIterator</code> to iterate over.
		 * @param  	position 	indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified position minus one. 
		 * @throws 	ArgumentError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function ListMapIterator(source:IListMap, position:int = 0)
		{
			if (!source) throw new ArgumentError("The 'source' argument must not be 'null'.");
			if (position < 0 || position > source.size()) throw new IndexOutOfBoundsError("The 'position' argument is out of bounds: " + position + " (min: 0, max: " + source.size() + ")"); 
			
			_source = source;
			_modCount = _source.modCount;
			_pointer += position;
		}

		/**
		 * @inheritDoc
		 */
		public function hasNext(): Boolean
		{
			return _pointer < _source.size() - 1;
		}

		/**
		 * @inheritDoc
		 */
		public function hasPrevious(): Boolean
		{
			return _pointer >= 0;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no more elements.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function next(): *
		{
			if (!hasNext()) throw new NoSuchElementError("Iterator doesn't has next element. Call hasNext() method before.");
			
			checkConcurrentModificationError();
			_allowModification = true;
			_pointer++;
			_removePointer = _pointer;
			return _source.getValueAt(_pointer);
		}

		/**
		 * @inheritDoc
		 */
		public function nextIndex(): int
		{
			return _pointer + 1;
		}

		/**
		 * @inheritDoc
		 */
		public function pointer(): *
		{
			return _source.getKeyAt(_pointer);
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no previous elements.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function previous(): *
		{
			if (!hasPrevious()) throw new NoSuchElementError("Iterator doesn't has previous element. Call hasPrevious() method before.");
			
			checkConcurrentModificationError();
			_allowModification = true;
			_removePointer = _pointer;
			return _source.getValueAt(_pointer--);
		}

		/**
		 * @inheritDoc
		 */
		public function previousIndex(): int
		{
			return _pointer;
		}
		
		/**
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function put(key:*, value:*): void
		{
			checkConcurrentModificationError();
			
			_source.putAt(_pointer + 1, key, value);
			
			if (_modCount != _source.modCount) _pointer++;
			_modCount = _source.modCount;
			_allowModification = false;
		}

		/**
		 * Removes from the list the last element that was returned by <code>next</code> or <code>previous</code>. This call can only be made once per call to <code>next</code> or <code>previous</code>. It can be made only if <code>IListMapIterator.add</code> has not been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if the <code>next</code> method has not yet been called, or the <code>remove</code> method has already been called after the last call to the <code>next</code> method.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function remove(): void
		{
			checkConcurrentModificationError();
			
			if (!_allowModification) throw new IllegalStateError("The next or previous method has not yet been called or the add or remove method has already been called after the last call to the next or previous method.");
			
			_source.removeAt(_removePointer);
			_modCount = _source.modCount;
			_allowModification = false;
			if (_removePointer == _pointer) _pointer--;
		}

		/**
		 * @inheritDoc
		 */
		public function reset(): void
		{
			_pointer = -1;
		}

		/**
		 * Replaces the last mapping returned by <code>next</code> or <code>previous</code> with the specified mapping (optional operation).
		 * This call can be made only if neither <code>IListMapIterator.remove</code> nor <code>IListMapIterator.add</code> have been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @param element 	the element with which to replace the last element returned by <code>next</code> or <code>previous</code>. 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>set</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if neither <code>next</code> or <code>previous</code> have been called, or <code>remove</code> or <code>add</code> have been called after the last call to <code>next</code> or <code>previous</code>.
		 * @throws 	ArgumentError  											if the map already contains the specified key and it is not the replaced key.
		 */
		public function set(key:*, value:*): void
		{
			checkConcurrentModificationError();
			
			if (!_allowModification) throw new IllegalStateError("The next or previous method has not yet been called or the add or remove method has already been called after the last call to the next or previous method.");
			
			var setIndex:int = (_removePointer > _pointer) ? _pointer + 1 : _pointer;
			
			_source.setKeyAt(setIndex, key);
			_source.setValueAt(setIndex, value);
			_modCount = _source.modCount;
		}

		/**
		 * @private
		 */
		public function checkConcurrentModificationError(): void
		{
			if (_modCount != _source.modCount) throw new ConcurrentModificationError("During the iteration, the list was changed directly (without use the iterator).");
		}

	}

}