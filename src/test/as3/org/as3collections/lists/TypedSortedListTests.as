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
	import org.as3collections.TypedCollection;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedSortedListTests extends TypedListTests
	{
		public function get typedSortedList():TypedSortedList { return list as TypedSortedList; }
		
		public function TypedSortedListTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection(type:Class):TypedCollection
		{
			// using a SortedArrayList object
			// instead of a fake to simplify tests
			// since SortedArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in SortedArrayList may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the SortedArrayList object
			return new TypedSortedList(new SortedArrayList(), type);
		}
		
		/////////////////////////////////////
		// TypedSortedList().clone() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsTypedSortedList_ReturnsTrue(): void
		{
			var clonedList:IList = list.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedSortedList, clonedList);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_checkIfTypeOfReturnedlistIsTypedSortedList_ReturnsTrue(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var clonedList:IList = list.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedSortedList, clonedList);
			Assert.assertTrue(isCorrectType);
		}
		
		//////////////////////////////////////
		// TypedSortedList().equals() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyListsCreatedWithDifferentSortOptions_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			typedSortedList.options = 0;//ASCENDING
			
			var sortedList2:TypedSortedList = getCollection(String) as TypedSortedList;
			sortedList2.options = Array.DESCENDING;
			
			var equal:Boolean = typedSortedList.equals(sortedList2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			typedSortedList.add("element-1");
			typedSortedList.add("element-2");
			
			var sortedList2:ICollection = getCollection(String);
			sortedList2.add("element-2");
			sortedList2.add("element-1");
			
			var equal:Boolean = typedSortedList.equals(sortedList2);
			Assert.assertTrue(equal);
		}
		
		///////////////////////////////////////
		// TypedSortedList().indexOf() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function indexOf_listWithThreeIntegers_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var newSortedList:ISortedList = new SortedArrayList();
			var newTypedSortedList:ISortedList = new TypedSortedList(newSortedList, int);
			
			newTypedSortedList.options = Array.NUMERIC | Array.DESCENDING;
			
			newTypedSortedList.add(5);
			newTypedSortedList.add(9);
			newTypedSortedList.add(7);
			
			var index:int = newTypedSortedList.indexOf(9);
			Assert.assertEquals(0, index);
		}
		
		////////////////////////////////////
		// TypedSortedList().sort() TESTS //
		////////////////////////////////////
		
		[Test]
		public function sort_listWithThreeStrings_checkIfElementIsInCorrectIndex_ReturnsTrue(): void
		{
			typedSortedList.add("Element-1");
			typedSortedList.add("element-3");
			typedSortedList.add("element-1");
			
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.LOWER_CASE_FIRST);
			typedSortedList.sort(comparator.compare);
			
			var index:int = typedSortedList.indexOf("element-1");
			Assert.assertEquals(0, index);
		}
		
		//////////////////////////////////////
		// TypedSortedList().sortOn() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function sortOn_mapWithKeyObjectsWithProperty_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			var newList:ISortedList = getCollection(Object) as ISortedList;
			newList.add(obj1);
			newList.add(obj2);
			newList.add(obj3);
			newList.sortOn("age", Array.NUMERIC);
			
			var index:int = newList.indexOf(obj2);
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////////
		// TypedSortedList().subList() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedSortedList.subList(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subList_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedSortedList.add("element-1");
			typedSortedList.add("element-2");
			typedSortedList.add("element-3");
			
			typedSortedList.subList(0, 4);
		}
		
		[Test]
		public function subList_notEmptyMap_checkIfReturnedMapSizeMatches_ReturnsTrue(): void
		{
			typedSortedList.add("element-1");
			typedSortedList.add("element-2");
			typedSortedList.add("element-3");
			
			var subList:IList = typedSortedList.subList(0, 2);
			
			var size:int = subList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function subList_notEmptyList_checkIfReturnedListIsTypedSortedList_ReturnsTrue(): void
		{
			typedSortedList.add("element-1");
			typedSortedList.add("element-2");
			typedSortedList.add("element-3");
			
			var subList:IList = typedSortedList.subList(0, 2);
			
			var isTypedSortedList:Boolean = ReflectionUtil.classPathEquals(TypedSortedList, subList);
			Assert.assertTrue(isTypedSortedList);
		}
		
	}

}