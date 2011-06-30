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
	 * An iterator to iterate over implementations of <code>IListMap</code> interface.
	 * <code>ListMapIterator</code> allows to traverse the map in either direction.
	 * <p><b>IMPORTANT:</b></p>
	 * <p>A <code>ListMapIterator</code> has no current mapping; its cursor position always lies between the mapping that would be returned by a call to <code>previous()</code> and the mapping that would be returned by a call to <code>next()</code>.
	 * An iterator for a map of length <code>n</code> has <code>n+1</code> possible cursor positions, as illustrated by the carets (^) below:</p>
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
	 * <p>Note that the <code>remove()</code> and <code>set()</code> methods are <em>not</em> defined in terms of the cursor position; they are defined to operate on the last mapping returned by a call to <code>next()</code> or <code>previous()</code>.</p>
	 * <p>For further information do not hesitate to see the examples at the end of the page.</p>
	 * <p>This documentation is partially based in the <em>Java Collections Framework</em> JavaDoc documentation.
	 * For further information see <a href="http://download.oracle.com/javase/6/docs/technotes/guides/collections/index.html" target="_blank">Java Collections Framework</a></p>
	 * 
	 * @example
	 * 
	 * <b>Example 1</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IListMap;
	 * import org.as3collections.IListMapIterator;
	 * import org.as3collections.maps.ArrayListMap;
	 * 
	 * var map1:IListMap = new ArrayListMap();
	 * map1.put("element-1", 1);
	 * map1.put("element-3", 3);
	 * map1.put("element-5", 5);
	 * 
	 * map1                                // ["element-1"=1,"element-3"=3,"element-5"=5]
	 * 
	 * var it:IListMapIterator = map1.listMapIterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 * 
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                    // null
	 *     it.nextIndex()                  // 0
	 *     it.previousIndex()              // -1
	 * 
	 *     e = it.next();
	 *     e                               // 1
	 * 
	 *     it.pointer()                    // "element-1"
	 *     it.nextIndex()                  // 1
	 *     it.previousIndex()              // 0
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                    // "element-1"
	 *     it.nextIndex()                  // 1
	 *     it.previousIndex()              // 0
	 * 
	 *     e = it.next();
	 *     e                               // 3
	 * 
	 *     it.pointer()                    // "element-3"
	 *     it.nextIndex()                  // 2
	 *     it.previousIndex()              // 1
	 * 
	 *     if (e == 3)
	 *     {
	 *         //map1.put("element-4", 4)  // ConcurrentModificationError: During the iteration, the map was changed directly (without use the iterator).
	 *         it.put("element-4", 4);
	 *         map1                        // ["element-1"=1,"element-3"=3,"element-4"=4,"element-5"=5]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                    // "element-4"
	 *     it.nextIndex()                  // 3
	 *     it.previousIndex()              // 2
	 * 
	 *     e = it.next();
	 *     e                               // 5
	 * 
	 *     it.pointer()                    // "element-5"
	 *     it.nextIndex()                  // 4
	 *     it.previousIndex()              // 3
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.remove();
	 *         map1                        // ["element-1"=1,"element-3"=3,"element-4"=4]
	 *     }
	 * }
	 * </listing>
	 * 
	 * <b>Example 2</b>
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IListMap;
	 * import org.as3collections.IListMapIterator;
	 * import org.as3collections.maps.ArrayListMap;
	 * 
	 * var map1:IListMap = new ArrayListMap();
	 * map1.put("element-1", 1);
	 * map1.put("element-3", 3);
	 * map1.put("element-5", 5);
	 * 
	 * map1                                // ["element-1"=1,"element-3"=3,"element-5"=5]
	 * 
	 * var it:IListMapIterator = map1.listIterator(map1.size());
	 * var e:int;
	 * 
	 * while (it.hasPrevious())
	 * 
	 * {
	 * 
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                    // "element-5"
	 *     it.nextIndex()                  // 3
	 *     it.previousIndex()              // 2
	 * 
	 *     e = it.previous();
	 *     e                               // 5
	 * 
	 *     it.pointer()                    // "element-3"
	 *     it.nextIndex()                  // 2
	 *     it.previousIndex()              // 1
	 * 
	 *     if (e == 5)
	 *     {
	 *         it.remove()
	 *         map1                        // ["element-1"=1,"element-3"=3]
	 *     }
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                    // "element-3"
	 *     it.nextIndex()                  // 2
	 *     it.previousIndex()              // 1
	 * 
	 *     e = it.previous();
	 *     e                               // 3
	 * 
	 *     it.pointer()                    // "element-1"
	 *     it.nextIndex()                  // 1
	 *     it.previousIndex()              // 0
	 * 
	 *     if (e == 3)
	 *     {
	 *         //map1.put("element-4", 4); // ConcurrentModificationError: During the iteration, the map was changed directly (without use the iterator).
	 *         it.put("element-4", 4);
	 *         map1                        // [1,4,3]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                    // "element-3"
	 *     it.nextIndex()                  // 2
	 *     it.previousIndex()              // 1
	 * 
	 *     e = it.previous();
	 *     e                               // 4
	 * 
	 *     it.pointer()                    // "element-1"
	 *     it.nextIndex()                  // 1
	 *     it.previousIndex()              // 0
	 * 
	 *     ITERATION N.4
	 * 
	 *     it.pointer()                    // "element-1"
	 *     it.nextIndex()                  // 1
	 *     it.previousIndex()              // 0
	 * 
	 *     e = it.previous();
	 *     e                               // 1
	 * 
	 *     it.pointer()                    // null
	 *     it.nextIndex()                  // 0
	 *     it.previousIndex()              // -1
	 * }
	 * </listing>
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
		 * @param  	position 	indicates the first mapping that would be returned by an initial call to <code>next</code>. An initial call to <code>previous</code> would return the mapping with the specified position minus one. 
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
		 * Returns the next <code>value</code> in the iteration.
		 * The <code>pointer</code> operation returns the <code>key</code> associated with the returned <code>value</code>.
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no more mappings.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
		 */
		public function next(): *
		{
			if (!hasNext()) throw new NoSuchElementError("Iterator has no next mapping. Call hasNext() method before.");
			
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
		 * Returns the internal pointer of the iteration.
		 * <p>In this implementation the pointer is a <code>key</code>.</p>
		 * 
		 * @return 	the internal pointer of the iteration.
 		 */
		public function pointer(): *
		{
			if (_pointer < 0) return null;
			return _source.getKeyAt(_pointer);
		}

		/**
		 * Returns the previous <code>value</code> in the iteration.
		 * The <code>pointer</code> operation returns the <code>key</code> associated with the returned <code>value</code>.
		 * 
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no previous mappings.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
		 */
		public function previous(): *
		{
			if (!hasPrevious()) throw new NoSuchElementError("Iterator has no previous mapping. Call hasPrevious() method before.");
			
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
		 * Associates the specified value with the specified key in this map.
		 * The mapping is inserted immediately before the next mapping that would be returned by <code>next</code>, if any, and after the next mapping that would be returned by <code>previous</code>, if any.
		 * (If the map contains no mappings, the new mapping becomes the sole mapping on the map.)
		 * The new mapping is inserted before the implicit cursor: a subsequent call to <code>next</code> would be unaffected, and a subsequent call to <code>previous</code> would return the new mapping.
		 * (This call increases by one the value that would be returned by a call to <code>nextIndex</code> or <code>previousIndex</code>.) 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
		 * @throws 	ArgumentError  											if the map already contains the specified key.
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
		 * Removes from the map the last mapping that was returned by <code>next</code> or <code>previous</code>.
		 * This call can only be made once per call to <code>next</code> or <code>previous</code>.
		 * It can be made only if <code>IListMapIterator.add</code> has not been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if the <code>next</code> method has not yet been called, or the <code>remove</code> method has already been called after the last call to the <code>next</code> method.
		 * @throws 	org.as3collections.errors.ConcurrentModificationError 	if the map was changed directly (without using the iterator) during iteration.
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
		 * Replaces the last mapping returned by <code>next</code> or <code>previous</code> with the specified mapping.
		 * This call can be made only if neither <code>IListMapIterator.remove</code> nor <code>IListMapIterator.add</code> have been called after the last call to <code>next</code> or <code>previous</code>. 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key. 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>set</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified key or value prevents it from being added to this map.
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
			if (_modCount != _source.modCount) throw new ConcurrentModificationError("During the iteration, the map was changed directly (without use the iterator).");
		}

	}

}