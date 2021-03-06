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

	/**
	 * An iterator to iterate over maps (implementations of the <code>IMap</code> interface).
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IIterator;
	 * import org.as3collections.IMap;
	 * import org.as3collections.maps.ArrayListMap;
	 * 
	 * var map1:IMap = new ArrayListMap();
	 * map1.put("element-1", 1);
	 * map1.put("element-3", 3);
	 * map1.put("element-5", 5);
	 * map1.put("element-7", 7);
	 * 
	 * map1                             // ["element-1"=1,"element-3"=3,"element-5"=5,"element-7"=7]
	 * 
	 * var it:IIterator = map1.iterator();
	 * var e:int;
	 * 
	 * while (it.hasNext())
	 * {
	 *     ITERATION N.1
	 * 
	 *     it.pointer()                  // null
	 * 
	 *     e = it.next();
	 *     e                             // 1
	 * 
	 *     it.pointer()                  // "element-1"
	 * 
	 *     ITERATION N.2
	 * 
	 *     it.pointer()                  // "element-1"
	 * 
	 *     e = it.next();
	 *     e                             // 3
	 * 
	 *     it.pointer()                  // "element-3"
	 * 
	 *     if (e == 3)
	 *     {
	 *         it.remove();
	 *         map1                      // ["element-1"=1,"element-5"=5,"element-7"=7]
	 *     }
	 * 
	 *     ITERATION N.3
	 * 
	 *     it.pointer()                  // "element-1"
	 * 
	 *     e = it.next();
	 *     e                             // 5
	 * 
	 *     it.pointer()                  // "element-5"
	 * 
	 *     ITERATION N.4
	 * 
	 *     it.pointer()                  // "element-5"
	 * 
	 *     e = it.next();
	 *     e                             // 7
	 * 
	 *     it.pointer()                  // "element-7"
	 * }
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class MapIterator implements IIterator
	{
		private var _key :*;
		private var _keysIterator :IIterator;
		private var _source :IMap;
		private var _values :Array;

		/**
		 * Constructor, creates a new <code>MapIterator</code> object.
		 * 
		 * @param  	source 	the source map to iterate over.
		 * @throws 	ArgumentError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function MapIterator(source:IMap)
		{
			if (!source) throw new ArgumentError("The 'source' argument must not be 'null'.");
			
			_source = source;
			_keysIterator = _source.getKeys().iterator();
			_values = _source.getValues().toArray();
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
		 * @throws 	org.as3collections.errors.NoSuchElementError 	if the iteration has no more elements.
 		 */
		public function next(): *
		{
			_key = _keysIterator.next();
			return _values[_keysIterator.pointer()];
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
		 * @throws 	org.as3coreaddendum.errors.IllegalStateError  	if the <code>next</code> method has not yet been called, or the <code>remove</code> method has already been called after the last call to the <code>next</code> method.
		 */
		public function remove(): void
		{
			_source.remove(_key);
			_values.splice(_keysIterator.pointer(), 1);
			_keysIterator.remove();
		}

		/**
		 * @inheritDoc
		 */
		public function reset(): void
		{
			_keysIterator.reset();
			_key = null;
		}

	}

}