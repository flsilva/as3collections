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
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IMapTests
	{
		public var map:IMap;
		
		public function IMapTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			map = getMap();
		}
		
		[After]
		public function tearDown(): void
		{
			map = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getMap():IMap
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		////////////////////////////////////////
		// IMap().allKeysEquatable() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function allKeysEquatable_emptyMap_ReturnsTrue(): void
		{
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_notEmptyMap_notContainAnyEquatableKey_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertFalse(allKeysEquatable);
		}
		
		///////////////////////////////////////
		// IMap().allValuesEquatable() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function allValuesEquatable_emptyMap_ReturnsTrue(): void
		{
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_notEmptyMap_notContainAnyEquatableValue_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertFalse(allValuesEquatable);
		}
		
		//////////////////////////
		// IMap().clear() TESTS //
		//////////////////////////
		
		[Test]
		public function clear_emptyMap_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			map.clear();
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function clear_mapWithOneNotEquatableKeyValue_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.clear();
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		//////////////////////////
		// IMap().clone() TESTS //
		//////////////////////////
		
		[Test]
		public function clone_emptyMap_ReturnValidCollectionObject(): void
		{
			var clonedMap:IMap = map.clone();
			Assert.assertNotNull(clonedMap);
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableKeyValue_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var clonedMap:IMap = map.clone();
			Assert.assertTrue(map.equals(clonedMap));
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableKeyValue_cloneButChangeMap_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var clonedMap:IMap = map.clone();
			
			clonedMap.remove("element-2");
			Assert.assertFalse(map.equals(clonedMap));
		}
		
		////////////////////////////////
		// IMap().containsKey() TESTS //
		////////////////////////////////
		
		[Test]
		public function containsKey_emptyMap_ReturnsFalse(): void
		{
			var contains:Boolean = map.containsKey("element-1");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsKey_mapWithOneNotEquatableKeyValue_notContainsNotEquatableKey_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsKey("element-2");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsKey_mapWithOneNotEquatableKeyValue_containsKey_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsKey("element-1");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsKey_mapWithTwoNotEquatableKeyValue_containsKey_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var contains:Boolean = map.containsKey("element-2");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsKey_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_removeKeyAndCheckIfMapContainsIt_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			map.remove("element-1");
			
			var contains:Boolean = map.containsKey("element-1");
			Assert.assertFalse(contains);
		}
		
		//////////////////////////////////
		// IMap().containsValue() TESTS //
		//////////////////////////////////
		
		[Test]
		public function containsValue_emptyMap_ReturnsFalse(): void
		{
			var contains:Boolean = map.containsValue(1);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_mapWithOneNotEquatableKeyValue_notContainsNotEquatableValue_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_mapWithOneNotEquatableKeyValue_containsValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsValue(1);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_mapWithTwoNotEquatableKeyValue_containsValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_mapWithTwoNotEquatableKeyValue_theValuesAreEqual_removeOneKeyAndCheckIfMapContainsAnotherSameValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 1);
			map.remove("element-1");
			
			var contains:Boolean = map.containsValue(1);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_checkIfContainsLastAddedValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_checkIfContainsFirstAddedValue_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			
			var contains:Boolean = map.containsValue(1);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_removeKeyAndCheckIfMapContainsItsValue_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			map.remove("element-1");
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertFalse(contains);
		}
		
		//////////////////////////////
		// IMap().entryList() TESTS //
		//////////////////////////////
		
		[Test]
		public function entryList_emptyMap_ReturnsValidIListObject(): void
		{
			var entries:IList = map.entryList();
			Assert.assertNotNull(entries);
		}
		
		[Test]
		public function entryList_mapWithTwoNotEquatableKeyValue_ReturnsListObject(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var entries:IList = map.entryList();
			Assert.assertNotNull(entries);
		}
		
		[Test]
		public function entryList_mapWithTwoNotEquatableElements_checkIfReturnedListSizeIsTwo_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var entries:IList = map.entryList();
			
			var size:int = entries.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////
		// IMap().equals() TESTS //
		///////////////////////////
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_differentMaps_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap();
			map2.put("element-2", 2);
			
			Assert.assertFalse(map.equals(map2));
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_equalMaps_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap();
			map2.put("element-1", 1);
			map2.put("element-2", 2);
			
			Assert.assertTrue(map.equals(map2));
		}
		
		////////////////////////////
		// IMap().getKeys() TESTS //
		////////////////////////////
		
		[Test]
		public function getKeys_emptyMap_ReturnsValidIListObject(): void
		{
			var keys:IList = map.getKeys();
			Assert.assertNotNull(keys);
		}
		
		[Test]
		public function getKeys_mapWithTwoNotEquatableKeyValue_ReturnsListObject(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var keys:IList = map.getKeys();
			Assert.assertNotNull(keys);
		}
		
		[Test]
		public function getKeys_mapWithTwoNotEquatableElements_checkIfReturnedListSizeIsTwo_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var keys:IList = map.getKeys();
			
			var size:int = keys.size();
			Assert.assertEquals(2, size);
		}
		
		/////////////////////////////
		// IMap().getValue() TESTS //
		/////////////////////////////
		
		[Test]
		public function getValue_mapWithOneNotEquatableKeyValue_containedKey_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var value:int = map.getValue("element-1");
			Assert.assertEquals(1, value);
		}
		
		[Test]
		public function getValue_mapWithThreeNotEquatableKeyValue_containedKey_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var value:int = map.getValue("element-3");
			Assert.assertEquals(3, value);
		}
		
		[Test]
		public function getValue_emptyMap_notContainedKey_ReturnsNull(): void
		{
			var value:* = map.getValue("element-1");
			Assert.assertNull(value);
		}
		
		[Test]
		public function getValue_notEmptyMap_notContainedNotEquatableKey_ReturnsNull(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var value:* = map.getValue("element-3");
			Assert.assertNull(value);
		}
		
		//////////////////////////////
		// IMap().getValues() TESTS //
		//////////////////////////////
		
		[Test]
		public function getValues_emptyMap_ReturnsValidIListObject(): void
		{
			var values:IList = map.getValues();
			Assert.assertNotNull(values);
		}
		
		[Test]
		public function getValues_mapWithTwoNotEquatableKeyValue_ReturnsListObject(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var values:IList = map.getValues();
			Assert.assertNotNull(values);
		}
		
		[Test]
		public function getValues_mapWithTwoNotEquatableElements_checkIfReturnedListSizeIsTwo_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var keys:IList = map.getValues();
			
			var values:int = keys.size();
			Assert.assertEquals(2, values);
		}
		
		////////////////////////////
		// IMap().isEmpty() TESTS //
		////////////////////////////
		
		[Test]
		public function isEmpty_emptyMap_ReturnsTrue(): void
		{
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function isEmpty_mapWithOneNotEquatableKeyValue_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		/////////////////////////////
		// IMap().iterator() TESTS //
		/////////////////////////////
		
		[Test]
		public function iterator_emptyMap_ReturnValidIIteratorObject(): void
		{
			var it:IIterator = map.iterator();
			Assert.assertNotNull(it);
		}
		
		////////////////////////
		// IMap().put() TESTS //
		////////////////////////
		
		[Test]
		public function put_validKeyAndValueNotEquatables_ReturnsNull(): void
		{
			var oldValue:* = map.put("element-1", 1);
			Assert.assertNull(oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueNotEquatables_keyAlreadyAdded_ReturnsOldValue(): void
		{
			map.put("element-1", 1);
			
			var oldValue:* = map.put("element-1", 1);
			Assert.assertNotNull(oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueNotEquatables_keyAlreadyAdded_checkIfReturnedCorrectOldValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var oldValue:* = map.put("element-1", 2);
			Assert.assertEquals(1, oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueNotEquatables_keyAlreadyAdded_removeKeyAndCheckIfMapSizeIsZero_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			map.remove("element-1");
			
			var size:int = map.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function put_validKeyAndValueNotEquatables_keyAlreadyAdded_checkIfSizeIsOne_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-1", 2);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function put_putNotEquatableKeyValue_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////
		// IMap().putAll() TESTS //
		///////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function putAll_invalidArgument_ThrowsError(): void
		{
			map.putAll(null);
		}
		
		[Test]
		public function putAll_validEmptyArgument_Void(): void
		{
			var putAllMap:IMap = getMap();
			map.putAll(putAllMap);
		}
		
		[Test]
		public function putAll_validArgumentWithNoneKeyAndValueEquatable_checkIfContainsOneAddedKey_ReturnsTrue(): void
		{
			var putAllMap:IMap = getMap();
			putAllMap.put("element-1", 1);
			putAllMap.put("element-2", 2);
			
			map.putAll(putAllMap);
			
			var containsKey:Boolean = map.containsKey("element-2");
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function putAll_argumentWithTwoNotEquatableKeyValue_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var putAllMap:IMap = getMap();
			putAllMap.put("element-1", 1);
			putAllMap.put("element-2", 2);
			
			map.putAll(putAllMap);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function putAll_validArgumentWithTwoNotEquatableKeyValue_checkIfMapSizeIsTwo_ReturnsTrue(): void
		{
			var putAllMap:IMap = getMap();
			putAllMap.put("element-1", 1);
			putAllMap.put("element-2", 2);
			
			map.putAll(putAllMap);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////////
		// IMap().putAllByObject() TESTS //
		///////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function putAllByObject_invalidArgument_ThrowsError(): void
		{
			map.putAllByObject(null);
		}
		
		[Test]
		public function putAllByObject_validEmptyArgument_Void(): void
		{
			var putAllObject:Object = {};
			map.putAllByObject(putAllObject);
		}
		
		[Test]
		public function putAllByObject_validArgumentWithNoneKeyAndValueEquatable_checkIfContainsOneAddedKey_ReturnsTrue(): void
		{
			var putAllObject:Object = {};
			putAllObject["element-1"] = 1;
			putAllObject["element-2"] = 2;
			
			map.putAllByObject(putAllObject);
			
			var containsKey:Boolean = map.containsKey("element-2");
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function putAllByObject_argumentWithTwoNotEquatableKeyValue_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var putAllObject:Object = {};
			putAllObject["element-1"] = 1;
			putAllObject["element-2"] = 2;
			
			map.putAllByObject(putAllObject);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function putAllByObject_validArgumentWithTwoNotEquatableKeyValue_checkIfMapSizeIsTwo_ReturnsTrue(): void
		{
			var putAllObject:Object = {};
			putAllObject["element-1"] = 1;
			putAllObject["element-2"] = 2;
			
			map.putAllByObject(putAllObject);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		/////////////////////////////
		// IMap().putEntry() TESTS //
		/////////////////////////////
		
		[Test]
		public function putEntry_validEntryOfNotEquatableKeyValue_ReturnsNull(): void
		{
			var oldKey:* = map.putEntry(new MapEntry("element-1", 1));
			Assert.assertNull(oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfNotEquatableKeyValue_keyAlreadyAdded_ReturnsOldValue(): void
		{
			map.put("element-1", 1);
			
			var oldKey:* = map.putEntry(new MapEntry("element-1", 1));
			Assert.assertNotNull(oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfNotEquatableKeyValue_keyAlreadyAdded_checkIfReturnedCorrectOldValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var oldKey:* = map.putEntry(new MapEntry("element-1", 2));
			Assert.assertEquals(1, oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfNotEquatableKeyValue_keyAlreadyAdded_checkIfContainsNewValue_ReturnsTrue(): void
		{
			map.putEntry(new MapEntry("element-1", 1));
			map.putEntry(new MapEntry("element-1", 2));
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertTrue(contains);
		}
		
		///////////////////////////
		// IMap().remove() TESTS //
		///////////////////////////
		
		[Test]
		public function remove_emptyMap_ReturnsNull(): void
		{
			var removedValue:* = map.remove("element-1");
			Assert.assertNull(removedValue);
		}
		
		[Test]
		public function remove_mapWithThreeNotEquatableKeyValue_containsKeyToBeRemoved_ReturnsValue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var removedValue:* = map.remove("element-2");
			Assert.assertEquals(2, removedValue);
		}
		
		[Test]
		public function remove_mapWithTwoNotEquatableKeyValue_theValuesAreEqual_containsKeyToBeRemoved_ReturnsValue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 1);
			
			var removedValue:* = map.remove("element-2");
			Assert.assertEquals(1, removedValue);
		}
		
		[Test]
		public function remove_mapWithOneNotEquatableKeyValue_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.remove("element-1");
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function remove_mapWithTwoNotEquatableKeyValue_removeOneKey_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.remove("element-1");
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function remove_mapWithTwoNotEquatableKeyValue_removeOneKey_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.remove("element-1");
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		//////////////////////////////
		// IMap().removeAll() TESTS //
		//////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function removeAll_invalidArgument_ThrowsError(): void
		{
			map.removeAll(null);
		}
		
		[Test]
		public function removeAll_emptyArgument_ReturnsFalse(): void
		{
			var removeAllCollection:IList = new ArrayList();
			
			var changed:Boolean = map.removeAll(removeAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function removeAll_emptyMap_ReturnsFalse(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-1");
			
			var changed:Boolean = map.removeAll(removeAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function removeAll_mapWithTwoNotEquatableKeyValue_argumentWithThreeNotEquatableKeysOfWhichTwoAreContained_ReturnsTrue(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-1");
			removeAllCollection.add("element-2");
			removeAllCollection.add("element-3");
			
			map.put("element-1", 1);
			map.put("element-3", 3);
			
			var changed:Boolean = map.removeAll(removeAllCollection);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function removeAll_mapWithTwoNotEquatableKeyValue_argumentWithTheTwoKeys_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-1");
			removeAllCollection.add("element-2");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			map.removeAll(removeAllCollection);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeAll_mapWithTwoNotEquatableKeyValue_argumentWithTheTwoKeys_checkIfMapSizeIsZero_ReturnsTrue(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-1");
			removeAllCollection.add("element-2");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			map.removeAll(removeAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function removeAll_mapWithTwoNotEquatableKeyValue_argumentWithOneNotEquatableKey_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-2");
			
			map.put("element-1", 1);
			map.put("element-3", 3);
			
			map.removeAll(removeAllCollection);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function removeAll_mapWithTwoNotEquatableKeyValue_argumentWithOneNotEquatableKey_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-2");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			map.removeAll(removeAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		//////////////////////////////
		// IMap().retainAll() TESTS //
		//////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function retainAll_invalidArgument_ThrowsError(): void
		{
			map.retainAll(null);
		}
		
		[Test]
		public function retainAll_emptyArgument_ReturnsFalse(): void
		{
			var retainAllCollection:IList = new ArrayList();
			
			var changed:Boolean = map.retainAll(retainAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function retainAll_mapWithTwoNotEquatableKeyValue_argumentWithTheTwoMapElements_ReturnsFalse(): void
		{
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var changed:Boolean = map.retainAll(retainAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function retainAll_mapWithOneNotEquatableKeyValue_argumentWithTwoNotEquatableKeysOfWhichNoneIsContained_ReturnsTrue(): void
		{
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			
			map.put("element-3", 3);
			
			var changed:Boolean = map.retainAll(retainAllCollection);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function retainAll_mapWithFourNotEquatableKeyValue_argumentWithThreeContainedKeys_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			map.put("element-4", 4);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_mapWithThreeNotEquatableKeyValue_argumentWithFourKeysOfWhichThreeContained_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			retainAllCollection.add("element-4");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-4", 4);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_mapWithFourNotEquatableKeyValue_argumentWithFourKeysOfWhichThreeContained_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			retainAllCollection.add("element-4");
			
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-4", 4);
			map.put("element-8", 8);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
		/////////////////////////
		// IMap().size() TESTS //
		/////////////////////////
		
		[Test]
		public function size_emptyMap_ReturnsZero(): void
		{
			var size:int = map.size();
			Assert.assertFalse(size);
		}
		
	}

}