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
	import org.as3collections.IMap;
	import org.as3collections.ISortedMap;
	import org.as3collections.SortMapBy;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedSortedMapTests extends TypedMapTests
	{
		public function get typedSortedMap():TypedSortedMap { return map as TypedSortedMap; }
		
		public function TypedSortedMapTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getMap(typeKeys:Class, typeValues:Class):TypedMap
		{
			// using a SortedArrayMap object
			// instead of a fake to simplify tests
			// since SortedArrayMap is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in SortedArrayMap may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the SortedArrayMap object
			return new TypedSortedMap(new SortedArrayMap(), typeKeys, typeValues);
		}
		
		////////////////////////////////////
		// TypedSortedMap().clone() TESTS //
		////////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsTypedSortedMap_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedSortedMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableKeyValue_checkIfTypeOfReturnedMapIsTypedSortedMap_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var clonedMap:IMap = map.clone();
			
			var isTypedSortedMap:Boolean = ReflectionUtil.classPathEquals(TypedSortedMap, clonedMap);
			Assert.assertTrue(isTypedSortedMap);
		}
		
		/////////////////////////////////////
		// SortedArrayMap().equals() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyMapsCreatedWithDifferentSortOptions_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			typedSortedMap.options = 0;//ASCENDING
			
			var sortedMap2:TypedSortedMap = getMap(String, int) as TypedSortedMap;
			sortedMap2.options = Array.DESCENDING;
			
			var equal:Boolean = typedSortedMap.equals(sortedMap2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			typedSortedMap.put("element-1", 1);
			typedSortedMap.put("element-2", 2);
			
			var sortedMap2:IMap = getMap(String, int);
			sortedMap2.put("element-2", 2);
			sortedMap2.put("element-1", 1);
			
			var equal:Boolean = typedSortedMap.equals(sortedMap2);
			Assert.assertTrue(equal);
		}
		
		//////////////////////////////////////
		// TypedSortedMap().headMap() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function headMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			typedSortedMap.put("element-5", 5);
			typedSortedMap.put("element-9", 9);
			typedSortedMap.put("element-7", 7);
			
			var headMap:IMap = typedSortedMap.headMap("element-9");
			
			var equalHeadMap:IMap = getMap(String, int);
			equalHeadMap.put("element-7", 7);
			equalHeadMap.put("element-5", 5);
			
			var equal:Boolean = headMap.equals(equalHeadMap);
			Assert.assertTrue(equal);
		}
		
		/////////////////////////////////////////
		// TypedSortedMap().indexOfKey() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function indexOfKey_mapWithIntegerKeys_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var newMap:ISortedMap = getMap(int, String) as ISortedMap;
			newMap.options = Array.NUMERIC | Array.DESCENDING;
			newMap.put(5, "element-5");
			newMap.put(9, "element-9");
			newMap.put(7, "element-7");
			
			var index:int = newMap.indexOfKey(9);
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////////////
		// TypedSortedMap().indexOfValue() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function indexOfValue_mapWithIntegerValues_numericDescendingOrder_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			typedSortedMap.options = Array.NUMERIC | Array.DESCENDING;
			typedSortedMap.sortBy = SortMapBy.VALUE;
			
			typedSortedMap.put("element-5", 5);
			typedSortedMap.put("element-9", 9);
			typedSortedMap.put("element-7", 7);
			
			var index:int = typedSortedMap.indexOfValue(9);
			Assert.assertEquals(0, index);
		}
		
		///////////////////////////////////
		// SortedArrayMap().sort() TESTS //
		///////////////////////////////////
		
		[Test]
		public function sort_mapWithThreeStringKeys_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			typedSortedMap.put("Element-1", 1);
			typedSortedMap.put("element-3", 3);
			typedSortedMap.put("element-1", 1);
			
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.LOWER_CASE_FIRST);
			typedSortedMap.sort(comparator.compare);
			
			var index:int = typedSortedMap.indexOfKey("element-1");
			Assert.assertEquals(0, index);
		}
		
		/////////////////////////////////////
		// TypedSortedMap().sortOn() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function sortOn_mapWithKeyObjectsWithProperty_checkIfKeyIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			var newMap:ISortedMap = getMap(Object, int) as ISortedMap;
			newMap.put(obj1, 1);
			newMap.put(obj2, 2);
			newMap.put(obj3, 3);
			newMap.sortOn("age", Array.NUMERIC);
			
			var index:int = newMap.indexOfKey(obj2);
			Assert.assertEquals(0, index);
		}
		
		//////////////////////////////////////
		// TypedSortedMap().tailMap() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function tailMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			typedSortedMap.put("element-5", 5);
			typedSortedMap.put("element-9", 9);
			typedSortedMap.put("element-7", 7);
			
			var tailMap:IMap = typedSortedMap.tailMap("element-7");
			
			var equalTailMap:IMap = getMap(String, int);
			equalTailMap.put("element-9", 9);
			equalTailMap.put("element-7", 7);
			
			var equal:Boolean = tailMap.equals(equalTailMap);
			Assert.assertTrue(equal);
		}
		
	}

}