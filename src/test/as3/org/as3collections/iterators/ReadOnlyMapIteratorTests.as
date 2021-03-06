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
	import org.as3collections.maps.ArrayListMap;

	/**
	 * @author Flávio Silva
	 */
	public class ReadOnlyMapIteratorTests
	{
		public var iterator:IIterator;
		
		public function ReadOnlyMapIteratorTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			iterator = getIterator();
		}
		
		[After]
		public function tearDown(): void
		{
			iterator = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getIterator():IIterator
		{
			var map:IMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			return new ReadOnlyMapIterator(map);
		}
		
		/////////////////////////////////////////////
		// ReadOnlyMapIterator() constructor TESTS //
		/////////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ReadOnlyMapIterator(null);
		}
		
		//////////////////////////////////////////
		// ReadOnlyMapIterator().remove() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_notEmptyIterator_callRemoveBeforeCallNext_ThrowsError(): void
		{
			iterator.remove();
		}
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_notEmptyIterator_callRemoveAfterNext_checkIfPointerIsCorrect_ThrowsError(): void
		{
			iterator.next();
			iterator.remove();
		}
		
	}

}