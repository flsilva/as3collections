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
	/**
	 * An iterator over a collection.
	 * 
	 * @author Flávio Silva
	 */
	public interface IIterator
	{
		/**
		 * Returns <code>true</code> if the iteration has more elements.
		 * 
		 * @return 	<code>true</code> if the iteration has more elements.
 		 */
		function hasNext(): Boolean;

		/**
		 * Returns the next element in the iteration.
		 * 
		 * @throws 	org.as3coreaddendum.errors.NoSuchElementError 	if the iteration has no more elements.
		 * @return 	the next element in the iteration.
 		 */
		function next(): *;

		/**
		 * Returns the internal pointer of the iteration.
		 * <p>In a list or queue, the pointer should be the index (position) of the iteration, typically an <code>int</code>.</p>
		 * <p>In a map, the pointer should be the key of the iteration.</p>
		 * 
		 * @return 	the internal pointer of the iteration.
 		 */
		function pointer(): *;

		/**
		 * Removes from the underlying collection the last element returned by the iterator (optional operation).
		 * <p>This method can be called only once per call to <code>next</code>.</p>
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>remove</code> operation is not supported by this iterator.
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  			if the <code>next</code> method has not yet been called, or the <code>remove</code> method has alread been called after the last call to the <code>next</code> method.
		 */
		function remove(): void;

		/**
		 * Resets the internal pointer of the iterator.
		 */
		function reset(): void;
	}

}