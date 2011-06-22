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
	import org.as3collections.IListIterator;
	import org.as3collections.lists.ArrayList;

	/**
	 * @author Flávio Silva
	 */
	public class ReadOnlyListIteratorTests
	{
		public var listIterator:IListIterator;
		
		public function ReadOnlyListIteratorTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			listIterator = getIterator();
		}
		
		[After]
		public function tearDown(): void
		{
			listIterator = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getIterator():IListIterator
		{
			return new ReadOnlyListIterator(new ArrayList(["element-1", "element-2", "element-3", "element-4"]));
		}
		
		//////////////////////////////////////////////
		// ReadOnlyListIterator() constructor TESTS //
		//////////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ReadOnlyListIterator(null);
		}
		
		/////////////////////////////////
		// ArrayIterator().add() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function add_emptyIterator_ThrowsError(): void
		{
			var newListIterator:IListIterator = new ReadOnlyListIterator(new ArrayList());
			newListIterator.add("element-1");
		}
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function add_iteratorWithThreeElements_addAfterCallNext_ThrowsError(): void
		{
			listIterator.next();
			listIterator.add("element-5");
		}
		
		///////////////////////////////////////////
		// ReadOnlyListIterator().remove() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_notEmptyIterator_callRemoveBeforeCallNext_ThrowsError(): void
		{
			listIterator.remove();
		}
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_notEmptyIterator_callRemoveAfterNext_checkIfPointerIsCorrect_ThrowsError(): void
		{
			listIterator.next();
			listIterator.remove();
		}
		
		/////////////////////////////////
		// ArrayIterator().set() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function set_iteratorWithThreeElements_setWithoutCallNextOrPrevious_ThrowsError(): void
		{
			listIterator.set("element-1");
		}

		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function set_iteratorWithThreeElements_setAfterCallNext_ThrowsError(): void
		{
			listIterator.next();
			listIterator.set("element-11");
		}
		
	}

}