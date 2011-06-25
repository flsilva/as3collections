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
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.UniqueCollectionTests;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueListTests extends UniqueCollectionTests
	{
		public function get list():IList { return collection as IList; };
		
		public function UniqueListTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// using an ArrayList object
			// instead of a fake to simplify tests
			// since ArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in ArrayList may break some tests in this class
			// when errors in tests in this class occur
			// consider that it can be in the ArrayList object
			return new UniqueList(new ArrayList());
		}
		
		////////////////////////////////////
		// UniqueList() constructor TESTS //
		////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newList:IList = new UniqueList(new ArrayList(["element-1", "element-2"]));
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newList:IList = new UniqueList(new ArrayList(["element-1", "element-2"]));
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function constructor_argumentWithTwoDuplicateNotEquatableElements_checkIfSizeIsOne_ReturnsTrue(): void
		{
			var newList:IList = new UniqueList(new ArrayList(["element-1", "element-1"]));
			
			var size:int = newList.size();
			Assert.assertEquals(1, size);
		}
		
		////////////////////////////////////
		// UniqueCollection().add() TESTS //
		////////////////////////////////////
		
		[Test]
		public function add_duplicateNotEquatableElement_ReturnsFalse(): void
		{
			collection.add("element-1");
			
			var added:Boolean = collection.add("element-1");
			Assert.assertFalse(added);
		}
		
		///////////////////////////////////
		// UniqueList().addAllAt() TESTS //
		///////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function addAllAt_invalidArgument_ThrowsError(): void
		{
			list.addAllAt(0, null);
		}
		
		[Test]
		public function addAllAt_emptyArgument_ReturnsFalse(): void
		{
			var addAllList:IList = new ArrayList();
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateNotEquatableElementAndOneDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			list.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithTwoDuplicateNotEquatableElements_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertFalse(changed);
		}
		
		////////////////////////////////
		// UniqueList().addAt() TESTS //
		////////////////////////////////
		
		[Test]
		public function addAt_notDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var added:Boolean = list.addAt(0, "element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function addAt_duplicateNotEquatableElement_ReturnsFalse(): void
		{
			list.add("element-1");
			
			var added:Boolean = list.addAt(0, "element-1");
			Assert.assertFalse(added);
		}
		
		////////////////////////////////
		// UniqueList().clone() TESTS //
		////////////////////////////////
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_cloneButChangeElementsOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var clonedList:IList = list.clone();
			clonedList.reverse();
			
			Assert.assertFalse(list.equals(clonedList));
		}
		
		/////////////////////////////////
		// UniqueList().equals() TESTS //
		/////////////////////////////////
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var list2:ICollection = getCollection();
			list2.add("element-2");
			list2.add("element-1");
			
			Assert.assertFalse(list.equals(list2));
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var list2:ICollection = getCollection();
			list2.add("element-1");
			list2.add("element-2");
			
			Assert.assertTrue(list.equals(list2));
		}
		
		////////////////////////////////
		// UniqueList().getAt() TESTS //
		////////////////////////////////
		
		[Test]
		public function getAt_addedOneNotEquatableElement_getAtIndexZero_checkIfReturnedElementMatches_ReturnsTrue(): void
		{
			list.add("element-1");
			
			var element:String = list.getAt(0);
			Assert.assertEquals("element-1", element);
		}
		
		//////////////////////////////////
		// UniqueList().indexOf() TESTS //
		//////////////////////////////////
		
		[Test]
		public function indexOf_listWithThreeNotEquatableElements_indexOfSecondElement_ReturnsOne(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			
			var index:int = list.indexOf("element-2");
			Assert.assertEquals(1, index);
		}
		//////////////////////////////////////
		// UniqueList().lastIndexOf() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalNotEquatableElements_lastIndexOf_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-1");
			list.add("element-1");
			
			var index:int = list.lastIndexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////////
		// UniqueList().listIterator() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function listIterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IListIterator = list.listIterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function listIterator_simpleCall_tryToAddDuplicateNotEquatableElementThroughIListIterator_ReturnsFalse(): void
		{
			list.add("element-1");
			var iterator:IListIterator = list.listIterator();
			
			var added:Boolean = iterator.add("element-1");
			Assert.assertFalse(added);
		}
		
		///////////////////////////////////
		// UniqueList().removeAt() TESTS //
		///////////////////////////////////
		
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
		
		//////////////////////////////////////
		// UniqueList().removeRange() TESTS //
		//////////////////////////////////////
		
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
		
		////////////////////////////////
		// UniqueList().setAt() TESTS //
		////////////////////////////////
		
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
		
		//////////////////////////////////
		// UniqueList().subList() TESTS //
		//////////////////////////////////
		
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
		
	}

}