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
	import org.as3collections.IIterator;
	import org.as3collections.IMap;
	import org.as3coreaddendum.errors.NullPointerError;

	/**
	 * An iterator to iterate over maps (implementations of the <code>IMap</code> interface).
	 * 
	 * @author Flávio Silva
	 */
	public class MapIterator implements IIterator
	{
		private var _key :*;
		private var _keysIterator :IIterator;
		private var _source :IMap;

		/**
		 * Constructor, creates a new <code>MapIterator</code> object.
		 * 
		 * @param  	source 	the source map to iterate over.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function MapIterator(source:IMap)
		{
			if (!source) throw new NullPointerError("The 'source' argument must not be 'null'.");
			
			_source = source;
			_keysIterator = _source.getKeys().iterator();
		}

		/**
		 * @inheritDoc
 		 */
		public function hasNext(): Boolean
		{
			return _keysIterator.hasNext();
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3coreaddendum.errors.NoSuchElementError 	if the iteration has no more elements.
 		 */
		public function next(): *
		{
			_key = _keysIterator.next();
			return _source.getValue(_key);
		}

		/**
		 * @inheritDoc
 		 */
		public function pointer(): *
		{
			return _key;
		}

		/**
		 * @inheritDoc
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  	if the <code>next</code> method has not yet been called, or the <code>remove</code> method has alread been called after the last call to the <code>next</code> method.
		 */
		public function remove(): void
		{
			_source.remove(_key);
			_keysIterator.remove();
		}

		/**
		 * @inheritDoc
		 */
		public function reset(): void
		{
			_keysIterator.reset();
		}

	}

}