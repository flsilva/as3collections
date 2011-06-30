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
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.errors.ConcurrentModificationError;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.errors.NoSuchElementError;
	import org.as3coreaddendum.errors.IllegalStateError;

	/**
	 * An iterator to iterate over lists (implementations of the <code>IList</code> interface).
	 * <code>ListIterator</code> allows to traverse the list in either direction.
	 * <p><b>IMPORTANT:</b></p>
	 * <p>A <code>ListIterator</code> has no current element; its cursor position always lies between the element that would be returned by a call to <code>previous()</code> and the element that would be returned by a call to <code>next()</code>.
	 * An iterator for a list of length <code>n</code> has <code>n+1</code> possible cursor positions, as illustrated by the carets (^) below:</p>
	 * <p>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * Element(0)&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * Element(1)&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * Element(2)&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * ... Element(n-1)</p>
	 * <p>cursor positions:
	 * &#160;&#160;&#160;
	 * ^&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * ^&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * ^&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * ^&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
	 * ^</p>
	 * <p>Note that the <code>remove()</code> and <code>set()</code> methods are <em>not</em> defined in terms of the cursor position; they are defined to operate on the last element returned by a call to <code>next()</code> or <code>previous()</code>.</p>
	 * <p>For further information do not hesitate to see the examples at the end of the page.</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @example
	 * 
	 * <b>Example 1</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.IListIterator;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var list1:IList = new ArrayList([1, 3, 5]);
	 * 
	 * list1                             // [1,3,5]
	 * 
	 * var it:IListIterator = list1.listIterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 * 
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                  // -1
	 *     it.nextIndex()                // 0
	 *     it.previousIndex()            // -1
	 * 
	 *     e = it.next();
	 *     e                             // 1
	 * 
	 *     it.pointer()                  // 0
	 *     it.nextIndex()                // 1
	 *     it.previousIndex()            // 0
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                  // 0
	 *     it.nextIndex()                // 1
	 *     it.previousIndex()            // 0
	 * 
	 *     e = it.next();
	 *     e                             // 3
	 * 
	 *     it.pointer()                  // 1
	 *     it.nextIndex()                // 2
	 *     it.previousIndex()            // 1
	 * 
	 *     if (e == 3)
	 *     {
	 *         //list1.add(4)            // ConcurrentModificationError: During the iteration, the list was changed directly (without use the iterator).
	 *         it.add(4);
	 *         list1                     // [1,3,4,5]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                  // 2
	 *     it.nextIndex()                // 3
	 *     it.previousIndex()            // 2
	 * 
	 *     e = it.next();
	 *     e                             // 5
	 * 
	 *     it.pointer()                  // 3
	 *     it.nextIndex()                // 4
	 *     it.previousIndex()            // 3
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.remove();
	 *         list1                     // [1,3,4]
	 *     }
	 * }
	 * </listing>
	 * 
	 * <b>Example 2</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IList;
	 * import org.as3collections.IListIterator;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var list1:IList = new ArrayList([1, 3, 5]);
	 * 
	 * list1                             // [1,3,5]
	 * 
	 * var it:IListIterator = list1.listIterator(list1.size());
	 * var e:int;
	 * 
	 * while (it.hasPrevious())
	 * 
	 * {
	 * 
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                  // 2
	 *     it.nextIndex()                // 3
	 *     it.previousIndex()            // 2
	 * 
	 *     e = it.previous();
	 *     e                             // 5
	 * 
	 *     it.pointer()                  // 1
	 *     it.nextIndex()                // 2
	 *     it.previousIndex()            // 1
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.remove()
	 *         list1                     // [1,3]
	 *     }
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                  // 1
	 *     it.nextIndex()                // 2
	 *     it.previousIndex()            // 1
	 * 
	 *     e = it.previous();
	 *     e                             // 3
	 * 
	 *     it.pointer()                  // 0
	 *     it.nextIndex()                // 1
	 *     it.previousIndex()            // 0
	 * 
	 *     if (e == 3)
	 *     {
	 *         //list1.add(4)            // ConcurrentModificationError: During the iteration, the list was changed directly (without use the iterator).
	 *         it.add(4);
	 *         list1                     // [1,4,3]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                  // 1
	 *     it.nextIndex()                // 2
	 *     it.previousIndex()            // 1
	 * 
	 *     e = it.previous();
	 *     e                             // 4
	 * 
	 *     it.pointer()                  // 0
	 *     it.nextIndex()                // 1
	 *     it.previousIndex()            // 0
	 * 
	 *     ITERATION N.4
	 * 
	 *     it.pointer()                  // 0
	 *     it.nextIndex()                // 1
	 *     it.previousIndex()            // 0
	 * 
	 *     e = it.previous();
	 *     e                             // 1
	 * 
	 *     it.pointer()                  // -1
	 *     it.nextIndex()                // 0
	 *     it.previousIndex()            // -1
	 * }
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class ListIterator implements IListIterator
	{
		private var _allowModification: Boolean;
		private var _modCount: int;
		private var _pointer: int = -1;
		private var _removePointer: int;
		private var _source: IList;

		/**
		 * Constructor, creates a new <code>ListIterator</code> object.
		 * 
		 * @param  	source 		the source <code>ListIterator</code> to iterate over.
		 * @param  	position 	indicates the first element that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the element with the specified position minus one. 
		 * @throws 	ArgumentError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function ListIterator(source:IList, position:int = 0)
		{
			if (!source) throw new ArgumentError("The 'source' argument must not be 'null'.");
			if (position < 0 || position > source.size()) throw new IndexOutOfBoundsError("The 'position' argument is out of bounds: " + position + " (min: 0, max: " + source.size() + ")"); 
			
			_source = source;
			_modCount = _source.modCount;
			_pointer += position;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function add(element:*): Boolean
		{
			checkConcurrentModificationError();
			
			var added:Boolean = _source.addAt(_pointer + 1, element);
			
			if (_modCount != _source.modCount) _pointer++;
			_modCount = _source.modCount;
			_allowModification = false;
			
			return added;
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
			if (!hasNext()) throw new NoSuchElementError("Iterator has no next element. Call hasNext() method before.");
			
			checkConcurrentModificationError();
			_allowModification = true;
			_pointer++;
			_removePointer = _pointer;
			return _source.getAt(_pointer);
		}

		/**
		 * @inheritDoc
		 */
		public function nextIndex(): int
		{
			return _pointer + 1;
		}

		/**
		 * Returns the internal pointer of the iteration.
		 * <p>In this implementation the pointer is the index (position) of the iteration, typically an <code>int</code>.</p>
		 * 
		 * @return 	the internal pointer of the iteration.
 		 */
		public function pointer(): *
		{
			return _pointer;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no previous elements.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the list was changed directly (without using the iterator) during iteration.
		 */
		public function previous(): *
		{
			if (!hasPrevious()) throw new NoSuchElementError("Iterator has no previous element. Call hasPrevious() method before.");
			
			checkConcurrentModificationError();
			_allowModification = true;
			_removePointer = _pointer;
			return _source.getAt(_pointer--);
		}

		/**
		 * @inheritDoc
		 */
		public function previousIndex(): int
		{
			return _pointer;
		}

		/**
		 * Removes from the list the last element that was returned by <code>next</code> or <code>previous</code>. This call can only be made once per call to <code>next</code> or <code>previous</code>. It can be made only if <code>IListIterator.add</code> has not been called after the last call to <code>next</code> or <code>previous</code>. 
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
		 * Replaces the last element returned by <code>next</code> or <code>previous</code> with the specified element (optional operation). This call can be made only if neither <code>IListIterator.remove</code> nor <code>IListIterator.add</code> have been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @param element 	the element with which to replace the last element returned by <code>next</code> or <code>previous</code>.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>set</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified element prevents it from being added to this list.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if neither <code>next</code> or <code>previous</code> have been called, or <code>remove</code> or <code>add</code> have been called after the last call to <code>next</code> or <code>previous</code>.
		 */
		public function set(element:*): void
		{
			checkConcurrentModificationError();
			
			if (!_allowModification) throw new IllegalStateError("The next or previous method has not yet been called or the add or remove method has already been called after the last call to the next or previous method.");
			
			var setIndex:int = (_removePointer > _pointer) ? _pointer + 1 : _pointer;
			
			_source.setAt(setIndex, element);
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