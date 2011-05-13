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

package org.as3collections.iterators {
	import org.as3collections.IIterator;
	import org.as3collections.errors.NoSuchElementError;
	import org.as3coreaddendum.errors.IllegalStateError;
	import org.as3coreaddendum.errors.NullPointerError;

	/**
	 * An iterator to iterate over an <code>Array</code> object.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IIterator;
	 * import org.as3collections.IList;
	 * import org.as3collections.lists.ArrayList;
	 * 
	 * var list1:IList = new ArrayList([1, 3, 5, 7]);
	 * 
	 * list1                             // [1,3,5,7]
	 * 
	 * var it:IIterator = list1.iterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                  // -1
	 * 
	 *     e = it.next();
	 *     e                             // 1
	 * 
	 *     it.pointer()                  // 0
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                  // 0
	 * 
	 *     e = it.next();
	 *     e                             // 3
	 * 
	 *     it.pointer()                  // 1
	 * 
	 *     if (e == 3)
	 *     {
	 *         it.remove();
	 *         list1                     // [1,5,7]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                  // 0
	 * 
	 *     e = it.next();
	 *     e                             // 5
	 * 
	 *     it.pointer()                  // 1
	 * 
	 *     ITERATION N.4
	 * 
	 *     it.pointer()                  // 1
	 * 
	 *     e = it.next();
	 *     e                             // 7
	 * 
	 *     it.pointer()                  // 2
	 * }
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class ArrayIterator implements IIterator
	{
		private var _allowRemove: Boolean;
		private var _pointer: int = -1;
		private var _source: Array;

		/**
		 * Constructor, creates a new ArrayIterator object.
		 * 
		 * @param  	source 	the source array to iterate over.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function ArrayIterator(source:Array)
		{
			if (!source) throw new NullPointerError("The 'source' argument must not be 'null'.");
			_source = source;
		}

		/**
		 * @inheritDoc
 		 */
		public function hasNext(): Boolean
		{
			return _pointer < _source.length - 1;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3coreaddendum.errors.NoSuchElementError 	if the iteration has no more elements.
 		 */
		public function next(): *
		{
			if (!hasNext()) throw new NoSuchElementError("Iterator doesn't has next element. Call hasNext() method before.");
			_allowRemove = true;
			return _source[++_pointer];
		}

		/**
		 * @inheritDoc
 		 */
		public function pointer(): *
		{
			return _pointer;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  	if the <code>next</code> method has not yet been called, or the <code>remove</code> method has alread been called after the last call to the <code>next</code> method.
		 */
		public function remove(): void
		{
			if (!_allowRemove) throw new IllegalStateError("The next method has not yet been called or the remove method has alread been called after the last call to the next method.");
			_allowRemove = false;
			_source.splice(_pointer--, 1);
		}

		/**
		 * @inheritDoc
		 */
		public function reset(): void
		{
			_pointer = -1;
		}

	}

}