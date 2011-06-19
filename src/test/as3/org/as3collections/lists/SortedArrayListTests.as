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
	import org.as3collections.IListTests;
	import org.as3collections.ISortedList;
	import org.as3collections.PriorityObject;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3coreaddendum.system.comparators.DateComparator;
	import org.as3coreaddendum.system.comparators.NumberComparator;
	import org.as3coreaddendum.system.comparators.PriorityComparator;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class SortedArrayListTests extends IListTests
	{
		
		public function get sortedList():ISortedList { return collection as ISortedList; }
		
		public function SortedArrayListTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// when using this method in tests
			// it uses the default sort behavior
			// which is sort objects by String using Object.toString()
			
			return new SortedArrayList();
		}
		
		///////////////////////////////////
		// ArrayList() constructor TESTS //
		///////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newList:IList = new SortedArrayList(["element-1", "element-2"]);
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newList:IList = new SortedArrayList(["element-1", "element-2"]);
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		//////////////////////////////
		// IList().comparator TESTS //
		//////////////////////////////
		
		[Test]
		public function comparator_createListWithComparator_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedList:ISortedList = new SortedArrayList(null, comparator);
			
			Assert.assertEquals(comparator, newSortedList.comparator);
		}
		
		[Test]
		public function comparator_createListWithComparatorButChangesIt_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator1:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedList:ISortedList = new SortedArrayList(null, comparator1);
			
			var comparator2:IComparator = new NumberComparator();
			newSortedList.comparator = comparator2;
			
			Assert.assertEquals(comparator2, newSortedList.comparator);
		}
		
		[Test]
		public function comparator_changeComparatorAndGetAtToCheckIfListWasReorderedAndCorrectElementReturned_ReturnTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			var priorityObject3:PriorityObject = new PriorityObject(3);
			
			sortedList.add(priorityObject2);
			sortedList.add(priorityObject3);
			sortedList.add(priorityObject1);
			
			var newComparator:IComparator = new PriorityComparator();
			sortedList.comparator = newComparator;
			
			var element:PriorityObject = sortedList.getAt(0);
			Assert.assertEquals(priorityObject3, element);
		}
		
		///////////////////////////
		// IList().options TESTS //
		///////////////////////////
		
		[Test]
		public function options_createListWithOptions_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedList:ISortedList = new SortedArrayList(null, null, options);
			
			Assert.assertEquals(options, newSortedList.options);
		}
		
		[Test]
		public function options_createListWithOptionsButChangesIt_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedList:ISortedList = new SortedArrayList(null, null, options);
			
			var options2:uint = Array.NUMERIC;
			newSortedList.options = options2;
			
			Assert.assertEquals(options2, newSortedList.options);
		}
		
		[Test]
		public function options_changeOptionsAndGetAtToCheckIfListWasReorderedAndCorrectElementReturned_ReturnTrue(): void
		{
			sortedList.add("element-1");
			sortedList.add("element-2");
			sortedList.options = Array.DESCENDING;
			
			var element:String = sortedList.getAt(0);
			Assert.assertEquals("element-2", element);
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_twoEmptyListsCreatedWithDifferentSortOptions_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			sortedList.options = 0;//ASCENDING
			
			var sortedList2:ISortedList = new SortedArrayList();
			sortedList2.options = Array.DESCENDING;
			
			Assert.assertFalse(sortedList.equals(sortedList2));
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var list2:ICollection = getCollection();
			list2.add("element-2");
			list2.add("element-1");
			
			Assert.assertTrue(list.equals(list2));
		}
		
		///////////////////////////
		// IList().getAt() TESTS //
		///////////////////////////
		
		[Test]
		public function getAt_listWithIntegerElements_numericAscendingOrder_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			sortedList.options = Array.NUMERIC;
			
			sortedList.add(5);
			sortedList.add(9);
			sortedList.add(7);
			
			var element:int = sortedList.getAt(1);
			Assert.assertEquals(7, element);
		}
		
		[Test]
		public function getAt_listWithIntegerElements_numericDescendingOrder_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			sortedList.options = Array.NUMERIC | Array.DESCENDING;
			
			sortedList.add(5);
			sortedList.add(9);
			sortedList.add(7);
			
			var element:int = sortedList.getAt(0);
			Assert.assertEquals(9, element);
		}
		
		/////////////////////////////
		// IList().indexOf() TESTS //
		/////////////////////////////
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalNotEquatableElements_indexOfFromIndexThree_ReturnsThree(): void
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
		
		/////////////////////////////////
		// IList().lastIndexOf() TESTS //
		/////////////////////////////////
		
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
			Assert.assertEquals(3, index);
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
			
			var index:int = list.lastIndexOf("element-3", 2);
			Assert.assertEquals(2, index);
		}
		
		/////////////////////////////
		// IList().reverse() TESTS //
		/////////////////////////////
		
		[Test]
		public function reverse_listWithIntegerElements_numericAscendingOrder_reverseAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			sortedList.options = Array.NUMERIC;
			
			sortedList.add(5);
			sortedList.add(9);
			sortedList.add(7);
			sortedList.reverse();
			
			var element:int = sortedList.getAt(0);
			Assert.assertEquals(9, element);
		}
		
		[Test]
		public function reverse_listWithIntegerElements_numericAscendingOrder_reverseThenAddNewElementAndCheckIfReturnedElementIsCorrectKeepingListReversedAfterChange_ReturnsTrue(): void
		{
			sortedList.options = Array.NUMERIC;
			
			sortedList.add(5);
			sortedList.add(9);
			sortedList.add(7);
			sortedList.reverse();
			sortedList.add(8);
			
			var element:int = sortedList.getAt(1);
			Assert.assertEquals(8, element);
		}
		
		////////////////////////////
		// IList().sortOn() TESTS //
		////////////////////////////
		
		[Test]
		public function sortOn_listWithObjectsWithProperty_checkIfElementIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			sortedList.add(obj1);
			sortedList.add(obj2);
			sortedList.add(obj3);
			sortedList.sortOn("age", Array.NUMERIC);
			
			var element:Object = sortedList.getAt(0);
			Assert.assertEquals(obj2, element);
		}
		
		/////////////////////////
		// IList() MIXED TESTS //
		/////////////////////////
		
		[Test]
		public function addAt_getAt_listWithOneNotEquatableElement_addAtZeroNotEquatable_checkIfElementWasAddedAtZeroIndex_ReturnsTrue(): void
		{
			list.add("element-1");
			list.addAt(0, "element-2");
			
			var element1:String = list.getAt(0);
			Assert.assertEquals("element-1", element1);
		}
		
		[Test]
		public function add_getAt_listWithOneNotEquatableElement_addAtZeroNotEquatable_checkIfElementWasAddedAtZeroIndex_ReturnsTrue(): void
		{
			sortedList.comparator = new DateComparator();
			
			var d1:Date = new Date(2010, 4, 10);
			var d2:Date = new Date(2009, 4, 10);
			
			sortedList.add(d1);
			sortedList.add(d2);
			
			var element1:Date = sortedList.getAt(0);
			Assert.assertEquals(d2, element1);
		}
		
	}

}