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
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayIteratorTests
	{
		public var iterator:IIterator;
		
		public function ArrayIteratorTests()
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
			return new ArrayIterator(["element-1", "element-2", "element-3", "element-4"]);
		}
		
		///////////////////////////////////////
		// ArrayIterator() constructor TESTS //
		///////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ArrayIterator(null);
		}
		
		/////////////////////////////////////
		// ArrayIterator().hasNext() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function hasNext_emptyIterator_ReturnsFalse(): void
		{
			var newIterator:IIterator = new ArrayIterator([]);
			
			var hasNext:Boolean = newIterator.hasNext();
			Assert.assertFalse(hasNext);
		}
		
		[Test]
		public function hasNext_notEmptyIterator_ReturnsTrue(): void
		{
			var hasNext:Boolean = iterator.hasNext();
			Assert.assertTrue(hasNext);
		}
		
		//////////////////////////////////
		// ArrayIterator().next() TESTS //
		//////////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_emptyIterator_ReturnsFalse(): void
		{
			var newIterator:IIterator = new ArrayIterator([]);
			newIterator.next();
		}
		
		[Test]
		public function next_notEmptyIterator_ReturnsValidElement(): void
		{
			var next:* = iterator.next();
			Assert.assertNotNull(next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_callNextOnceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var next:* = iterator.next();
			Assert.assertEquals("element-1", next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_callNextTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			
			var next:* = iterator.next();
			Assert.assertEquals("element-2", next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_boundaryCondition_callNextFourTimesAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			
			var next:* = iterator.next();
			Assert.assertEquals("element-4", next);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_iteratorWithFourElements_callNextFiveTimes_ThrowsError(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
		}
		
		/////////////////////////////////////
		// ArrayIterator().pointer() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function pointer_emptyIterator_ReturnsMinusOne(): void
		{
			var pointer:* = iterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourElements_callNextOnceAndCheckPointer_ReturnsZero(): void
		{
			iterator.next();
			
			var pointer:* = iterator.pointer();
			Assert.assertEquals(0, pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourElements_callNextFourTimesAndCheckPointer_ReturnsThree(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			
			var pointer:* = iterator.pointer();
			Assert.assertEquals(3, pointer);
		}
		
		////////////////////////////////////
		// ArrayIterator().remove() TESTS //
		////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveBeforeCallNext_ThrowsError(): void
		{
			iterator.remove();
		}
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveTwice_ThrowsError(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.remove();
			iterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_callRemoveAfterNext_Void(): void
		{
			iterator.next();
			iterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_callRemoveAfterNext_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.remove();
			
			var pointer:* = iterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function remove_notEmptyIterator_callRemoveAfterNext_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.remove();
			
			var next:* = iterator.next();
			Assert.assertEquals("element-2", next);
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElement_Void(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElement_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.remove();
			
			var pointer:* = iterator.pointer();
			Assert.assertEquals(2, pointer);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElementAndCallNext_ThrowsError(): void
		{
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.next();
			iterator.remove();
			
			iterator.next();
		}
		
		///////////////////////////////////
		// ArrayIterator().reset() TESTS //
		///////////////////////////////////
		
		[Test]
		public function reset_emptyIterator_Void(): void
		{
			var newIterator:IIterator = new ArrayIterator([]);
			newIterator.reset();
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextOnceAndCallReset_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.reset();
			
			var pointer:* = iterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextTwiceAndCallReset_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			iterator.next();
			iterator.next();
			iterator.reset();
			
			var next:* = iterator.next();
			Assert.assertEquals("element-1", next);
		}
		
	}

}