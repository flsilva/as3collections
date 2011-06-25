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
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.lists.ArrayList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ListIteratorTests
	{
		public var listIterator:IListIterator;
		
		public function ListIteratorTests()
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
			return new ListIterator(new ArrayList(["element-1", "element-2", "element-3", "element-4"]));
		}
		
		///////////////////////////////////////
		// ArrayIterator() constructor TESTS //
		///////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ListIterator(null);
		}
		
		[Test]
		public function constructor_iteratorWithFourElements_sendsValidLastPosition_Void(): void
		{
			new ListIterator(new ArrayList(["element-1", "element-2", "element-3", "element-4"]), 4);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function constructor_iteratorWithFourElements_sendsInvalidPositionGreaterThanLimit_ThrowsError(): void
		{
			new ListIterator(new ArrayList(["element-1", "element-2", "element-3", "element-4"]), 5);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function constructor_iteratorWithFourElements_sendsInvalidPositionLessThanLimit_ThrowsError(): void
		{
			new ListIterator(new ArrayList(["element-1", "element-2", "element-3", "element-4"]), -1);
		}
		
		/////////////////////////////////
		// ArrayIterator().add() TESTS //
		/////////////////////////////////
		
		[Test]
		public function add_emptyIterator_ReturnsTrue(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			
			var added:Boolean = newListIterator.add("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function add_iteratorWithThreeElements_addBeforeLastPosition_checkIfNextElementIsCorrect_ReturnTrue(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList(["element-1", "element-2", "element-4"]), 0);
			newListIterator.next();
			newListIterator.next();
			newListIterator.add("element-3");
			
			var next:* = newListIterator.next();
			Assert.assertEquals("element-4", next);
		}
		
		[Test]
		public function add_iteratorWithThreeElements_addBeforeLastPosition_checkIfPreviousElementIsCorrect_ReturnTrue(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList(["element-1", "element-2", "element-4"]), 0);
			newListIterator.next();
			newListIterator.next();
			newListIterator.add("element-3");
			
			var previous:* = newListIterator.previous();
			Assert.assertEquals("element-3", previous);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function add_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallAdd_ThrowsError(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3"]);
			
			var newListIterator:IListIterator = new ListIterator(list);
			newListIterator.next();
			
			list.add("element-4");
			
			newListIterator.add("element-5");
		}
		
		/////////////////////////////////////
		// ArrayIterator().hasNext() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function hasNext_emptyIterator_ReturnsFalse(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			
			var hasNext:Boolean = newListIterator.hasNext();
			Assert.assertFalse(hasNext);
		}
		
		[Test]
		public function hasNext_notEmptyIterator_firstPosition_ReturnsTrue(): void
		{
			var hasNext:Boolean = listIterator.hasNext();
			Assert.assertTrue(hasNext);
		}
		
		[Test]
		public function hasNext_notEmptyIterator_lastPosition_ReturnsFalse(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			
			var hasNext:Boolean = listIterator.hasNext();
			Assert.assertFalse(hasNext);
		}
		
		/////////////////////////////////////////
		// ArrayIterator().hasPrevious() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function hasPrevious_emptyIterator_ReturnsFalse(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			
			var hasPrevious:Boolean = newListIterator.hasPrevious();
			Assert.assertFalse(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_firstPosition_ReturnsFalse(): void
		{
			var hasPrevious:Boolean = listIterator.hasPrevious();
			Assert.assertFalse(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_secondPosition_ReturnsTrue(): void
		{
			listIterator.next();
			
			var hasPrevious:Boolean = listIterator.hasPrevious();
			Assert.assertTrue(hasPrevious);
		}
		
		[Test]
		public function hasPrevious_notEmptyIterator_lastPosition_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			
			var hasNext:Boolean = listIterator.hasPrevious();
			Assert.assertTrue(hasNext);
		}
		
		//////////////////////////////////
		// ArrayIterator().next() TESTS //
		//////////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_emptyIterator_ThrowsError(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			newListIterator.next();
		}
		
		[Test]
		public function next_notEmptyIterator_ReturnsValidElement(): void
		{
			var next:* = listIterator.next();
			Assert.assertNotNull(next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_callNextOnceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var next:* = listIterator.next();
			Assert.assertEquals("element-1", next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_callNextTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-2", next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_boundaryCondition_callNextFourTimesAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-4", next);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function next_iteratorWithFourElements_callNextFiveTimes_ThrowsError(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
		}
		
		[Test]
		public function next_iteratorWithFourElements_sendingPositionViaConstructorArgument_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3", "element-4"]);
			var newListIterator:IListIterator = new ListIterator(list, 1);
			
			var next:* = newListIterator.next();
			Assert.assertEquals("element-2", next);
		}
		
		[Test]
		public function next_iteratorWithFourElements_sendingPositionViaConstructorArgument_checkIfPreviousElementIsCorrect_ReturnsTrue(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3", "element-4"]);
			var newListIterator:IListIterator = new ListIterator(list, 4);
			
			var previous:* = newListIterator.previous();
			Assert.assertEquals("element-4", previous);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function next_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallNextAgain_ThrowsError(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3"]);
			
			var newListIterator:IListIterator = new ListIterator(list);
			newListIterator.next();
			
			list.remove("element-3");
			
			newListIterator.next();
		}
		
		///////////////////////////////////////
		// ArrayIterator().nextIndex() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function nextIndex_emptyIterator_ReturnsZero(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			
			var nextIndex:int = newListIterator.nextIndex();
			Assert.assertEquals(0, nextIndex);
		}
		
		[Test]
		public function nextIndex_iteratorWithFourElements_callNextOnceAndCheckNextIndex_ReturnsOne(): void
		{
			listIterator.next();
			
			var nextIndex:int = listIterator.nextIndex();
			Assert.assertEquals(1, nextIndex);
		}
		
		[Test]
		public function nextIndex_iteratorWithFourElements_callNextTwiceAndPreviousOnceAndCheckNextIndex_ReturnsOne(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.previous();
			
			var nextIndex:int = listIterator.nextIndex();
			Assert.assertEquals(1, nextIndex);
		}
		
		/////////////////////////////////////
		// ArrayIterator().pointer() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function pointer_emptyIterator_ReturnsMinusOne(): void
		{
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourElements_callNextOnceAndCheckPointer_ReturnsZero(): void
		{
			listIterator.next();
			
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(0, pointer);
		}
		
		[Test]
		public function pointer_iteratorWithFourElements_callNextFourTimesAndCheckPointer_ReturnsThree(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(3, pointer);
		}
		
		//////////////////////////////////////
		// ArrayIterator().previous() TESTS //
		//////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_emptyIterator_ThrowsError(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			newListIterator.previous();
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_notEmptyIterator_firstPosition_ThrowsError(): void
		{
			listIterator.previous();
		}
		
		[Test]
		public function previous_iteratorWithFourElements_secondPosition_callPreviousOnceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			
			var previous:* = listIterator.previous();
			Assert.assertEquals("element-1", previous);
		}
		
		[Test]
		public function previous_iteratorWithFourElements_thirdPosition_callPreviousTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			
			listIterator.previous();
			
			var previous:* = listIterator.previous();
			Assert.assertEquals("element-1", previous);
		}
		
		[Test]
		public function previous_iteratorWithFourElements_boundaryCondition_lastPosition_callPreviousFourTimesAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			
			listIterator.previous();
			listIterator.previous();
			listIterator.previous();
			
			var previous:* = listIterator.previous();
			Assert.assertEquals("element-1", previous);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function previous_iteratorWithFourElements_lastPosition_callPreviousFiveTimes_ThrowsError(): void
		{
			listIterator.previous();
			listIterator.previous();
			listIterator.previous();
			listIterator.previous();
			listIterator.previous();
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function previous_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallPrevious_ThrowsError(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3"]);
			
			var newListIterator:IListIterator = new ListIterator(list);
			newListIterator.next();
			
			list.add("element-4");
			
			newListIterator.previous();
		}
		
		///////////////////////////////////////////
		// ArrayIterator().previousIndex() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function previousIndex_emptyIterator_ReturnsMinusOne(): void
		{
			var newListIterator:IListIterator = new ListIterator(new ArrayList());
			
			var previousIndex:int = newListIterator.previousIndex();
			Assert.assertEquals(-1, previousIndex);
		}
		
		[Test]
		public function previousIndex_iteratorWithFourElements_callNextOnceAndCheckPreviousIndex_ReturnsZero(): void
		{
			listIterator.next();
			
			var previousIndex:int = listIterator.previousIndex();
			Assert.assertEquals(0, previousIndex);
		}
		
		[Test]
		public function previousIndex_iteratorWithFourElements_callNextTwiceAndPreviousOnceAndCheckPreviousIndex_ReturnsOne(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.previous();
			
			var previousIndex:int = listIterator.previousIndex();
			Assert.assertEquals(0, previousIndex);
		}
		
		////////////////////////////////////
		// ArrayIterator().remove() TESTS //
		////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveBeforeCallNext_ThrowsError(): void
		{
			listIterator.remove();
		}
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function remove_notEmptyIterator_callRemoveTwice_ThrowsError(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.remove();
			listIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterCallNext_Void(): void
		{
			listIterator.next();
			listIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterCallPrevious_Void(): void
		{
			listIterator.next();
			listIterator.previous();
			listIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterNext_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.remove();
			
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterNext_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.remove();
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-2", next);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterPrevious_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.previous();
			listIterator.remove();
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-3", next);
		}
		
		[Test]
		public function remove_notEmptyIterator_removeAfterPrevious_checkIfPreviuousElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.previous();
			listIterator.remove();
			
			var previous:* = listIterator.previous();
			Assert.assertEquals("element-1", previous);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function remove_notEmptyIterator_removeAfterNext_callPrevious_ThrowsError(): void
		{
			listIterator.next();
			listIterator.remove();
			listIterator.previous();
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElement_Void(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.remove();
		}
		
		[Test]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElement_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.remove();
			
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(2, pointer);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function remove_notEmptyIterator_boundaryCondition_tryToRemoveLastElementAndCallNext_ThrowsError(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.next();
			listIterator.remove();
			
			listIterator.next();
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function remove_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallRemove_ThrowsError(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3"]);
			
			var newListIterator:IListIterator = new ListIterator(list);
			newListIterator.next();
			
			list.add("element-4");
			
			newListIterator.remove();
		}
		
		///////////////////////////////////
		// ArrayIterator().reset() TESTS //
		///////////////////////////////////
		
		[Test]
		public function reset_emptyIterator_Void(): void
		{
			var newListIterator:IIterator = new ListIterator(new ArrayList());
			newListIterator.reset();
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextOnceAndCallReset_checkIfPointerIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.reset();
			
			var pointer:* = listIterator.pointer();
			Assert.assertEquals(-1, pointer);
		}
		
		[Test]
		public function reset_notEmptyIterator_callNextTwiceAndCallReset_checkIfNextElementIsCorrect_ReturnsTrue(): void
		{
			listIterator.next();
			listIterator.next();
			listIterator.reset();
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-1", next);
		}
		
		/////////////////////////////////
		// ArrayIterator().set() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.IllegalStateError")]
		public function set_iteratorWithThreeElements_setWithoutCallNextOrPrevious_ThrowsError(): void
		{
			listIterator.set("element-1");
		}

		[Test]
		public function set_iteratorWithThreeElements_setAfterCallNextOnce_checkIfPreviousElementIsSettedElement_ReturnTrue(): void
		{
			listIterator.next();
			listIterator.set("element-11");
			
			var previous:* = listIterator.previous();
			Assert.assertEquals("element-11", previous);
		}
		
		[Test]
		public function set_iteratorWithThreeElements_setAfterCallNextOnceAndPreviousOnce_checkIfNextElementIsSettedElement_ReturnTrue(): void
		{
			listIterator.next();
			listIterator.previous();
			listIterator.set("element-11");
			
			var next:* = listIterator.next();
			Assert.assertEquals("element-11", next);
		}
		
		[Test(expects="org.as3collections.errors.ConcurrentModificationError")]
		public function set_iteratorWithThreeElements_callNextThenChangeListWithoutUseIteratorThenCallSet_ThrowsError(): void
		{
			var list:IList = new ArrayList(["element-1", "element-2", "element-3"]);
			
			var newListIterator:IListIterator = new ListIterator(list);
			newListIterator.next();
			
			list.add("element-4");
			
			newListIterator.set("element-5");
		}
		
	}

}