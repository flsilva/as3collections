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
	import org.as3collections.maps.ArrayListMap;
	import org.as3collections.maps.HashMap;
	import org.as3collections.maps.SortedArrayListMap;
	import org.as3collections.maps.TypedListMap;
	import org.as3collections.maps.TypedMap;
	import org.as3collections.maps.TypedSortedMap;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	[TestCase]
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
		
		////////////////////////////////////////
		// MapUtil.feedMapWithXmlList() TESTS //
		////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function feedMapWithXmlList_invalidNullMap_ThrowsError(): void
		{
			MapUtil.feedMapWithXmlList(null, null);
		}
		
		[Test]
		public function feedMapWithXmlList_nullXmlList_doNothing_checkIfMapRemainsEmpty_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			MapUtil.feedMapWithXmlList(map, null);
			
			var isEmpty:Boolean = map.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfMapSizeMatches(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var size:int = map.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsKey1_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsKey:Boolean = map.containsKey("key1");
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsKey2_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsKey:Boolean = map.containsKey("key2");
			Assert.assertTrue(containsKey);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsKey3_ReturnsFalse(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsKey:Boolean = map.containsKey("key3");
			Assert.assertFalse(containsKey);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsValue1_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue("value1");
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsValue2_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue("value2");
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_checkIfContainsValue3_ReturnsFalse(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue("value3");
			Assert.assertFalse(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlList_callGetValue_ReturnsCorrectValue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>value1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var value:* = map.getValue("key2");
			Assert.assertEquals("value2", value);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneTrueValueString_typeCoercionTrue_checkIfContainsBooleanValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>true</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue(true);
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneFalseValueString_typeCoercionTrue_checkIfContainsBooleanValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>false</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue(false);
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneTrueValueString_typeCoercionFalse_checkIfContainsBooleanStringValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>true</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children(), false);
			
			var containsValue:Boolean = map.containsValue("true");
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneNumberValueString_typeCoercionTrue_checkIfContainsNumberValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>1.1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue(1.1);
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneIntValueString_typeCoercionTrue_checkIfContainsIntValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>-1</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children());
			
			var containsValue:Boolean = map.containsValue(-1);
			Assert.assertTrue(containsValue);
		}
		
		[Test]
		public function feedMapWithXmlList_validXmlListWithOneIntValueString_typeCoercionFalse_checkIfContainsIntStringValue_ReturnsTrue(): void
		{
			var map:IMap = new HashMap();
			
			var xml:XML = <index><key1>3</key1><key2>value2</key2></index>;
			
			MapUtil.feedMapWithXmlList(map, xml.children(), false);
			
			var containsValue:Boolean = map.containsValue("3");
			Assert.assertTrue(containsValue);
		}
		
		/////////////////////////////////
		// MapUtil.getTypedMap() TESTS //
		/////////////////////////////////
		
		[Test]
		public function getTypedMap_simpleCall_checkIfReturnedTypedMap_ReturnsTrue(): void
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
		// MapUtil.getTypedListMap() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function getTypedListMap_simpleCall_checkIfReturnedgetTypedListMap_ReturnsTrue(): void
		{
			var map:IMap = MapUtil.getTypedListMap(new ArrayListMap(), String, int);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(map, TypedListMap);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedListMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeKeys_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedListMap(new ArrayListMap(), String, int);
			Assert.assertEquals(String, map.typeKeys);
		}
		
		[Test]
		public function getTypedListMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeValues_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedListMap(new ArrayListMap(), String, int);
			Assert.assertEquals(int, map.typeValues);
		}
		
		///////////////////////////////////////
		// MapUtil.getTypedSortedMap() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedSortedMap_ReturnsTrue(): void
		{
			var map:IMap = MapUtil.getTypedSortedMap(new SortedArrayListMap(), String, int);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(map, TypedSortedMap);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeKeys_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedSortedMap(new SortedArrayListMap(), String, int);
			Assert.assertEquals(String, map.typeKeys);
		}
		
		[Test]
		public function getTypedSortedMap_simpleCall_checkIfReturnedTypedMapWithCorrectTypeValues_ReturnsTrue(): void
		{
			var map:TypedMap = MapUtil.getTypedSortedMap(new SortedArrayListMap(), String, int);
			Assert.assertEquals(int, map.typeValues);
		}
		
		//////////////////////////////
		// MapUtil.toString() TESTS //
		//////////////////////////////
		
		[Test]
		public function toString_emptyMap_checkIfReturnedStringMatches_ReturnsTrue(): void
		{
			var map:IMap = new ArrayListMap();
			
			var string:String = MapUtil.toString(map);
			Assert.assertEquals("[]", string);
		}
		
		[Test]
		public function toString_notEmptyMap_checkIfReturnedStringMatches_ReturnsTrue(): void
		{
			var map:IMap = new ArrayListMap();
			map.put("element-2", 2);
			map.put("element-1", 1);
			
			var string:String = MapUtil.toString(map);
			Assert.assertEquals("[element-2=2,element-1=1]", string);
		}
		
	}

}