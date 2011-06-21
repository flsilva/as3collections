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
	public class IMapTestsEquatableObject
	{
		public var map:IMap;
		
		public function IMapTestsEquatableObject()
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
		public function allKeysEquatable_mapWithOneEquatableKey_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithThreeEquatableKeys_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			map.put(equatableObject3A, 3);
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithTwoEquatableKeysAndOneNotEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put("element-1", 1);
			map.put(equatableObject2A, 2);
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertFalse(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithThreeKeysOfWhichTwoEquatable_removeNotEquatableKey_checkIfAllKeysEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			map.put("element-1", 1);
			
			map.remove("element-1");
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithThreeKeysOfWhichTwoEquatable_removeThroughRetainAllNotEquatableKey_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			map.put("element-1", 1);
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			map.retainAll(retainAllCollection);
			
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		
		///////////////////////////////////////
		// IMap().allValuesEquatable() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function allValuesEquatable_mapWithOneEquatableValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put("equatable-object-1", equatableObject1A);
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithThreeEquatableValues_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject2A);
			map.put("equatable-object-3", equatableObject3A);
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithTwoEquatablValuesAndOneNotEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("element-1", 1);
			map.put("equatable-object-2", equatableObject2A);
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertFalse(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithThreeValuesOfWhichTwoEquatable_removeNotEquatableValue_checkIfAllValuesEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject2A);
			map.put("element-1", 1);
			
			map.remove("element-1");
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithThreeValuesOfWhichTwoEquatable_removeThroughRetainAllNotEquatableValue_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject2A);
			map.put("element-1", 1);
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			map.retainAll(retainAllCollection);
			
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		
		//////////////////////////
		// IMap().clone() TESTS //
		//////////////////////////
		
		[Test]
		public function clone_mapWithTwoEquatableKeys_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var clonedMap:IMap = map.clone();
			Assert.assertTrue(map.equals(clonedMap));
		}
		
		[Test]
		public function clone_mapWithTwoEquatableKeys_cloneButChangeMap_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var clonedMap:IMap = map.clone();
			
			clonedMap.remove(equatableObject2A);
			Assert.assertFalse(map.equals(clonedMap));
		}
		
		////////////////////////////////
		// IMap().containsKey() TESTS //
		////////////////////////////////
		
		[Test]
		public function containsKey_mapWithOneNotEquatableKeyValue_notContainsNotEquatableKey_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			
			var contains:Boolean = map.containsKey(equatableObject2A);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsKey_mapWithOneNotEquatableKeyValue_containsKey_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put(equatableObject1A, 1);
			
			var contains:Boolean = map.containsKey(equatableObject1B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsKey_mapWithTwoNotEquatableKeyValue_containsKey_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var contains:Boolean = map.containsKey(equatableObject2B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsKey_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_removeKeyAndCheckIfMapContainsIt_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject1B, 2);
			map.remove(equatableObject1C);
			
			var contains:Boolean = map.containsKey(equatableObject1B);
			Assert.assertFalse(contains);
		}
		
		//////////////////////////////////
		// IMap().containsValue() TESTS //
		//////////////////////////////////
		[Test]
		public function containsValue_mapWithOneNotEquatableKeyValue_notContainsNotEquatableValue_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			
			var contains:Boolean = map.containsValue(equatableObject2A);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_mapWithOneNotEquatableKeyValue_containsValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put("equatable-object-1", equatableObject1A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var contains:Boolean = map.containsValue(equatableObject1B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_mapWithTwoNotEquatableKeyValue_containsValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject2A);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var contains:Boolean = map.containsValue(equatableObject2B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_mapWithTwoNotEquatableKeyValue_theValuesAreEqual_removeOneKeyAndCheckIfMapContainsAnotherSameValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject1B);
			map.remove("equatable-object-1");
			
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			var contains:Boolean = map.containsValue(equatableObject1C);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_mapWithTwoNotEquatableKeyValue_theValuesAreEqual_removeTwoKeysAndCheckIfMapContainsValue_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-2", equatableObject1B);
			map.remove("equatable-object-1");
			map.remove("equatable-object-2");
			
			var contains:Boolean = map.containsValue(equatableObject1B);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_checkIfContainsLastAddedValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-1", equatableObject2A);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var contains:Boolean = map.containsValue(equatableObject2B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_checkIfContainsFirstAddedValue_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-1", equatableObject2A);
			
			var contains:Boolean = map.containsValue(equatableObject1A);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function containsValue_sameNotEquatableKeyWasAddedTwiceButWithDifferentNotEquatableValues_removeKeyAndCheckIfMapContainsItsValue_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put("equatable-object-1", equatableObject1A);
			map.put("equatable-object-1", equatableObject2A);
			map.remove("equatable-object-1");
			
			var contains:Boolean = map.containsValue(equatableObject2A);
			Assert.assertFalse(contains);
		}
		
		///////////////////////////
		// IMap().equals() TESTS //
		///////////////////////////
		
		[Test]
		public function equals_mapWithTwoEquatableKeys_differentMaps_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var map2:IMap = getMap();
			map2.put(equatableObject2B, 2);
			
			Assert.assertFalse(map.equals(map2));
		}
		
		[Test]
		public function equals_mapWithTwoEquatableKeys_equalMaps_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var map2:IMap = getMap();
			map2.put(equatableObject1B, 1);
			map2.put(equatableObject2B, 2);
			
			Assert.assertTrue(map.equals(map2));
		}
		
		
		/////////////////////////////
		// IMap().getValue() TESTS //
		/////////////////////////////
		
		[Test]
		public function getValue_mapWithOneEquatableKey_containedKey_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var value:int = map.getValue(equatableObject1B);
			Assert.assertEquals(1, value);
		}
		
		[Test]
		public function getValue_mapWithThreeNotEquatableKeyValue_containedKey_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			map.put(equatableObject3A, 3);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var value:int = map.getValue(equatableObject3B);
			Assert.assertEquals(3, value);
		}
		
		[Test]
		public function getValue_emptyMap_notContainedKey_ReturnsNull(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var value:* = map.getValue(equatableObject1A);
			Assert.assertNull(value);
		}
		
		[Test]
		public function getValue_notEmptyMap_notContainedNotEquatableKey_ReturnsNull(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var value:* = map.getValue(equatableObject3A);
			Assert.assertNull(value);
		}
		
		////////////////////////
		// IMap().put() TESTS //
		////////////////////////
		
		[Test]
		public function put_validKeyAndValueEquatable_ReturnsNull(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldValue:* = map.put(equatableObject1A, 1);
			Assert.assertNull(oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueEquatable_keyAlreadyAdded_ReturnsOldValue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldValue:* = map.put(equatableObject1B, 1);
			Assert.assertNotNull(oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueEquatable_keyAlreadyAdded_checkIfReturnedCorrectOldValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldValue:* = map.put(equatableObject1B, 2);
			Assert.assertEquals(1, oldValue);
		}
		
		[Test]
		public function put_validKeyAndValueEquatable_keyAlreadyAdded_removeKeyAndCheckIfMapSizeIsZero_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject1B, 2);
			map.remove(equatableObject1C);
			
			var size:int = map.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function put_validKeyAndValueEquatable_keyAlreadyAdded_checkIfSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject1B, 2);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function put_putEquatableKeyValue_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////
		// IMap().putAll() TESTS //
		///////////////////////////
		
		[Test]
		public function putAll_validArgumentWithTwoKeysEquatables_checkIfContainsOneAddedKey_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllMap:IMap = getMap();
			putAllMap.put(equatableObject1A, 1);
			putAllMap.put(equatableObject2A, 2);
			
			map.putAll(putAllMap);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var containsKey:Boolean = map.containsKey(equatableObject2B);
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function putAll_argumentWithTwoEquatableKeys_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllMap:IMap = getMap();
			putAllMap.put(equatableObject1A, 1);
			putAllMap.put(equatableObject2A, 2);
			
			map.putAll(putAllMap);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function putAll_validArgumentWithTwoEquatableKeys_checkIfMapSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllMap:IMap = getMap();
			putAllMap.put(equatableObject1A, 1);
			putAllMap.put(equatableObject2A, 2);
			
			map.putAll(putAllMap);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////////
		// IMap().putAllByObject() TESTS //
		///////////////////////////////////
		
		[Test]
		public function putAllByObject_validArgumentWithTwoEquatableValues_checkIfContainsOneAddedValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllObject:Object = {};
			putAllObject["equatable-object-1"] = equatableObject1A;
			putAllObject["equatable-object-2"] = equatableObject2A;
			
			map.putAllByObject(putAllObject);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var containsKey:Boolean = map.containsValue(equatableObject2B);
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function putAllByObject_argumentWithTwoEquatableKeys_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllObject:Object = {};
			putAllObject["equatable-object-1"] = equatableObject1A;
			putAllObject["equatable-object-2"] = equatableObject2A;
			
			map.putAllByObject(putAllObject);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function putAllByObject_validArgumentWithTwoNotEquatableKeyValue_checkIfMapSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var putAllObject:Object = {};
			putAllObject["equatable-object-1"] = equatableObject1A;
			putAllObject["equatable-object-2"] = equatableObject2A;
			
			map.putAllByObject(putAllObject);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		/////////////////////////////
		// IMap().putEntry() TESTS //
		/////////////////////////////
		
		[Test]
		public function putEntry_validEntryOfEquatableKey_ReturnsNull(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldKey:* = map.putEntry(new MapEntry(equatableObject1A, 1));
			Assert.assertNull(oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfEquatableKey_keyAlreadyAdded_ReturnsOldValue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldKey:* = map.putEntry(new MapEntry(equatableObject1B, 1));
			Assert.assertNotNull(oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfEquatableKey_keyAlreadyAdded_checkIfReturnedCorrectOldValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			map.put(equatableObject1A, 1);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var oldKey:* = map.putEntry(new MapEntry(equatableObject1B, 2));
			Assert.assertEquals(1, oldKey);
		}
		
		[Test]
		public function putEntry_validEntryOfEquatableKey_keyAlreadyAdded_checkIfContainsNewValue_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.putEntry(new MapEntry(equatableObject1A, 1));
			map.putEntry(new MapEntry(equatableObject1B, 2));
			
			var contains:Boolean = map.containsValue(2);
			Assert.assertTrue(contains);
		}
		
		///////////////////////////
		// IMap().remove() TESTS //
		///////////////////////////
		
		[Test]
		public function remove_emptyMap_ReturnsNull(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var removedValue:* = map.remove(equatableObject1A);
			Assert.assertNull(removedValue);
		}
		
		[Test]
		public function remove_mapWithThreeEquatableKeys_containsKeyToBeRemoved_ReturnsValue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			map.put(equatableObject3A, 3);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removedValue:* = map.remove(equatableObject2B);
			Assert.assertEquals(2, removedValue);
		}
		
		[Test]
		public function remove_mapWithTwoEquatableKeys_theValuesAreEqual_containsKeyToBeRemoved_ReturnsValue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 1);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removedValue:* = map.remove(equatableObject2B);
			Assert.assertEquals(1, removedValue);
		}
		
		[Test]
		public function remove_mapWithOneEquatableKeys_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.put(equatableObject1A, 1);
			map.remove(equatableObject1B);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function remove_mapWithTwoEquatableKeys_removeOneKey_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.remove(equatableObject1B);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function remove_mapWithTwoEquatableKeys_removeOneKey_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			map.remove(equatableObject1B);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		//////////////////////////////
		// IMap().removeAll() TESTS //
		//////////////////////////////
		
		[Test]
		public function removeAll_emptyMap_ReturnsFalse(): void
		{
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add("element-1");
			
			var changed:Boolean = map.removeAll(removeAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function removeAll_mapWithTwoEquatableKeys_argumentWithThreeEquatableKeysOfWhichTwoAreContained_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add(equatableObject1A);
			removeAllCollection.add(equatableObject2A);
			removeAllCollection.add(equatableObject3A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject3B, 3);
			
			var changed:Boolean = map.removeAll(removeAllCollection);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function removeAll_mapWithTwoEquatableKeys_argumentWithTheTwoKeys_checkIfMapIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add(equatableObject1A);
			removeAllCollection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			
			map.removeAll(removeAllCollection);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeAll_mapWithTwoEquatableKeys_argumentWithTheTwoKeys_checkIfMapSizeIsZero_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add(equatableObject1A);
			removeAllCollection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			
			map.removeAll(removeAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function removeAll_mapWithTwoEquatableKeys_argumentWithOneEquatableKey_checkIfMapIsEmpty_ReturnsFalse(): void
		{
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject3B, 3);
			
			map.removeAll(removeAllCollection);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function removeAll_mapWithTwoEquatableKeys_argumentWithOneEquatableKey_checkIfMapSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeAllCollection:IList = new ArrayList();
			removeAllCollection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			
			map.removeAll(removeAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		//////////////////////////////
		// IMap().retainAll() TESTS //
		//////////////////////////////
		
		[Test]
		public function retainAll_mapWithTwoNotEquatableKeyValue_argumentWithTheTwoMapElements_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			
			var changed:Boolean = map.retainAll(retainAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function retainAll_mapWithOneNotEquatableKeyValue_argumentWithTwoNotEquatableKeysOfWhichNoneIsContained_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			map.put(equatableObject3A, 3);
			
			var changed:Boolean = map.retainAll(retainAllCollection);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function retainAll_mapWithFourNotEquatableKeyValue_argumentWithThreeContainedKeys_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			map.put(equatableObject3B, 3);
			map.put(equatableObject4B, 4);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_mapWithThreeNotEquatableKeyValue_argumentWithFourKeysOfWhichThreeContained_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			retainAllCollection.add(equatableObject4A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			map.put(equatableObject4B, 4);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_mapWithFourNotEquatableKeyValue_argumentWithFourKeysOfWhichThreeContained_checkIfMapSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var retainAllCollection:IList = new ArrayList();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			retainAllCollection.add(equatableObject4A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject8B:EquatableObject = new EquatableObject("equatable-object-8");
			
			map.put(equatableObject1B, 1);
			map.put(equatableObject2B, 2);
			map.put(equatableObject4B, 4);
			map.put(equatableObject8B, 8);
			
			map.retainAll(retainAllCollection);
			
			var size:int = map.size();
			Assert.assertEquals(3, size);
		}
		
	}

}