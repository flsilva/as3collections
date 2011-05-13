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
	import org.as3collections.IMap;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;

	/**
	 * An iterator to iterate over maps (implementations of the <code>IMap</code> interface).
	 * This implementation doesn't allow modifications in the map.
	 * All methods that change the map will throw an <code>UnsupportedOperationError</code>.
	 * 
	 * @author Flávio Silva
	 */
	public class ReadOnlyMapIterator extends MapIterator
	{
		/**
		 * Constructor, creates a new <code>ReadOnlyMapIterator</code> object.
		 * 
		 * @param  	source 	the source map to iterate over.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  if the <code>source</code> argument is <code>null</code>.
		 */
		public function ReadOnlyMapIterator(source:IMap)
		{
			super(source);
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyMapIterator</code> is a read-only iterator and doesn't allow modifications in the map.
		 */
		override public function remove(): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only iterator and doesn't allow modifications in the collection.");
		}

	}

}