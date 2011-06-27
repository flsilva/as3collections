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
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayMapTests extends IListMapTests
	{
		
		public function ArrayMapTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getMap():IMap
		{
			return new ArrayMap();
		}
		
		//////////////////////////////////
		// ArrayMap() constructor TESTS //
		//////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoNotEquatableKeyValue_checkIfIsEmpty_ReturnsFalse(): void
		{
			var addMap:IMap = new HashMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			var newMap:IMap = new HashMap(addMap);
			
			var isEmpty:Boolean = newMap.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoNotEquatableKeyValue_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var addMap:IMap = new HashMap();
			addMap.put("element-1", 1);
			addMap.put("element-2", 2);
			
			var newMap:IMap = new HashMap(addMap);
			
			var size:int = newMap.size();
			Assert.assertEquals(2, size);
		}
		
		//////////////////////////////
		// ArrayMap().clone() TESTS //
		//////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsArrayMap_ReturnsTrue(): void
		{
			var clonedMap:IMap = map.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(ArrayMap, clonedMap);
			Assert.assertTrue(isCorrectType);
		}
		
		///////////////////////////////
		// ArrayMap().equals() TESTS //
		///////////////////////////////
		
		[Test]
		public function equals_twoEmptyMaps_oneMapIsReadOnly_ReturnsFalse(): void
		{
			var readOnlyMap:IMap = new ReadOnlyArrayMap(new ArrayMap());
			
			var equal:Boolean = map.equals(readOnlyMap);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameKeyValuesButDifferentOrder_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap();
			map2.put("element-2", 2);
			map2.put("element-1", 1);
			
			Assert.assertFalse(map.equals(map2));//ArrayMap does take cares of order
		}
		
		[Test]
		public function equals_mapWithTwoNotEquatableKeyValue_sameKeyValuesAndSameOrder_checkIfBothMapsAreEqual_ReturnsTrue(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap();
			map2.put("element-1", 1);
			map2.put("element-2", 2);
			
			Assert.assertTrue(map.equals(map2));
		}
		
		[Test]
		public function equals_differentMaps_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			map.put("element-1", 1);
			map.put("element-2", 2);
			
			var map2:IMap = getMap();
			map2.put("element-1", 1);
			map2.put("element-3", 3);
			
			Assert.assertFalse(map.equals(map2));
		}
		
		/////////////////////////////////
		// ArrayMap().toString() TESTS //
		/////////////////////////////////
		
		[Test]
		public function toString_emptyMap_ReturnsValidString(): void
		{
			Assert.assertEquals("[]", map);
		}
		
		[Test]
		public function toString_notEmptyList_ReturnsValidString(): void
		{
			map.put("element-2", 2);
			map.put(3, "element-3");
			
			Assert.assertEquals("[element-2=2,3=element-3]", map);
		}
		
	}

}