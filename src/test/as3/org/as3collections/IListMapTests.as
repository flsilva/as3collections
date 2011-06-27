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

package org.as3collections
{
	import org.as3collections.lists.ArrayList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IListMapTests extends IMapTests
	{
		public function get listMap():IListMap { return map as IListMap; }
		
		public function IListMapTests()
		{
			
		}
		
		//////////////////////////////
		// IListMap().clone() TESTS //
		//////////////////////////////
		
		[Test]
		public function clone_mapWithTwoNotEquatableEntries_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			var clonedMap:IListMap = listMap.clone();
			Assert.assertTrue(listMap.equals(clonedMap));
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableEntries_cloneButChangeEntriesOrder_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			var clonedMap:IListMap = listMap.clone();
			clonedMap.reverse();
			
			Assert.assertFalse(listMap.equals(clonedMap));
		}
		
		/////////////////////////////////
		// IListMap().getKeyAt() TESTS //
		/////////////////////////////////
		
		[Test]
		public function getKeyAt_addedOneNotEquatableEntry_getKeyAtIndexZero_checkIfReturnedKeyMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			
			var key:String = listMap.getKeyAt(0);
			Assert.assertEquals("element-1", key);
		}
		
		[Test]
		public function getKeyAt_addedThreeNotEquatableEntries_boundaryCondition_checkIfReturnedKeyMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var key:String = listMap.getKeyAt(2);
			Assert.assertEquals("element-3", key);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getKeyAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.getKeyAt(1);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getKeyAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.getKeyAt(3);
		}
		
		///////////////////////////////////
		// IListMap().getValueAt() TESTS //
		///////////////////////////////////
		
		[Test]
		public function getValueAt_addedOneNotEquatableEntry_getKeyAtIndexZero_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			
			var value:int = listMap.getValueAt(0);
			Assert.assertEquals(1, value);
		}
		
		[Test]
		public function getValueAt_addedThreeNotEquatableEntries_boundaryCondition_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var value:int = listMap.getValueAt(2);
			Assert.assertEquals(3, value);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getValueAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.getValueAt(1);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function getValueAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.getValueAt(3);
		}
		
		////////////////////////////////
		// IListMap().headMap() TESTS //
		////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function headMap_mapWithThreeKeyValue_notContainedKey_ThrowsError(): void
		{
			listMap.put("element-5", 5);
			listMap.put("element-7", 7);
			listMap.put("element-9", 9);
			
			listMap.headMap("element-11");
		}
		
		[Test]
		public function headMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-5", 5);
			listMap.put("element-7", 7);
			listMap.put("element-9", 9);
			
			var headMap:IMap = listMap.headMap("element-9");
			
			var equalHeadMap:IMap = getMap();
			equalHeadMap.put("element-5", 5);
			equalHeadMap.put("element-7", 7);
			
			var equal:Boolean = headMap.equals(equalHeadMap);
			Assert.assertTrue(equal);
		}
		
		///////////////////////////////////
		// IListMap().indexOfKey() TESTS //
		///////////////////////////////////
		
		[Test]
		public function indexOfKey_mapWithTwoNotEquatableKeyValue_checkIfIndexOfFirstKeyIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			var index:int = listMap.indexOfKey("element-1");
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOfKey_listWithThreeNotEquatableElements_checkIfIndexOfSecondKeyIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var index:int = listMap.indexOfKey("element-2");
			Assert.assertEquals(1, index);
		}
		
		/////////////////////////////////////
		// IListMap().indexOfValue() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function indexOfValue_mapWithTwoNotEquatableKeyValue_checkIfIndexOfFirstValueIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			var index:int = listMap.indexOfValue(1);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOfValue_listWithThreeNotEquatableElements_checkIfIndexOfSecondValueIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var index:int = listMap.indexOfValue(2);
			Assert.assertEquals(1, index);
		}
		
		/////////////////////////////////////
		// IListMap().listIterator() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function listIterator_emptyList_ReturnValidIListIteratorObject(): void
		{
			var it:IListMapIterator = listMap.listMapIterator();
			Assert.assertNotNull(it);
		}
		
		/////////////////////////////////
		// IListMap().modCount() TESTS //
		/////////////////////////////////
		
		[Test]
		public function modCount_freshMap_ReturnsZero(): void
		{
			var modCount:int = listMap.modCount;
			Assert.assertEquals(0, modCount);
		}
		
		[Test]
		public function modCount_addOneNotEquatableEntry_ReturnsOne(): void
		{
			listMap.put("element-1", 1);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(1, modCount);
		}
		
		[Test]
		public function modCount_addTwoNotEquatableEntry_ReturnsTwo(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_putAll_argumentWithThreeNotEquatableEntries_ReturnsThree(): void
		{
			var addAllMap:IMap = getMap();
			addAllMap.put("element-1", 1);
			addAllMap.put("element-2", 2);
			addAllMap.put("element-3", 3);
			
			listMap.putAll(addAllMap);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(3, modCount);
		}
		
		[Test]
		public function modCount_clearEmptyMap_ReturnsZero(): void
		{
			listMap.clear();
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(0, modCount);
		}
		
		[Test]
		public function modCount_addTwoNotEquatableEntriesThenClear_ReturnsThree(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.clear();
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(3, modCount);
		}
		
		[Test]
		public function modCount_addOneNotEquatableEntryThenRemoveIt_ReturnsTwo(): void
		{
			listMap.put("element-1", 1);
			listMap.remove("element-1");
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_removeAll_addThreeNotEquatableElementsThenRemoveAllWithTwoElements_ReturnsFive(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var removeAllCollection:ICollection = new ArrayList();
			removeAllCollection.add("element-2");
			removeAllCollection.add("element-3");
			
			listMap.removeAll(removeAllCollection);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(5, modCount);
		}
		
		[Test]
		public function modCount_removeAt_addOneNotEquatableEntryThenRemoveIt_ReturnsTwo(): void
		{
			listMap.put("element-1", 1);
			listMap.removeAt(0);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(2, modCount);
		}
		
		[Test]
		public function modCount_removeRange_addThreeNotEquatableElementsThenRemoveRangeWithTwoElements_ReturnsFour(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.removeRange(1, 3);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(5, modCount);
		}
		
		[Test]
		public function modCount_retainAll_addThreeNotEquatableElementsThenRetainAllWithTwoElements_ReturnsFour(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var retainAllCollection:ICollection = new ArrayList();
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			
			listMap.retainAll(retainAllCollection);
			
			var modCount:int = listMap.modCount;
			Assert.assertEquals(4, modCount);
		}
		
		/////////////////////////////////
		// IListMap().putAllAt() TESTS //
		/////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function putAllAt_invalidArgument_ThrowsError(): void
		{
			listMap.putAllAt(0, null);
		}
		
		[Test]
		public function putAllAt_validEmptyArgument_Void(): void
		{
			var addMap:IMap = getMap();
			
			listMap.putAllAt(0, addMap);
		}
		
		[Test]
		public function putAllAt_emptyMap_validMapNoneKeyValueEquatable_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var addMap:IMap = getMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			listMap.putAllAt(0, addMap);
			
			var size:int = listMap.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function putAllAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfKeyIsAtCorrectIndex_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var addMap:IMap = getMap();
			addMap.put("element-4", 4);
			addMap.put("element-5", 5);
			
			listMap.putAllAt(3, addMap);
			
			var key:String = listMap.getKeyAt(4);
			Assert.assertEquals("element-5", key);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function putAllAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			var addMap:IMap = getMap();
			addMap.put("element-4", 4);
			
			listMap.putAllAt(1, addMap);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function putAllAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var addMap:IMap = getMap();
			addMap.put("element-4", 4);
			
			listMap.putAllAt(4, addMap);
		}
		
		//////////////////////////////
		// IListMap().putAt() TESTS //
		//////////////////////////////
		
		[Test]
		public function putAt_emptyMap_validArgumentNotEquatableAndZeroIndex_Void(): void
		{
			listMap.putAt(0, "element-1", 1);
		}
		
		[Test]
		public function putAt_mapWithThreeNotEquatableEntries_validArgumentNotEquatableAndIndexThree_boundaryCondition_checkIfKeyIsAtCorrectIndex_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.putAt(3, "element-4", 4);
			
			var key:String = listMap.getKeyAt(3);
			Assert.assertEquals("element-4", key);
		}
		
		[Test]
		public function putAt_mapWithThreeNotEquatableEntries_validArgumentNotEquatableAndIndexOne_checkIfValueIsAtCorrectIndex_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-3", 3);
			listMap.put("element-4", 4);
			
			listMap.putAt(1, "element-2", 2);
			
			var key:String = listMap.getKeyAt(1);
			Assert.assertEquals("element-2", key);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function putAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.putAt(1, "element-1", 1);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function putAt_notEmptyList_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.putAt(4, "element-4", 4);
		}
		
		[Test(expects="ArgumentError")]
		public function putAt_notEmptyList_duplicateKey_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.putAt(3, "element-2", 4);
		}
		
		/////////////////////////////////
		// IListMap().removeAt() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_emptyMap_ThrowsError(): void
		{
			listMap.removeAt(0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.removeAt(2);
		}
		
		[Test]
		public function removeAt_mapWithOneNotEquatabeEntry_removeAtIndexZero_ReturnsCorrectMapEntry(): void
		{
			listMap.put("element-1", 1);
			
			var addedEntry:IMapEntry = new MapEntry("element-1", 1);
			var removedEntry:IMapEntry = listMap.removeAt(0);
			
			var equal:Boolean = addedEntry.equals(removedEntry);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function removeAt_mapWithThreeNotEquatabeEntries_boundaryCondition_ReturnsCorrectMapEntry(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var addedEntry:IMapEntry = new MapEntry("element-3", 3);
			var removedEntry:IMapEntry = listMap.removeAt(2);
			
			var equal:Boolean = addedEntry.equals(removedEntry);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function removeAt_mapWithThreeNotEquatabeEntries_checkIfMapContainsRemovedKey_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var removedEntry:IMapEntry = listMap.removeAt(2);
			
			var contains:Boolean = listMap.containsKey(removedEntry.key);
			Assert.assertFalse(contains);
		}
		
		////////////////////////////////////
		// IListMap().removeRange() TESTS //
		////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function removeRange_emptyMap_ThrowsError(): void
		{
			listMap.removeRange(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeRange_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.removeRange(0, 3);
		}
		
		[Test]
		public function removeRange_mapWithOneNotEquatabeElement_ReturnsValidMap(): void
		{
			listMap.put("element-1", 1);
			
			var removedMap:IListMap = listMap.removeRange(0, 1);
			Assert.assertNotNull(removedMap);
		}
		
		[Test]
		public function removeRange_mapWithOneNotEquatabeElement_removeRangeAndCheckIfMapIsEmpty_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.removeRange(0, 1);
			
			var isEmpty:Boolean = listMap.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeRange_mapWithTwoNotEquatabeElement_removeRangeAndCheckIfListSizeIsZero_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.removeRange(0, 2);
			
			var size:int = listMap.size();
			Assert.assertEquals(0, size);
		}
		
		////////////////////////////////
		// IListMap().reverse() TESTS //
		////////////////////////////////
		
		[Test]
		public function reverse_emptyMap_Void(): void
		{
			listMap.reverse();
		}
		
		[Test]
		public function reverse_mapWithTwoNotEquatableEntries_checkIfFirstKeyNowIsTheSecond_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			
			listMap.reverse();
			
			var key:String = listMap.getKeyAt(1);
			Assert.assertEquals("element-1", key);
		}
		
		[Test]
		public function reverse_mapWithFiveNotEquatableEntries_checkIfFourthValueNowIsTheSecond_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			listMap.put("element-4", 4);
			listMap.put("element-5", 5);
			
			listMap.reverse();
			
			var value:int = listMap.getValueAt(1);
			Assert.assertEquals(4, value);
		}
		
		////////////////////////////////
		// IListMap().setKeyAt() TESTS //
		////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setKeyAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.setKeyAt(0, "element-1");
		}
		
		[Test]
		public function setKeyAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsAddedKey_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setKeyAt(2, "element-4");
			
			var contains:Boolean = listMap.containsKey("element-4");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function setKeyAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsReplacedKey_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setKeyAt(2, "element-4");
			
			var contains:Boolean = listMap.containsKey("element-3");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function setKeyAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfReturnedCorrectKey_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var removedKey:String = listMap.setKeyAt(1, "element-4");
			Assert.assertTrue("element-2", removedKey);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setKeyAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setKeyAt(3, "element-4");
		}
		
		[Test(expects="ArgumentError")]
		public function setKeyAt_notEmptyMap_duplicateKey_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setKeyAt(0, "element-2");
		}
		
		///////////////////////////////////
		// IListMap().setValueAt() TESTS //
		///////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setValueAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.setValueAt(0, "element-1");
		}
		
		[Test]
		public function setValueAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsAddedValue_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setValueAt(2, 4);
			
			var contains:Boolean = listMap.containsValue(4);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function setValueAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsReplacedValue_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setValueAt(2, 4);
			
			var contains:Boolean = listMap.containsKey(3);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function setValueAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfReturnedCorrectValue_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var removedValue:int = listMap.setValueAt(1, 4);
			Assert.assertTrue(2, removedValue);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setValueAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.setValueAt(3, 4);
		}
		
		///////////////////////////////
		// IListMap().subMap() TESTS //
		///////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function subMap_emptyMap_ThrowsError(): void
		{
			listMap.subMap(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subMap_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			listMap.subMap(0, 4);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfReturnedMapSizeMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 2);
			
			var size:int = subMap.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function subMap_notEmptyMap_boundaryCondition_checkIfReturnedMapSizeMatches_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 3);
			
			var size:int = subMap.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfSubMapContainsKey_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 2);
			
			var contains:Boolean = subMap.containsKey("element-2");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfSubMapContainsKey_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 2);
			
			var contains:Boolean = subMap.containsKey("element-3");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfSubMapContainsValue_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 2);
			
			var contains:Boolean = subMap.containsValue(2);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfSubMapContainsValue_ReturnsFalse(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(0, 2);
			
			var contains:Boolean = subMap.containsValue(3);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-1", 1);
			listMap.put("element-2", 2);
			listMap.put("element-3", 3);
			
			var subMap:IMap = listMap.subMap(1, 3);
			
			var equalMap:IMap = getMap();
			equalMap.put("element-2", 2);
			equalMap.put("element-3", 3);
			
			var equal:Boolean = subMap.equals(equalMap);
			Assert.assertTrue(equal);
		}
		
		////////////////////////////////
		// IListMap().tailMap() TESTS //
		////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function tailMap_mapWithThreeKeyValue_notContainedKey_ThrowsError(): void
		{
			listMap.put("element-5", 5);
			listMap.put("element-7", 7);
			listMap.put("element-9", 9);
			
			listMap.tailMap("element-11");
		}
		
		[Test]
		public function tailMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			listMap.put("element-5", 5);
			listMap.put("element-7", 7);
			listMap.put("element-9", 9);
			
			var tailMap:IMap = listMap.tailMap("element-7");
			
			var equalTailMap:IMap = getMap();
			equalTailMap.put("element-7", 7);
			equalTailMap.put("element-9", 9);
			
			var equal:Boolean = tailMap.equals(equalTailMap);
			Assert.assertTrue(equal);
		}
		
	}

}