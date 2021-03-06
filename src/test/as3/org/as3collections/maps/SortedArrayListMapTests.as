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

package org.as3collections.maps
{
	import org.as3collections.IListMapTests;
	import org.as3collections.IMap;
	import org.as3collections.ISortedList;
	import org.as3collections.ISortedMap;
	import org.as3collections.PriorityObject;
	import org.as3collections.SortMapBy;
	import org.as3collections.lists.SortedArrayList;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3coreaddendum.system.comparators.NumberComparator;
	import org.as3coreaddendum.system.comparators.PriorityComparator;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class SortedArrayListMapTests extends IListMapTests
	{
		
		public function get sortedMap():ISortedMap { return map as ISortedMap; }
		
		public function SortedArrayListMapTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getMap():IMap
		{
			// when using this method in tests
			// it uses the default sort behavior
			// which is sort objects by String using Object.toString()
			
			return new SortedArrayListMap();
		}
		
		////////////////////////////////////////
		// SortedArrayListMap() constructor TESTS //
		////////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoKeyValue_checkIfIsEmpty_ReturnsFalse(): void
		{
			var addMap:IMap = new HashMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			var newMap:IMap = new SortedArrayListMap(addMap);
			
			var isEmpty:Boolean = newMap.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoKeyValue_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var addMap:IMap = new HashMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			var newMap:IMap = new SortedArrayListMap(addMap);
			
			var size:int = newMap.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////////////
		// SortedArrayListMap().comparator TESTS //
		///////////////////////////////////////
		
		[Test]
		public function comparator_createMapWithComparator_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedList:ISortedList = new SortedArrayList(null, comparator);
			
			Assert.assertEquals(comparator, newSortedList.comparator);
		}
		
		[Test]
		public function comparator_createMapWithComparatorButChangesIt_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator1:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedList:ISortedList = new SortedArrayList(null, comparator1);
			
			var comparator2:IComparator = new NumberComparator();
			newSortedList.comparator = comparator2;
			
			Assert.assertEquals(comparator2, newSortedList.comparator);
		}
		
		[Test]
		public function comparator_changeComparatorAndCallIndexOfKeytToCheckIfMapWasReorderedAndCorrectIndexReturned_ReturnTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			var priorityObject3:PriorityObject = new PriorityObject(3);
			
			sortedMap.put(priorityObject2, 2);
			sortedMap.put(priorityObject3, 3);
			sortedMap.put(priorityObject1, 1);
			
			var newComparator:IComparator = new PriorityComparator();
			sortedMap.comparator = newComparator;
			
			var index:int = sortedMap.indexOfKey(priorityObject3);
			Assert.assertEquals(0, index);
		}
		
		////////////////////////////////////
		// SortedArrayListMap().options TESTS //
		////////////////////////////////////
		
		[Test]
		public function options_createMapWithOptions_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedMap:ISortedMap = new SortedArrayListMap(null, null, options);
			
			Assert.assertEquals(options, newSortedMap.options);
		}
		
		[Test]
		public function options_createMapWithOptionsButChangesIt_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedMap:ISortedMap = new SortedArrayListMap(null, null, options);
			
			var options2:uint = Array.NUMERIC;
			newSortedMap.options = options2;
			
			Assert.assertEquals(options2, newSortedMap.options);
		}
		
		[Test]
		public function options_changeOptionsAndCallIndexOfKeyToCheckIfMapWasReorderedAndCorrectKeyReturned_ReturnTrue(): void
		{
			sortedMap.put("element-1", 1);
			sortedMap.put("element-2", 2);
			sortedMap.options = Array.DESCENDING;
			
			var index:int = sortedMap.indexOfKey("element-2");
			Assert.assertEquals(0, index);
		}
		
		////////////////////////////////////
		// SortedArrayListMap().clone() TESTS //
		////////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsHashMap_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(SortedArrayListMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		/////////////////////////////////////
		// SortedArrayListMap().equals() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyMapsCreatedWithDifferentSortOptions_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			sortedMap.options = 0;//ASCENDING
			
			var sortedMap2:ISortedList = new SortedArrayList();
			sortedMap2.options = Array.DESCENDING;
			
			var equal:Boolean = sortedMap.equals(sortedMap2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			sortedMap.put("element-1", 1);
			sortedMap.put("element-2", 2);
			
			var sortedMap2:IMap = getMap();
			sortedMap2.put("element-2", 2);
			sortedMap2.put("element-1", 1);
			
			var equal:Boolean = sortedMap.equals(sortedMap2);
			Assert.assertTrue(equal);
		}
		
		/////////////////////////////////////////
		// SortedArrayListMap().indexOfKey() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function indexOfKey_mapWithIntegerKeys_numericAscendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			sortedMap.options = Array.NUMERIC;
			
			sortedMap.put(5, "element-5");
			sortedMap.put(9, "element-9");
			sortedMap.put(7, "element-7");
			
			var index:int = sortedMap.indexOfKey(7);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOfKey_mapWithIntegerKeys_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			sortedMap.options = Array.NUMERIC | Array.DESCENDING;
			
			sortedMap.put(5, "element-5");
			sortedMap.put(9, "element-9");
			sortedMap.put(7, "element-7");
			
			var index:int = sortedMap.indexOfKey(9);
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////////////
		// SortedArrayListMap().indexOfValue() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function indexOfValue_mapWithIntegerValues_numericAscendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			sortedMap.options = Array.NUMERIC;
			sortedMap.sortBy = SortMapBy.VALUE;
			
			sortedMap.put("element-5", 5);
			sortedMap.put("element-9", 9);
			sortedMap.put("element-7", 7);
			
			var index:int = sortedMap.indexOfValue(7);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOfValue_mapWithIntegerValues_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			sortedMap.options = Array.NUMERIC | Array.DESCENDING;
			sortedMap.sortBy = SortMapBy.VALUE;
			
			sortedMap.put("element-5", 5);
			sortedMap.put("element-9", 9);
			sortedMap.put("element-7", 7);
			
			var index:int = sortedMap.indexOfValue(9);
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////
		// SortedArrayListMap().sort() TESTS //
		///////////////////////////////////
		
		[Test]
		public function sort_mapWithThreeStringKeys_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			sortedMap.put("Element-1", 1);
			sortedMap.put("element-3", 3);
			sortedMap.put("element-1", 1);
			
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.LOWER_CASE_FIRST);
			sortedMap.sort(comparator.compare);
			
			var index:int = sortedMap.indexOfKey("element-1");
			Assert.assertEquals(0, index);
		}
		
		/////////////////////////////////////
		// SortedArrayListMap().sortOn() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function sortOn_mapWithKeyObjectsWithProperty_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			sortedMap.put(obj1, 1);
			sortedMap.put(obj2, 2);
			sortedMap.put(obj3, 3);
			sortedMap.sortOn("age", Array.NUMERIC);
			
			var index:int = sortedMap.indexOfKey(obj2);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function sortOn_mapWithValueObjectsWithProperty_checkIfValueIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			sortedMap.sortBy = SortMapBy.VALUE;
			
			sortedMap.put(1, obj1);
			sortedMap.put(2, obj2);
			sortedMap.put(3, obj3);
			sortedMap.sortOn("age", Array.NUMERIC);
			
			var index:int = sortedMap.indexOfValue(obj2);
			Assert.assertEquals(0, index);
		}
		
		
		
	}

}