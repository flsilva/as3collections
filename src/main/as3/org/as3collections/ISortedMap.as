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
	import org.as3coreaddendum.system.ISortable;

	/**
	 * A map that provides a <em>total ordering</em> on its mappings, sorting by keys or values.
	 * The map is ordered according to the <em>natural ordering</em> of its keys or values, by a <em>IComparator</em> typically provided at sorted map creation time, or by the arguments provided to the <code>sort</code> or <code>sortOn</code> methods.
	 * The <code>sortBy</code> property defines whether the sorting will be made by <code>key</code> or <code>value</code>.
	 * 
	 * @author Flávio Silva
	 */
	public interface ISortedMap extends ISortable, IListMap
	{

		/**
		 * Defines whether the map should be sorted by its keys or values. The default is <code>SortMapBy.KEY</code>.
 		 */
		function get sortBy(): SortMapBy;
		
		function set sortBy(value:SortMapBy): void;

		/**
		 * Sorts the elements in an array according to one or more fields in the array.
		 * <p>Consult <code>Array.sortOn</code> in the ActionScript 3.0 Language Reference in the link below for more info.</p>
		 * 
		 * @param fieldName
		 * @param options
		 * @return
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Array.html#sortOn()
		 */
		function sortOn(fieldName:*, options:* = null): Array;
		
	}

}