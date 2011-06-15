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

package org.as3collections.lists
{
	import org.as3collections.ICollection;
	import org.as3collections.ICollectionTests;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IListTests extends ICollectionTests
	{
		public function get list():IList { return collection as IList; }
		
		public function IListTests()
		{
			
		}
		
		/////////////////////////
		// IList().add() TESTS //
		/////////////////////////
		
		[Test]
		public function add_listWithTwoNotEquatableElements_checkIfFirstElementIsCorrect_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var element1:String = list.getAt(0);
			Assert.assertEquals("element-1", element1);
		}
		
		[Test]
		public function add_listWithThreeNotEquatableElements_checkIfSecondElementIsCorrect_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var element1:String = list.getAt(1);
			Assert.assertEquals("element-2", element1);
		}
		
		///////////////////////////
		// IList().addAt() TESTS //
		///////////////////////////
		
		[Test]
		public function addAt_emptyList_validArgumentNotEquatableAndZeroIndex_ReturnsTrue(): void
		{
			var added:Boolean = list.addAt(0, "element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function addAt_listWithThreeNotEquatableElements_validArgumentNotEquatableAndIndexThree_boundaryCondition_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var added:Boolean = list.addAt(3, "element-4");
			Assert.assertTrue(added);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function addAt_emptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.addAt(1, "element-1");
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function addAt_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.addAt(4, "element-4");
		}
		
		//////////////////////////////
		// IList().addAllAt() TESTS //
		//////////////////////////////
		
		[Test]
		public function addAllAt_emptyList_validListNoneElementEquatable_ReturnsTrue(): void
		{
			var addCollection:ICollection = getCollection();
			addCollection.add("element-1");
			addCollection.add("element-2");
			
			var changed:Boolean = list.addAllAt(0, addCollection);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_notEmptyList_validArgumentNotEquatable_boundaryCondition_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var addCollection:ICollection = getCollection();
			addCollection.add("element-4");
			addCollection.add("element-5");
			
			var added:Boolean = list.addAllAt(3, addCollection);
			Assert.assertTrue(added);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function addAllAt_emptyList_indexOutOfBounds_ThrowsError(): void
		{
			var addCollection:ICollection = getCollection();
			addCollection.add("element-4");
			
			list.addAllAt(1, addCollection);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function addAllAt_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var addCollection:ICollection = getCollection();
			addCollection.add("element-4");
			
			list.addAllAt(4, addCollection);
		}
		
		///////////////////////////
		// IList().clone() TESTS //
		///////////////////////////
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var clonedList:IList = list.clone();
			Assert.assertTrue(list.equals(clonedList));
		}
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_cloneButChangeElementsOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var clonedList:IList = list.clone();
			clonedList.reverse();
			
			Assert.assertFalse(list.equals(clonedList));
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_equalElementsButDifferentOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var collection2:ICollection = getCollection();
			collection2.add("element-2");
			collection2.add("element-1");
			
			Assert.assertFalse(collection.equals(collection2));
		}
		
		///////////////////////////
		// IList().getAt() TESTS //
		///////////////////////////
		
		[Test]
		public function getAt_addedOneNotEquatableElement_getAtIndexZero_checkIfReturnedElementMatches_ReturnsTrue(): void
		{
			list.add("element-1");
			
			var element:String = list.getAt(0);
			Assert.assertEquals("element-1", element);
		}
		
		[Test]
		public function getAt_addedThreeNotEquatableElements_boundaryCondition_checkIfReturnedElementMatches_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var element:String = list.getAt(2);
			Assert.assertEquals("element-3", element);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getAt_emptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.getAt(1);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getAt_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.getAt(3);
		}
		
		/////////////////////////////
		// IList().indexOf() TESTS //
		/////////////////////////////
		
		[Test]
		public function indexOf_emptyList_ReturnsNegative(): void
		{
			var index:int = list.indexOf("element-1");
			Assert.assertEquals(-1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeNotEquatableElements_indexOfElementNotAdded_ReturnsNegative(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.indexOf("element-4");
			Assert.assertEquals(-1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeNotEquatableElements_indexOfFirtElement_ReturnsZero(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.indexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOf_listWithThreeNotEquatableElements_indexOfSecondElement_ReturnsOne(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.indexOf("element-2");
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeNotEquatableElements_indexOfThirdElement_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.indexOf("element-3");
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalNotEquatableElements_indexOf_ReturnsZero(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.indexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalNotEquatableElements_indexOfFromIndexOne_ReturnsOne(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.indexOf("element-1", 1);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalNotEquatableElements_indexOfFromIndexTwo_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.indexOf("element-1", 2);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalNotEquatableElements_indexOfFromIndexTwo_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.indexOf("element-3", 2);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalNotEquatableElements_indexOfFromIndexThree_ReturnsFour(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.indexOf("element-3", 3);
			Assert.assertEquals(4, index);
		}
		
		/////////////////////////////////
		// IList().lastIndexOf() TESTS //
		/////////////////////////////////
		
		[Test]
		public function lastIndexOf_emptyList_ReturnsNegative(): void
		{
			var index:int = list.lastIndexOf("element-1");
			Assert.assertEquals(-1, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeNotEquatableElements_lastIndexOfElementNotAdded_ReturnsNegative(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.lastIndexOf("element-4");
			Assert.assertEquals(-1, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeNotEquatableElements_lastIndexOfFirtElement_ReturnsZero(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.lastIndexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalNotEquatableElements_lastIndexOf_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.lastIndexOf("element-1");
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalNotEquatableElements_lastIndexOfFromIndexOne_ReturnsOne(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.lastIndexOf("element-1", 1);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalNotEquatableElements_lastIndexOfFromIndexZero_ReturnsZero(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.lastIndexOf("element-1", 0);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalNotEquatableElements_lastIndexOf_ReturnsCorrectIndex(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.lastIndexOf("element-3");
			Assert.assertEquals(4, index);
		}
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalNotEquatableElements_lastIndexOfFromIndex_ReturnsCorrectIndex(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.lastIndexOf("element-3", 3);
			Assert.assertEquals(2, index);
		}
		
		//////////////////////////////
		// IList().modCount() TESTS //
		//////////////////////////////
		
		[Test]
		public function modCount_addOneNotEquatableElement_ReturnsOne(): void
		{
			list.add("element-1");
			
			var modCount:int = list.modCount;
			Assert.assertEquals(1, modCount);
		}
		
		[Test]
		public function modCount_addTwoNotEquatableElements_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var modCount:int = list.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_addAll_argumentWithThreeNotEquatableElements_ReturnsThree(): void
		{
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add("element-1");
			addAllCollection.add("element-2");
			addAllCollection.add("element-3");
			
			list.addAll(addAllCollection);
			
			var modCount:int = list.modCount;
			Assert.assertEquals(3, modCount);
		}
		
		[Test]
		public function modCount_clearEmptyList_ReturnsZero(): void
		{
			list.clear();
			
			var modCount:int = list.modCount;
			Assert.assertEquals(0, modCount);
		}
		
		[Test]
		public function modCount_addTwoNotEquatableElementsThenClear_ReturnsThree(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.clear();
			
			var modCount:int = list.modCount;
			Assert.assertEquals(3, modCount);
		}
		
		[Test]
		public function modCount_addOneNotEquatableElementThenRemoveIt_ReturnsTwo(): void
		{
			list.add("element-1");
			list.remove("element-1");
			
			var modCount:int = list.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_removeAll_addThreeNotEquatableElementsThenRemoveAllWithTwoElements_ReturnsFive(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var removeAllCollection:ICollection = getCollection();
			removeAllCollection.add("element-2");
			removeAllCollection.add("element-3");
			
			list.removeAll(removeAllCollection);
			
			var modCount:int = list.modCount;
			Assert.assertEquals(5, modCount);
		}
		
		[Test]
		public function modCount_removeAt_addOneNotEquatableElementThenRemoveIt_ReturnsTwo(): void
		{
			list.add("element-1");
			list.removeAt(0);
			
			var modCount:int = list.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_removeRange_addThreeNotEquatableElementsThenRemoveRangeWithTwoElements_ReturnsFour(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.removeRange(1, 3);
			
			var modCount:int = list.modCount;
			Assert.assertEquals(4, modCount);
		}
		
		[Test]
		public function modCount_retainAll_addThreeNotEquatableElementsThenRetainAllWithTwoElements_ReturnsFour(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			
			list.retainAll(retainAllCollection);
			
			var modCount:int = list.modCount;
			Assert.assertEquals(4, modCount);
		}
		
		//////////////////////////////
		// IList().removeAt() TESTS //
		//////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_emptyCollection_ThrowsError(): void
		{
			list.removeAt(0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_notEmptyCollection_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.removeAt(2);
		}
		
		[Test]
		public function removeAt_listWithOneNotEquatabeElement_removeAtIndexZero_ReturnsCorrectObject(): void
		{
			list.add("element-1");
			
			var element:String = list.removeAt(0);
			Assert.assertEquals("element-1", element);
		}
		
		[Test]
		public function removeAt_listWithThreeNotEquatabeElements_boundaryCondition_ReturnsCorrectObject(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var element:String = list.removeAt(2);
			Assert.assertEquals("element-3", element);
		}
		
		[Test]
		public function removeAt_listWithThreeNotEquatabeElements_checkIfListContainsRemoved_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var element:String = list.removeAt(2);
			
			var contains:Boolean = list.contains(element);
			Assert.assertFalse(contains);
		}
		
		/////////////////////////////////
		// IList().removeRange() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeRange_emptyCollection_ThrowsError(): void
		{
			list.removeRange(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeRange_notEmptyCollection_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.removeRange(0, 3);
		}
		
		[Test]
		public function removeRange_listWithOneNotEquatabeElement_ReturnsValidList(): void
		{
			list.add("element-1");
			
			var removedList:ICollection = list.removeRange(0, 1);
			Assert.assertNotNull(removedList);
		}
		
		/////////////////////////////
		// IList().reverse() TESTS //
		/////////////////////////////
		
		[Test]
		public function reverse_emptyCollection_Void(): void
		{
			list.reverse();
		}
		
		[Test]
		public function reverse_listWithTwoNotEquatableElements_checkIfFirstElementNowIsTheSecond_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			list.reverse();
			
			var element1:String = list.getAt(1);
			Assert.assertEquals("element-1", element1);
		}
		
		[Test]
		public function reverse_listWithFiveNotEquatableElements_checkIfFourthElementNowIsTheSecond_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-5");
			
			list.reverse();
			
			var element4:String = list.getAt(1);
			Assert.assertEquals("element-4", element4);
		}
		
		///////////////////////////
		// IList().setAt() TESTS //
		///////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setAt_emptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.setAt(0, "element-1");
		}
		
		[Test]
		public function setAt_notEmptyList_validArgumentNotEquatable_boundaryCondition_checkIfListContainsAddedElement_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.setAt(2, "element-4");
			
			var contains:Boolean = list.contains("element-4");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function setAt_notEmptyList_validArgumentNotEquatable_boundaryCondition_checkIfListNotContainsReplacedElement_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.setAt(2, "element-4");
			
			var contains:Boolean = list.contains("element-3");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function setAt_notEmptyList_validArgumentNotEquatable_boundaryCondition_checkIfReturnedCorrectElement_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var removedElement:String = list.setAt(1, "element-4");
			Assert.assertTrue("element-2", removedElement);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setAt_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.setAt(3, "element-4");
		}
		
		/////////////////////////////
		// IList().subList() TESTS //
		/////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_emptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.subList(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			list.subList(0, 4);
		}
		
		[Test]
		public function subList_notEmptyList_checkIfReturnedListSizeMatches_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var subList:IList = list.subList(0, 2);
			
			var size:int = subList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function subList_notEmptyList_boundaryCondition_checkIfReturnedListSizeMatches_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var subList:IList = list.subList(0, 3);
			
			var size:int = subList.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function subList_notEmptyList_checkIfSubListContainsElement_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var subList:IList = list.subList(0, 2);
			
			var contains:Boolean = subList.contains("element-2");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function subList_notEmptyList_checkIfSubListContainsElement_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var subList:IList = list.subList(0, 2);
			
			var contains:Boolean = subList.contains("element-3");
			Assert.assertFalse(contains);
		}
		
		/////////////////////////
		// IList() MIXED TESTS //
		/////////////////////////
		
		[Test]
		public function addAt_getAt_listWithOneNotEquatableElement_addAtZeroNotEquatable_checkIfElementWasAddedAtZeroIndex_ReturnsTrue(): void
		{
			list.add("element-1");
			list.addAt(0, "element-2");
			
			var element2:String = list.getAt(0);
			Assert.assertEquals("element-2", element2);
		}
		
		[Test]
		public function removeRange_isEmpty_listWithOneNotEquatabeElement_removeRangeAndCheckIfListIsEmpty_ReturnsTrue(): void
		{
			list.add("element-1");
			list.removeRange(0, 1);
			
			var isEmpty:Boolean = list.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeRange_size_listWithOneNotEquatabeElement_removeRangeAndCheckIfListSizeIsZero_ReturnsTrue(): void
		{
			list.add("element-1");
			list.removeRange(0, 1);
			
			var size:int = list.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function removeRange_isEmpty_listWithOneNotEquatabeElement_removeRangeEmpty_checkIfRemovedListIsEmpty_ReturnsTrue(): void
		{
			list.add("element-1");
			var removedList:ICollection = list.removeRange(0, 0);
			
			var isEmpty:Boolean = removedList.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
	}

}