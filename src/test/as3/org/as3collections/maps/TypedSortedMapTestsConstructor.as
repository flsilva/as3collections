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

package org.as3collections.maps
{
	import org.as3collections.IMap;
	import org.as3collections.ISortedMap;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedSortedMapTestsConstructor
	{
		
		public function TypedSortedMapTestsConstructor()
		{
			
		}
		
		////////////////////////////////////////
		// TypedSortedMap() constructor TESTS //
		////////////////////////////////////////
		
		[Test]
		public function constructor_argumentValidKeyValues_checkIfIsEmpty_ReturnsFalse(): void
		{
			var addMap:ISortedMap = new SortedArrayMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			var newMap:IMap = new TypedSortedMap(addMap, String, int);
			
			var isEmpty:Boolean = newMap.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithValidAndInvalidKeys_ThrowsError(): void
		{
			var addMap:ISortedMap = new SortedArrayMap();
			addMap.put("element-1", 1);
			addMap.put(1, 2);
			
			new TypedSortedMap(addMap, String, int);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithValidAndInvalidValues_ThrowsError(): void
		{
			var addMap:ISortedMap = new SortedArrayMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", "2");
			
			new TypedSortedMap(addMap, String, int);
		}
		
	}

}