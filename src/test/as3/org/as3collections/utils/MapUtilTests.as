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

package org.as3collections.utils
{
	import org.as3collections.IMap;
	import org.as3collections.maps.ArrayMap;
	import org.as3collections.maps.HashMap;
	import org.as3collections.maps.SortedArrayMap;
	import org.as3collections.maps.TypedMap;
	import org.as3collections.maps.TypedSortedMap;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class MapUtilTests
	{
		
		public function MapUtilTests()
		{
			
		}
		
		///////////////////////////////
		// MapUtil constructor TESTS //
		///////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new MapUtil();
		}
		
		//////////////////////////////////
		// MapUtil.getTypedList() TESTS //
		//////////////////////////////////
		
		[Test]
		public function getTypedList_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var map:IMap = MapUtil.getTypedMap(new HashMap(), String, int);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(map, TypedMap);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeKeys_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedMap(new HashMap(), String, int);
			Assert.assertEquals(String, map.typeKeys);
		}
		
		[Test]
		public function getTypedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeValues_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedMap(new HashMap(), String, int);
			Assert.assertEquals(int, map.typeValues);
		}
		
		///////////////////////////////////////
		// MapUtil.getTypedSortedMap() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var map:IMap = MapUtil.getTypedSortedMap(new SortedArrayMap(), String, int);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(map, TypedSortedMap);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeKeys_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedSortedMap(new SortedArrayMap(), String, int);
			Assert.assertEquals(String, map.typeKeys);
		}
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeValues_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedSortedMap(new SortedArrayMap(), String, int);
			Assert.assertEquals(int, map.typeValues);
		}
		
		//////////////////////////////
		// MapUtil.toString() TESTS //
		//////////////////////////////
		
		[Test]
		public function toString_emptyMap_checkIfReturnedStringMatches_ReturnsTrue(): void
		{
			var map:IMap = new ArrayMap();
			
			var string:String = MapUtil.toString(map);
			Assert.assertEquals("[]", string);
		}
		
		[Test]
		public function toString_notEmptyMap_checkIfReturnedStringMatches_ReturnsTrue(): void
		{
			var map:IMap = new ArrayMap();
			map.put("element-2", 2);
			map.put("element-1", 1);
			
			var string:String = MapUtil.toString(map);
			Assert.assertEquals("[element-2=2,element-1=1]", string);
		}
		
	}

}