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
	import org.as3collections.EquatableObject;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IMap;
	import org.as3collections.MapEntry;
	import org.as3collections.lists.ArrayList;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedMapTests
	{
		public var map:IMap;
		
		public function TypedMapTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			map = getMap(String, int);
		}
		
		[After]
		public function tearDown(): void
		{
			map = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getMap(typeKeys:Class, typeValues:Class):TypedMap
		{
			// using a HashMap object
			// instead of a fake to simplify tests
			// since HashMap is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in HashMap may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the HashMap object
			return new TypedMap(new HashMap(), typeKeys, typeValues);
		}
		
		///////////////////////////////
		// TypedMap().typeKeys TESTS //
		///////////////////////////////
		
		[Test]
		public function typeKeys_createInstanceCheckType_ReturnsCorrectType(): void
		{
			var newMap:TypedMap = getMap(String, int);
			
			var typeKeys:Class = newMap.typeKeys;
			Assert.assertEquals(String, typeKeys);
		}
		
		/////////////////////////////////
		// TypedMap().typeValues TESTS //
		/////////////////////////////////
		
		[Test]
		public function typeValues_createInstanceCheckType_ReturnsCorrectType(): void
		{
			var newMap:TypedMap = getMap(String, int);
			
			var typeValues:Class = newMap.typeValues;
			Assert.assertEquals(int, typeValues);
		}
		
		//////////////////////////////
		// TypedMap().clear() TESTS //
		//////////////////////////////
		
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
		
		//////////////////////////////
		// TypedMap().clone() TESTS //
		//////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsTypedMap_ReturnsTrue(): void
		{
			var typedMap:IMap = new TypedMap(new HashMap(), String, int);
			var clonedMap:IMap = typedMap.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableKeyValue_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var clonedMap:IMap = map.clone();
			
			var equal:Boolean = map.equals(clonedMap);
			Assert.assertTrue(equal);
		}
		
		////////////////////////////////////
		// TypedMap().containsKey() TESTS //
		////////////////////////////////////
		
		[Test]
		public function containsKey_mapWithOneNotEquatableKeyValue_containsKey_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsKey("element-1");
			Assert.assertTrue(contains);
		}
		
		//////////////////////////////////////
		// TypedMap().containsValue() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function containsValue_mapWithOneNotEquatableKeyValue_containsValue_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var contains:Boolean = map.containsValue(1);
			Assert.assertTrue(contains);
		}
		
		//////////////////////////////
		// IMap().entryList() TESTS //
		//////////////////////////////
		
		[Test]
		public function entryList_mapWithTwoNotEquatableElements_checkIfReturnedListSizeIsTwo_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var entries:IList = map.entryList();
			
			var size:int = entries.size();
			Assert.assertEquals(2, size);
		}
		
		////////////////////////////////
		// TypedMap().equals() TESTS //
		////////////////////////////////
		
		[Test]
		public function equals_twoEmptyMaps_oneMapIsReadOnly_ReturnsFalse(): void
		{
			var readOnlyMap:IMap = new ReadOnlyHashMap(new HashMap());
			
			var equal:Boolean = map.equals(readOnlyMap);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameElementsButDifferentOrder_HashMapWrapped_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap(String, int);
			map2.put("element-2", 2);
			map2.put("element-1", 1);
			
			var equal:Boolean = map.equals(map2);// HashMap does not take care of order
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameElementsButDifferentOrder_ArrayListMapWrapped_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			var newMap1:IMap = new TypedMap(new ArrayListMap(), String, int);
			newMap1.put("element-1", 1);
			newMap1.put("element-2", 2);
			
			var newMap2:IMap = new TypedMap(new ArrayListMap(), String, int);
			newMap2.put("element-2", 2);
			newMap2.put("element-1", 1);
			
			var equal:Boolean = newMap1.equals(newMap2);// ArrayListMap takes care of order
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameElementsAndSameOrder_ArrayListMapWrapped_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var newMap1:IMap = new TypedMap(new ArrayListMap(), String, int);
			newMap1.put("element-1", 1);
			newMap1.put("element-2", 2);
			
			var newMap2:IMap = new TypedMap(new ArrayListMap(), String, int);
			newMap2.put("element-1", 1);
			newMap2.put("element-2", 2);
			
			var equal:Boolean = newMap1.equals(newMap2);// ArrayListMap takes care of order
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function equals_twoEmptyMapsWithSameTypes_ReturnsTrue(): void
		{
			var map2:IMap = getMap(String, int);
			Assert.assertTrue(map.equals(map2));
		}
		
		[Test]
		public function equals_twoEmptyMapsWithDifferentKeyType_ReturnsFalse(): void
		{
			var map2:IMap = getMap(int, int);
			Assert.assertFalse(map.equals(map2));
		}
		
		[Test]
		public function equals_twoEmptyMapsWithDifferentValueType_ReturnsFalse(): void
		{
			var map2:IMap = getMap(String, String);
			Assert.assertFalse(map.equals(map2));
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap(String, int);
			map2.put("element-1", 1);
			map2.put("element-2", 2);
			
			var equal:Boolean = map.equals(map2);// HashMap does not take care of order
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function equals_mapWithTwoEquatableKeys_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newMap1:IMap = getMap(EquatableObject, int);
			newMap1.put(equatableObject1A, 1);
			newMap1.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newMap2:IMap = getMap(EquatableObject, int);
			newMap2.put(equatableObject1B, 1);
			newMap2.put(equatableObject2B, 2);
			
			var equal:Boolean = newMap1.equals(newMap2);
			Assert.assertTrue(equal);
		}
		
		////////////////////////////////
		// TypedMap().getKeys() TESTS //
		////////////////////////////////
		
		[Test]
		public function getKeys_mapWithTwoNotEquatableElements_checkIfReturnedListSizeIsTwo_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var keys:IList = map.getKeys();
			
			var size:int = keys.size();
			Assert.assertEquals(2, size);
		}
		
		/////////////////////////////////
		// TypedMap().getValue() TESTS //
		/////////////////////////////////
		
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
		public function getValue_notEmptyMap_notContainedNotEquatableKey_ReturnsNull(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var value:* = map.getValue("element-3");
			Assert.assertNull(value);
		}
		
		//////////////////////////////////
		// TypedMap().getValues() TESTS //
		//////////////////////////////////
		
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
		
		////////////////////////////
		// TypedMap().put() TESTS //
		////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function put_invalidKeyType_ThrowsError(): void
		{
			map.put(1, 1);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function put_invalidValueType_ThrowsError(): void
		{
			map.put("element-1", "element-1");
		}
		
		[Test]
		public function put_validKeyValue_checkIfSizeIsOne_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////////
		// TypedMap().putAll() TESTS //
		///////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function putAll_invalidArgument_ThrowsError(): void
		{
			map.putAll(null);
		}
		
		[Test]
		public function putAll_argumentWithTwoValidKeyValue_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put("element-1", 1);
			addAllMap.put("element-2", 2);
			
			map.putAll(addAllMap);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAll_argumentWithOneInvalidKey_ThrowsError(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put(1, 1);
			
			map.putAll(addAllMap);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAll_argumentWithOneValidValueAndOneInvalid_ThrowsError(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put("element-1", 1);
			addAllMap.put("element-2", "element-2");
			
			map.putAll(addAllMap);
		}
		
		///////////////////////////////////////
		// TypedMap().putAllByObject() TESTS //
		///////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function putAllByObject_invalidArgument_ThrowsError(): void
		{
			map.putAllByObject(null);
		}
		
		[Test]
		public function putAllByObject_argumentWithTwoValidKeyValue_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var addAllObject:Object = {};
			addAllObject["element-1"] = 1;
			addAllObject["element-2"] = 2;
			
			map.putAllByObject(addAllObject);
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAllByObject_argumentWithOneInvalidKey_ThrowsError(): void
		{
			var addAllObject:Object = {};
			addAllObject[1] = 1;
			
			map.putAllByObject(addAllObject);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAllByObject_argumentWithOneValidValueAndOneInvalid_ThrowsError(): void
		{
			var addAllObject:Object = {};
			addAllObject["element-1"] = 1;
			addAllObject["element-2"] = "element-2";
			
			map.putAllByObject(addAllObject);
		}
		
		/////////////////////////////////
		// TypedMap().putEntry() TESTS //
		/////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putEntry_invalidKeyType_ThrowsError(): void
		{
			map.putEntry(new MapEntry(1, 1));
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putEntry_invalidValueType_ThrowsError(): void
		{
			map.putEntry(new MapEntry("element-1", "element-1"));
		}
		
		[Test]
		public function putEntry_validKeyValue_checkIfSizeIsOne_ReturnsTrue(): void
		{
			map.putEntry(new MapEntry("element-1", 1));
			
			var size:int = map.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////////
		// TypedMap().remove() TESTS //
		///////////////////////////////
		
		[Test]
		public function remove_emptyMap_ReturnsNull(): void
		{
			var value:* = map.remove("element-1");
			Assert.assertNull(value);
		}
		
		[Test]
		public function remove_mapWithThreeNotEquatableKeyValue_containsKey_ReturnsCorrectValue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			map.put("element-3", 3);
			
			var value:* = map.remove("element-2");
			Assert.assertEquals(2, value);
		}
		
		////////////////////////////////////////
		// TypedMap().removeAll() TESTS //
		////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function removeAll_invalidArgument_ThrowsError(): void
		{
			map.removeAll(null);
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
		
		//////////////////////////////////
		// TypedMap().retainAll() TESTS //
		//////////////////////////////////
		
		[Test(expects="ArgumentError")]
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
		
		/////////////////////////////////
		// TypedMap().toString() TESTS //
		/////////////////////////////////
		
		[Test]
		public function toString_emptyMap_ReturnsValidString(): void
		{
			var string:String = (map as TypedMap).toString();
			Assert.assertNotNull(string);
		}
		
	}

}