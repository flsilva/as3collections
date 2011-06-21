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
	import org.as3collections.IMap;
	import org.as3collections.IMapTestsEquatableObject;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayMapTestsEquatableObject extends IMapTestsEquatableObject
	{
		
		public function get arrayMap():ArrayMap { return map as ArrayMap; }
		
		public function ArrayMapTestsEquatableObject()
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
		public function constructor_argumentWithTwoEquatableKeys_checkIfIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addMap:IMap = new HashMap();
			addMap.put(equatableObject1A, 1);
			addMap.put(equatableObject2A, 2);
			
			var newMap:IMap = new HashMap(addMap);
			
			var isEmpty:Boolean = newMap.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoEquatableKeys_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addMap:IMap = new HashMap();
			addMap.put(equatableObject1A, 1);
			addMap.put(equatableObject2A, 2);
			
			var newMap:IMap = new HashMap(addMap);
			
			var size:int = newMap.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////
		// ArrayMap().equals() TESTS //
		///////////////////////////////
		
		[Test]
		public function equals_mapWithTwoEquatableKeys_sameKeyValuesButDifferentOrder_checkIfBothMapsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			map.put(equatableObject1A, 1);
			map.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var map2:IMap = getMap();
			map2.put(equatableObject2B, 2);
			map2.put(equatableObject1B, 1);
			
			Assert.assertFalse(map.equals(map2));//HashMap does take cares of order
		}
		
		[Test]
		public function equals_mapWithTwoEquatableKeys_sameKeyValuesAndSameOrder_checkIfBothMapsAreEqual_ReturnsTrue(): void
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
		
		///////////////////////////////////
		// ArrayMap().indexOfKey() TESTS //
		///////////////////////////////////
		
		[Test]
		public function indexOfKey_mapWithTwoEquatableKeys_checkIfIndexOfFirstKeyIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			arrayMap.put(equatableObject1A, 1);
			arrayMap.put(equatableObject2A, 2);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = arrayMap.indexOfKey(equatableObject1B);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOfKey_listWithThreeNotEquatableElements_checkIfIndexOfSecondKeyIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			arrayMap.put(equatableObject1A, 1);
			arrayMap.put(equatableObject2A, 2);
			arrayMap.put(equatableObject3A, 3);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var index:int = arrayMap.indexOfKey(equatableObject2B);
			Assert.assertEquals(1, index);
		}
		
		/////////////////////////////////////
		// ArrayMap().indexOfValue() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function indexOfValue_mapWithTwoNotEquatableKeyValue_checkIfIndexOfFirstValueIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			arrayMap.put("equatable-object-1", equatableObject1A);
			arrayMap.put("equatable-object-2", equatableObject2A);
			
			var index:int = arrayMap.indexOfValue(equatableObject1A);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOfValue_listWithThreeNotEquatableElements_checkIfIndexOfSecondValueIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			arrayMap.put("equatable-object-1", equatableObject1A);
			arrayMap.put("equatable-object-2", equatableObject2A);
			arrayMap.put("equatable-object-3", equatableObject3A);
			
			var index:int = arrayMap.indexOfValue(equatableObject2A);
			Assert.assertEquals(1, index);
		}
		
	}

}