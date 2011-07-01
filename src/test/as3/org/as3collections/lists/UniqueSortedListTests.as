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
	import org.as3collections.ISortedList;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueSortedListTests extends UniqueListTests
	{
		public function get uniqueSortedList():UniqueSortedList { return list as UniqueSortedList; }
		
		public function UniqueSortedListTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// using a SortedArrayList object
			// instead of a fake to simplify tests
			// since SortedArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in SortedArrayList may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the SortedArrayList object
			return new UniqueSortedList(new SortedArrayList());
		}
		
		//////////////////////////////////////
		// UniqueSortedList().clone() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsUniqueSortedList_ReturnsTrue(): void
		{
			var clonedList:IList = list.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(UniqueSortedList, clonedList);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_checkIfTypeOfReturnedlistIsUniqueSortedList_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var clonedList:IList = list.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(UniqueSortedList, clonedList);
			Assert.assertTrue(isCorrectType);
		}
		
		///////////////////////////////////////
		// UniqueSortedList().equals() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyListsCreatedWithDifferentSortOptions_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			uniqueSortedList.options = 0;//ASCENDING
			
			var sortedList2:UniqueSortedList = getCollection() as UniqueSortedList;
			sortedList2.options = Array.DESCENDING;
			
			var equal:Boolean = uniqueSortedList.equals(sortedList2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			uniqueSortedList.add("element-1");
			uniqueSortedList.add("element-2");
			
			var sortedList2:ICollection = getCollection();
			sortedList2.add("element-2");
			sortedList2.add("element-1");
			
			var equal:Boolean = uniqueSortedList.equals(sortedList2);
			Assert.assertTrue(equal);
		}
		
		////////////////////////////////////////
		// UniqueSortedList().indexOf() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function indexOf_listWithThreeIntegers_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var newSortedList:ISortedList = new SortedArrayList();
			var newUniqueSortedList:ISortedList = new UniqueSortedList(newSortedList);
			
			newUniqueSortedList.options = Array.NUMERIC | Array.DESCENDING;
			
			newUniqueSortedList.add(5);
			newUniqueSortedList.add(9);
			newUniqueSortedList.add(7);
			
			var index:int = newUniqueSortedList.indexOf(9);
			Assert.assertEquals(0, index);
		}
		
		/////////////////////////////////////
		// UniqueSortedList().sort() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function sort_listWithThreeStrings_checkIfElementIsInCorrectIndex_ReturnsTrue(): void
		{
			uniqueSortedList.add("Element-1");
			uniqueSortedList.add("element-3");
			uniqueSortedList.add("element-1");
			
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.LOWER_CASE_FIRST);
			uniqueSortedList.sort(comparator.compare);
			
			var index:int = uniqueSortedList.indexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////////
		// UniqueSortedList().sortOn() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function sortOn_mapWithKeyObjectsWithProperty_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			var newList:ISortedList = getCollection() as ISortedList;
			newList.add(obj1);
			newList.add(obj2);
			newList.add(obj3);
			newList.sortOn("age", Array.NUMERIC);
			
			var index:int = newList.indexOf(obj2);
			Assert.assertEquals(0, index);
		}
		
		////////////////////////////////////////
		// UniqueSortedList().subList() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			uniqueSortedList.subList(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			uniqueSortedList.add("element-1");
			uniqueSortedList.add("element-2");
			uniqueSortedList.add("element-3");
			
			uniqueSortedList.subList(0, 4);
		}
		
		[Test]
		public function subList_notEmptyMap_checkIfReturnedMapSizeMatches_ReturnsTrue(): void
		{
			uniqueSortedList.add("element-1");
			uniqueSortedList.add("element-2");
			uniqueSortedList.add("element-3");
			
			var subList:IList = uniqueSortedList.subList(0, 2);
			
			var size:int = subList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function subList_notEmptyList_checkIfReturnedListIsUniqueSortedList_ReturnsTrue(): void
		{
			uniqueSortedList.add("element-1");
			uniqueSortedList.add("element-2");
			uniqueSortedList.add("element-3");
			
			var subList:IList = uniqueSortedList.subList(0, 2);
			
			var isUniqueSortedList:Boolean = ReflectionUtil.classPathEquals(UniqueSortedList, subList);
			Assert.assertTrue(isUniqueSortedList);
		}
		
	}

}