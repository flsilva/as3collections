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
	import org.as3collections.IMap;
	import org.as3collections.MapEntry;
	import org.as3collections.iterators.ReadOnlyMapIterator;
	import org.as3collections.lists.ArrayList;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ReadOnlyArrayListMapTests
	{
		public var map:IMap;
		
		public function ReadOnlyArrayListMapTests()
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
			var addMap:HashMap = new HashMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			addMap.put("element-3", 3);
			
			return new ReadOnlyArrayListMap(addMap);
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayListMap() constructor TESTS //
		//////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ReadOnlyArrayListMap(null);
		}
		
		/////////////////////////////////////////////////
		// ReadOnlyArrayListMap().allKeysEquatable() TESTS //
		/////////////////////////////////////////////////
		
		[Test]
		public function allKeysEquatable_emptyMap_ReturnsTrue(): void
		{
			var newMap:IMap = new ReadOnlyArrayListMap(new HashMap());
			
			var allKeysEquatable:Boolean = newMap.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithThreeNotEquatableKeys_ReturnsFalse(): void
		{
			var allKeysEquatable:Boolean = map.allKeysEquatable;
			Assert.assertFalse(allKeysEquatable);
		}
		
		[Test]
		public function allKeysEquatable_mapWithThreeEquatableKeys_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addMap:IMap = new HashMap();
			addMap.put(equatableObject1A, 1);
			addMap.put(equatableObject2A, 2);
			
			var newMap:IMap = new ReadOnlyArrayListMap(addMap);
			
			var allKeysEquatable:Boolean = newMap.allKeysEquatable;
			Assert.assertTrue(allKeysEquatable);
		}
		
		///////////////////////////////////////////////////
		// ReadOnlyArrayListMap().allValuesEquatable() TESTS //
		///////////////////////////////////////////////////
		
		[Test]
		public function allValuesEquatable_emptyMap_ReturnsTrue(): void
		{
			var newMap:IMap = new ReadOnlyArrayListMap(new HashMap());
			
			var allValuesEquatable:Boolean = newMap.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithThreeNotEquatableValues_ReturnsFalse(): void
		{
			var allValuesEquatable:Boolean = map.allValuesEquatable;
			Assert.assertFalse(allValuesEquatable);
		}
		
		[Test]
		public function allValuesEquatable_mapWithThreeEquatableValues_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addMap:IMap = new HashMap();
			addMap.put("equatable-object-1", equatableObject1A);
			addMap.put("equatable-object-2", equatableObject2A);
			
			var newMap:IMap = new ReadOnlyArrayListMap(addMap);
			
			var allValuesEquatable:Boolean = newMap.allValuesEquatable;
			Assert.assertTrue(allValuesEquatable);
		}
		
		//////////////////////////////////////
		// ReadOnlyArrayListMap().clear() TESTS //
		//////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function clear_simpleCall_ThrowsError(): void
		{
			map.clear();
		}
		
		//////////////////////////////////////
		// ReadOnlyArrayListMap().clone() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsReadOnlyArrayListMap_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(ReadOnlyArrayListMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_mapWithThreeNotEquatableKeyValue_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var equal:Boolean = map.equals(clonedMap);
			Assert.assertTrue(equal);
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayListMap().equals() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameKeyValuesButDifferentOrder_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			var addMap1:IMap = new ArrayListMap();
			addMap1.put("element-1", 1);
			addMap1.put("element-2", 2);
			
			var map1:IMap = new ReadOnlyArrayListMap(addMap1);
			
			var addMap2:IMap = new ArrayListMap();
			addMap2.put("element-2", 2);
			addMap2.put("element-1", 1);
			
			var map2:IMap = new ReadOnlyArrayListMap(addMap2);
			
			var equal:Boolean = map1.equals(map2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameKeyValuesAndSameOrder_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			var addMap1:IMap = new ArrayListMap();
			addMap1.put("element-1", 1);
			addMap1.put("element-2", 2);
			
			var map1:IMap = new ReadOnlyArrayListMap(addMap1);
			
			var addMap2:IMap = new ArrayListMap();
			addMap2.put("element-1", 1);
			addMap2.put("element-2", 2);
			
			var map2:IMap = new ReadOnlyArrayListMap(addMap2);
			
			var equal:Boolean = map1.equals(map2);
			Assert.assertTrue(equal);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayListMap().iterator() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function iterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IIterator = map.iterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function iterator_simpleCall_checkIfReturnedIteratorIsReadOnly_ReturnsTrue(): void
		{
			var iterator:IIterator = map.iterator();
			
			var isClassPathEqual:Boolean = ReflectionUtil.classPathEquals(ReadOnlyMapIterator, iterator);
			Assert.assertTrue(isClassPathEqual);
		}
		
		////////////////////////////////////
		// ReadOnlyArrayListMap().put() TESTS //
		////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function put_validNotEquatableKeyValue_ThrowsError(): void
		{
			map.put("element-4", 4);
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayListMap().putAll() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function putAll_validEmptyArgument_ThrowsError(): void
		{
			map.putAll(new HashMap());
		}
		
		///////////////////////////////////////////////
		// ReadOnlyArrayListMap().putAllByObject() TESTS //
		///////////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function putAllByObject_validEmptyArgument_ThrowsError(): void
		{
			map.putAllByObject({});
		}
		
		////////////////////////////////////////
		// ReadOnlyArrayListMap().putEntry() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function putEntry_validArgument_ThrowsError(): void
		{
			map.putEntry(new MapEntry("element-4", 4));
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayListMap().remove() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_validNotEquatableKey_ThrowsError(): void
		{
			map.remove("element-4");
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayListMap().removeAll() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeAll_validEmptyArgument_ThrowsError(): void
		{
			map.removeAll(new ArrayList());
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayListMap().retainAll() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function retainAll_validEmptyArgument_ThrowsError(): void
		{
			map.retainAll(new ArrayList());
		}
		
	}

}