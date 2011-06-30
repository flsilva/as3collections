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
	import org.as3collections.IListMap;
	import org.as3collections.IListMapIterator;
	import org.as3collections.maps.ArrayListMap;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ListMapIteratorTests
	{
		public var listMapIterator:IListMapIterator;
		
		public function ListMapIteratorTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			listMapIterator = getIterator();
		}
		
		[After]
		public function tearDown(): void
		{
			listMapIterator = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getIterator():IListMapIterator
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			return new ListMapIterator(map);
		}
		
		//////////////////////////////////////////////
		// ListMapIteratorTests() constructor TESTS //
		//////////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ListMapIterator(null);
		}
		
		[Test]
		public function constructor_iteratorWithFourElements_sendsValidLastPosition_Void(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			new ListMapIterator(map, 4);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function constructor_iteratorWithFourElements_sendsInvalidPositionGreaterThanLimit_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			new ListMapIterator(map, 5);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function constructor_iteratorWithFourElements_sendsInvalidPositionLessThanLimit_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			new ListMapIterator(map, -1);
		}
		
		////////////////////////////////////////
		// ListMapIteratorTests().put() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function put_emptyIterator_Void(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			
			newListMapIterator.put("element-1", 1);
		}
		
		[Test]
		public function put_iteratorWithThreeMappings_addBeforeLastPosition_checkIfNextValueIsCorrect_ReturnTrue(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-4", 4);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map, 0);
			newListMapIterator.next();
			newListMapIterator.next();
			newListMapIterator.put("element-3", 3);
			
			var next:* = newListMapIterator.next();
			Assert.assertEquals(4, next);
		}
		
		[Test]
		public function put_iteratorWithThreeMappings_addBeforeLastPosition_checkIfPreviousValueIsCorrect_ReturnTrue(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-4", 4);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map, 0);
			newListMapIterator.next();
			newListMapIterator.next();
			newListMapIterator.put("element-3", 3);
			
			var previous:* = newListMapIterator.previous();
			Assert.assertEquals(3, previous);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function put_iteratorWithThreeMappings_callNextThenChangeMapWithoutUseIteratorThenCallPut_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map);
			newListMapIterator.next();
			
			map.put("element-4", 4);
			
			newListMapIterator.put("element-5", 5);
		}
		
		////////////////////////////////////////////
		// ListMapIteratorTests().hasNext() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function hasNext_emptyIterator_ReturnsFalse(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			
			var hasNext:Boolean = newListMapIterator.hasNext();
			Assert.assertFalse(hasNext);
		}
		
		[Test]
		public function hasNext_notEmptyIterator_firstPosition_ReturnsTrue(): void
		{
			var hasNext:Boolean = listMapIterator.hasNext();
			Assert.assertTrue(hasNext);
		}
		
		[Test]
		public function hasNext_notEmptyIterator_lastPosition_ReturnsFalse(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			
			var hasNext:Boolean = listMapIterator.hasNext();
			Assert.assertFalse(hasNext);
		}
		
		////////////////////////////////////////////////
		// ListMapIteratorTests().hasPrevious() TESTS //
		////////////////////////////////////////////////
		
		[Test]
		public function hasPrevious_emptyIterator_ReturnsFalse(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			
			var hasPrevious:Boolean = newListMapIterator.hasPrevious();
			Assert.assertFalse(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_firstPosition_ReturnsFalse(): void
		{
			var hasPrevious:Boolean = listMapIterator.hasPrevious();
			Assert.assertFalse(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_secondPosition_ReturnsTrue(): void
		{
			listMapIterator.next();
			
			var hasPrevious:Boolean = listMapIterator.hasPrevious();
			Assert.assertTrue(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_lastPosition_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			
			var hasNext:Boolean = listMapIterator.hasPrevious();
			Assert.assertTrue(hasNext);
		}
		
		/////////////////////////////////////////
		// ListMapIteratorTests().next() TESTS //
		/////////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_emptyIterator_ThrowsError(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			newListMapIterator.next();
		}
		
		[Test]
		public function next_notEmptyIterator_ReturnsValidValue(): void
		{
			var next:* = listMapIterator.next();
			Assert.assertNotNull(next);
		}
		
		[Test]
		public function next_iteratorWithFourMappings_callNextOnceAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			var next:* = listMapIterator.next();
			Assert.assertEquals(1, next);
		}
		
		[Test]
		public function next_iteratorWithFourMappings_callNextOnceAndCheckIfReturnedKeyIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			
			var next:* = listMapIterator.pointer();
			Assert.assertEquals("element-1", next);
		}
		
		[Test]
		public function next_iteratorWithFourMappings_callNextTwiceAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(2, next);
		}
		
		[Test]
		public function next_iteratorWithFourMappings_boundaryCondition_callNextFourTimesAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(4, next);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_iteratorWithFourMappings_callNextFiveTimes_ThrowsError(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
		}
		
		[Test]
		public function next_iteratorWithFourMappings_sendingPositionViaConstructorArgument_checkIfNextValueIsCorrect_ReturnsTrue(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map, 1);
			
			var next:* = newListMapIterator.next();
			Assert.assertEquals(2, next);
		}
		
		[Test]
		public function next_iteratorWithFourMappings_sendingPositionViaConstructorArgument_checkIfPreviousValueIsCorrect_ReturnsTrue(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map, 4);
			
			var previous:* = newListMapIterator.previous();
			Assert.assertEquals(4, previous);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function next_iteratorWithThreeMappings_callNextThenChangeMapWithoutUseIteratorThenCallNextAgain_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map);
			newListMapIterator.next();
			
			map.remove("element-3");
			
			newListMapIterator.next();
		}
		
		//////////////////////////////////////////////
		// ListMapIteratorTests().nextIndex() TESTS //
		//////////////////////////////////////////////
		
		[Test]
		public function nextIndex_emptyIterator_ReturnsZero(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			
			var nextIndex:int = newListMapIterator.nextIndex();
			Assert.assertEquals(0, nextIndex);
		}
		
		[Test]
		public function nextIndex_iteratorWithFourMappings_callNextOnceAndCheckNextIndex_ReturnsOne(): void
		{
			listMapIterator.next();
			
			var nextIndex:int = listMapIterator.nextIndex();
			Assert.assertEquals(1, nextIndex);
		}
		
		[Test]
		public function nextIndex_iteratorWithFourMappings_callNextTwiceAndPreviousOnceAndCheckNextIndex_ReturnsOne(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.previous();
			
			var nextIndex:int = listMapIterator.nextIndex();
			Assert.assertEquals(1, nextIndex);
		}
		
		////////////////////////////////////////////
		// ListMapIteratorTests().pointer() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function pointer_emptyIterator_ReturnsNull(): void
		{
			var pointer:* = listMapIterator.pointer();
			Assert.assertNull(pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourMappings_callNextOnceAndCheckPointer_ReturnsCorrectKey(): void
		{
			listMapIterator.next();
			
			var pointer:* = listMapIterator.pointer();
			Assert.assertEquals("element-1", pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourMappings_callNextFourTimesAndCheckPointer_ReturnsCorrectKey(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			
			var pointer:* = listMapIterator.pointer();
			Assert.assertEquals("element-4", pointer);
		}
		
		/////////////////////////////////////////////
		// ListMapIteratorTests().previous() TESTS //
		/////////////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_emptyIterator_ThrowsError(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			newListMapIterator.previous();
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_notEmptyIterator_firstPosition_ThrowsError(): void
		{
			listMapIterator.previous();
		}
		
		[Test]
		public function previous_iteratorWithFourMappings_secondPosition_callPreviousOnceAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			
			var previous:* = listMapIterator.previous();
			Assert.assertEquals(1, previous);
		}
		
		[Test]
		public function previous_iteratorWithFourMappings_thirdPosition_callPreviousTwiceAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			
			listMapIterator.previous();
			
			var previous:* = listMapIterator.previous();
			Assert.assertEquals(1, previous);
		}
		
		[Test]
		public function previous_iteratorWithFourMappings_boundaryCondition_lastPosition_callPreviousFourTimesAndCheckIfReturnedValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			
			listMapIterator.previous();
			listMapIterator.previous();
			listMapIterator.previous();
			
			var previous:* = listMapIterator.previous();
			Assert.assertEquals(1, previous);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_iteratorWithFourMappings_lastPosition_callPreviousFiveTimes_ThrowsError(): void
		{
			listMapIterator.previous();
			listMapIterator.previous();
			listMapIterator.previous();
			listMapIterator.previous();
			listMapIterator.previous();
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function previous_iteratorWithThreeMappings_callNextThenChangeMapWithoutUseIteratorThenCallPrevious_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map);
			newListMapIterator.next();
			
			map.put("element-4", 4);
			
			newListMapIterator.previous();
		}
		
		//////////////////////////////////////////////////
		// ListMapIteratorTests().previousIndex() TESTS //
		//////////////////////////////////////////////////
		
		[Test]
		public function previousIndex_emptyIterator_ReturnsMinusOne(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			
			var previousIndex:int = newListMapIterator.previousIndex();
			Assert.assertEquals(-1, previousIndex);
		}
		
		[Test]
		public function previousIndex_iteratorWithFourMappings_callNextOnceAndCheckPreviousIndex_ReturnsZero(): void
		{
			listMapIterator.next();
			
			var previousIndex:int = listMapIterator.previousIndex();
			Assert.assertEquals(0, previousIndex);
		}
		
		[Test]
		public function previousIndex_iteratorWithFourMappings_callNextTwiceAndPreviousOnceAndCheckPreviousIndex_ReturnsOne(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.previous();
			
			var previousIndex:int = listMapIterator.previousIndex();
			Assert.assertEquals(0, previousIndex);
		}
		
		///////////////////////////////////////////
		// ListMapIteratorTests().remove() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveBeforeCallNext_ThrowsError(): void
		{
			listMapIterator.remove();
		}
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveTwice_ThrowsError(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.remove();
			listMapIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterCallNext_Void(): void
		{
			listMapIterator.next();
			listMapIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterCallPrevious_Void(): void
		{
			listMapIterator.next();
			listMapIterator.previous();
			listMapIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterNext_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.remove();
			
			var pointer:* = listMapIterator.pointer();
			Assert.assertNull(pointer);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterNext_checkIfNextValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.remove();
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(2, next);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterPrevious_checkIfNextValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.previous();
			listMapIterator.remove();
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(3, next);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterPrevious_checkIfPreviuousValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.previous();
			listMapIterator.remove();
			
			var previous:* = listMapIterator.previous();
			Assert.assertEquals(1, previous);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function remove_notEmptyIterator_removeAfterNext_callPrevious_ThrowsError(): void
		{
			listMapIterator.next();
			listMapIterator.remove();
			listMapIterator.previous();
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastMapping_Void(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastMapping_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.remove();
			
			var pointer:* = listMapIterator.pointer();
			Assert.assertEquals("element-3", pointer);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastMappingAndCallNext_ThrowsError(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.remove();
			
			listMapIterator.next();
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function remove_iteratorWithThreeMappings_callNextThenChangeMapWithoutUseIteratorThenCallRemove_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map);
			newListMapIterator.next();
			
			map.put("element-4", 4);
			
			newListMapIterator.remove();
		}
		
		//////////////////////////////////////////
		// ListMapIteratorTests().reset() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function reset_emptyIterator_Void(): void
		{
			var newListMapIterator:IListMapIterator = new ListMapIterator(new ArrayListMap());
			newListMapIterator.reset();
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextOnceAndCallReset_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.reset();
			
			var pointer:* = listMapIterator.pointer();
			Assert.assertNull(pointer);
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextTwiceAndCallReset_checkIfNextValueIsCorrect_ReturnsTrue(): void
		{
			listMapIterator.next();
			listMapIterator.next();
			listMapIterator.reset();
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(1, next);
		}
		
		////////////////////////////////////////
		// ListMapIteratorTests().set() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function set_iteratorWithThreeElements_setWithoutCallNextOrPrevious_ThrowsError(): void
		{
			listMapIterator.set("element-1", 1);
		}

		[Test]
		public function set_iteratorWithThreeElements_setAfterCallNextOnce_checkIfPreviousElementIsSettedElement_ReturnTrue(): void
		{
			listMapIterator.next();
			listMapIterator.set("element-11", 11);
			
			var previous:* = listMapIterator.previous();
			Assert.assertEquals(11, previous);
		}
		
		[Test]
		public function set_iteratorWithThreeElements_setAfterCallNextOnceAndPreviousOnce_checkIfNextElementIsSettedElement_ReturnTrue(): void
		{
			listMapIterator.next();
			listMapIterator.previous();
			listMapIterator.set("element-11", 11);
			
			var next:* = listMapIterator.next();
			Assert.assertEquals(11, next);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function set_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallSet_ThrowsError(): void
		{
			var map:IListMap = new ArrayListMap();
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var newListMapIterator:IListMapIterator = new ListMapIterator(map);
			newListMapIterator.next();
			
			map.put("element-4", 4);
			
			newListMapIterator.set("element-5", 5);
		}
		
	}

}