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
	import org.as3collections.IListMapIterator;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedListMapTests extends TypedMapTests
	{
		public function get typedListMap():TypedListMap { return map as TypedListMap; }
		
		public function TypedListMapTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getMap(typeKeys:Class, typeValues:Class):TypedMap
		{
			// using a ArrayListMap object
			// instead of a fake to simplify tests
			// since ArrayListMap is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in ArrayListMap may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the ArrayListMap object
			return new TypedListMap(new ArrayListMap(), typeKeys, typeValues);
		}
		
		//////////////////////////////////
		// TypedListMap().clone() TESTS //
		//////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsTypedListMap_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedListMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_mapWithTwoNotEquatableKeyValue_checkIfTypeOfReturnedMapIsTypedListMap_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var clonedMap:IMap = map.clone();
			
			var isTypedListMap:Boolean = ReflectionUtil.classPathEquals(TypedListMap, clonedMap);
			Assert.assertTrue(isTypedListMap);
		}
		
		///////////////////////////////////
		// TypedListMap().equals() TESTS //
		///////////////////////////////////
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			
			var typedListMap2:IMap = getMap(String, int);
			typedListMap2.put("element-1", 1);
			typedListMap2.put("element-2", 2);
			
			var equal:Boolean = typedListMap.equals(typedListMap2);
			Assert.assertTrue(equal);
		}
		
		/////////////////////////////////////
		// TypedListMap().getKeyAt() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function getKeyAt_addedOneNotEquatableMapping_getKeyAtIndexZero_checkIfReturnedKeyMatches_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			
			var key:String = typedListMap.getKeyAt(0);
			Assert.assertEquals("element-1", key);
		}
		
		/////////////////////////////////////
		// TypedListMap().getValueAt() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function getValueAt_addedOneNotEquatableMapping_getValueAtIndexZero_checkIfReturnedValueMatches_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			
			var value:int = typedListMap.getValueAt(0);
			Assert.assertEquals(1, value);
		}
		
		////////////////////////////////////
		// TypedListMap().headMap() TESTS //
		////////////////////////////////////
		
		[Test]
		public function headMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			typedListMap.put("element-5", 5);
			typedListMap.put("element-7", 7);
			typedListMap.put("element-9", 9);
			
			var headMap:IMap = typedListMap.headMap("element-9");
			
			var equalHeadMap:IMap = getMap(String, int);
			equalHeadMap.put("element-5", 5);
			equalHeadMap.put("element-7", 7);
			
			var equal:Boolean = headMap.equals(equalHeadMap);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function headMap_mapWithThreeKeyValue_checkIfReturnedMapIsTypedListMap_ReturnsTrue(): void
		{
			typedListMap.put("element-5", 5);
			typedListMap.put("element-7", 7);
			typedListMap.put("element-9", 9);
			
			var headMap:IMap = typedListMap.headMap("element-9");
			
			var isTypedListMap:Boolean = ReflectionUtil.classPathEquals(TypedListMap, headMap);
			Assert.assertTrue(isTypedListMap);
		}
		
		///////////////////////////////////////
		// TypedListMap().indexOfKey() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function indexOfKey_mapWithIntegerKeys_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var newMap:TypedListMap = getMap(int, String) as TypedListMap;
			newMap.put(5, "element-5");
			newMap.put(7, "element-7");
			newMap.put(9, "element-9");
			
			var index:int = newMap.indexOfKey(9);
			Assert.assertEquals(2, index);
		}
		
		/////////////////////////////////////////
		// TypedListMap().indexOfValue() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function indexOfValue_mapWithIntegerValues_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			typedListMap.put("element-5", 5);
			typedListMap.put("element-7", 7);
			typedListMap.put("element-9", 9);
			
			var index:int = typedListMap.indexOfValue(9);
			Assert.assertEquals(2, index);
		}
		
		////////////////////////////////////////////
		// TypedListMap().listMapIterator() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function listMapIterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IListMapIterator = typedListMap.listMapIterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function listMapIterator_simpleCall_tryToPutValidMappingThroughIListMapIterator_Void(): void
		{
			var iterator:IListMapIterator = typedListMap.listMapIterator();
			iterator.put("element-1", 1);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function listMapIterator_simpleCall_tryToPutInvalidMappingThroughIListMapIterator_ThrowsError(): void
		{
			var iterator:IListMapIterator = typedListMap.listMapIterator();
			iterator.put(1, 1);
		}
		
		/////////////////////////////////////
		// TypedListMap().putAllAt() TESTS //
		/////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function putAllAt_invalidArgument_ThrowsError(): void
		{
			typedListMap.putAllAt(0, null);
		}
		
		[Test]
		public function putAllAt_emptyArgument_Void(): void
		{
			var addAllMap:IMap = new HashMap();
			typedListMap.putAllAt(0, addAllMap);
		}
		
		[Test]
		public function putAllAt_argumentWithOneValidMapping_Void(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put("element-1", 1);
			
			typedListMap.putAllAt(0, addAllMap);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAllAt_argumentWithOneInvalidMapping_ThrowsError(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put(1, 1);
			
			typedListMap.putAllAt(0, addAllMap);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAllAt_argumentWithOneValidMappingAndOneInvalid_ThrowsError(): void
		{
			var addAllMap:IMap = new HashMap();
			addAllMap.put("element-1", 1);
			addAllMap.put("element-2", "element-2");
			
			typedListMap.putAllAt(0, addAllMap);
		}
		
		////////////////////////////////
		// TypedListMap().putAt() TESTS //
		////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAt_invalidKeyType_ThrowsError(): void
		{
			typedListMap.putAt(0, 1, 1);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function putAt_invalidValueType_ThrowsError(): void
		{
			typedListMap.putAt(0, "element-1", "element-1");
		}
		
		[Test]
		public function putAt_validArgument_Void(): void
		{
			typedListMap.putAt(0, "element-1", 1);
		}
		
		/////////////////////////////////////
		// TypedListMap().removeAt() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_emptyMap_ThrowsError(): void
		{
			typedListMap.removeAt(0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeAt_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.removeAt(2);
		}
		
		[Test]
		public function removeAt_mapWithOneNotEquatabeMapping_removeAtIndexZero_ReturnsCorrectObject(): void
		{
			typedListMap.put("element-1", 1);
			
			var entry:IMapEntry = typedListMap.removeAt(0);
			Assert.assertEquals("element-1", entry.key);
		}
		
		////////////////////////////////////////
		// TypedListMap().removeRange() TESTS //
		////////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function removeRange_emptyMap_ThrowsError(): void
		{
			typedListMap.removeRange(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function removeRange_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.removeRange(0, 3);
		}
		
		[Test]
		public function removeRange_mapWithOneNotEquatabeMapping_ReturnsValidMap(): void
		{
			typedListMap.put("element-1", 1);
			
			var removedMap:IMap = typedListMap.removeRange(0, 1);
			Assert.assertNotNull(removedMap);
		}
		
		////////////////////////////////////
		// TypedListMap().reverse() TESTS //
		////////////////////////////////////
		
		[Test]
		public function reverse_emptyMap_Void(): void
		{
			typedListMap.reverse();
		}
		
		[Test]
		public function reverse_mapWithTwoNotEquatableMappings_checkIfFirstKeyNowIsTheSecond_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			
			typedListMap.reverse();
			
			var key:String = typedListMap.getKeyAt(1);
			Assert.assertEquals("element-1", key);
		}
		
		[Test]
		public function reverse_mapWithTwoNotEquatableMappings_checkIfSecondValueNowIsTheSecond_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			
			typedListMap.reverse();
			
			var value:String = typedListMap.getValueAt(0);
			Assert.assertEquals(2, value);
		}
		
		/////////////////////////////////////
		// TypedListMap().setKeyAt() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setKeyAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.setKeyAt(0, "element-1");
		}
		
		[Test]
		public function setKeyAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsAddedKey_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.put("element-3", 3);
			
			typedListMap.setKeyAt(2, "element-4");
			
			var contains:Boolean = typedListMap.containsKey("element-4");
			Assert.assertTrue(contains);
		}
		
		///////////////////////////////////////
		// TypedListMap().setValueAt() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function setValueAt_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.setValueAt(0, 1);
		}
		
		[Test]
		public function setValueAt_notEmptyMap_validArgumentNotEquatable_boundaryCondition_checkIfMapContainsAddedValue_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.put("element-3", 3);
			
			typedListMap.setValueAt(2, 4);
			
			var contains:Boolean = typedListMap.containsValue(4);
			Assert.assertTrue(contains);
		}
		
		/////////////////////////////////////
		// TypedListMap().subMap() TESTS //
		/////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function subMap_emptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.subMap(0, 0);
		}
		
		[Test(expects="org.as3collections.errors.IndexOutOfBoundsError")]
		public function subMap_notEmptyMap_indexOutOfBounds_ThrowsError(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.put("element-3", 4);
			
			typedListMap.subMap(0, 4);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfReturnedMapSizeMatches_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.put("element-3", 4);
			
			var subMap:IMap = typedListMap.subMap(0, 2);
			
			var size:int = subMap.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function subMap_notEmptyMap_checkIfReturnedMapIsTypedListMap_ReturnsTrue(): void
		{
			typedListMap.put("element-1", 1);
			typedListMap.put("element-2", 2);
			typedListMap.put("element-3", 4);
			
			var subMap:IMap = typedListMap.subMap(0, 2);
			
			var isTypedListMap:Boolean = ReflectionUtil.classPathEquals(TypedListMap, subMap);
			Assert.assertTrue(isTypedListMap);
		}
		
		////////////////////////////////////
		// TypedListMap().tailMap() TESTS //
		////////////////////////////////////
		
		[Test]
		public function tailMap_mapWithThreeKeyValue_checkIfReturnedMapIsCorrect_ReturnsTrue(): void
		{
			typedListMap.put("element-5", 5);
			typedListMap.put("element-7", 7);
			typedListMap.put("element-9", 9);
			
			var tailMap:IMap = typedListMap.tailMap("element-7");
			
			var equalTailMap:IMap = getMap(String, int);
			equalTailMap.put("element-7", 7);
			equalTailMap.put("element-9", 9);
			
			var equal:Boolean = tailMap.equals(equalTailMap);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function tailMap_notEmptyMap_checkIfReturnedMapIsTypedListMap_ReturnsTrue(): void
		{
			typedListMap.put("element-5", 5);
			typedListMap.put("element-7", 7);
			typedListMap.put("element-9", 9);
			
			var tailMap:IMap = typedListMap.tailMap("element-7");
			
			var isTypedListMap:Boolean = ReflectionUtil.classPathEquals(TypedListMap, tailMap);
			Assert.assertTrue(isTypedListMap);
		}
		
	}

}