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
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class MapEntryTests
	{
		
		public function MapEntryTests()
		{
			
		}
		
		//////////////////////////
		// MapEntry().key TESTS //
		//////////////////////////
		
		[Test]
		public function key_simpleCall_checkIfReturnedCorrectKey_ReturnsTrue(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			Assert.assertEquals("element-1", entry.key);
		}
		
		////////////////////////////
		// MapEntry().value TESTS //
		////////////////////////////
		
		[Test]
		public function value_simpleCall_checkIfReturnedCorrectKey_ReturnsTrue(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			Assert.assertEquals(1, entry.value);
		}
		
		//////////////////////////////
		// MapEntry().clone() TESTS //
		//////////////////////////////
		
		[Test]
		public function clone_simpleCall_ReturnsValidInstance(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			
			var clonedEntry:IMapEntry = entry.clone();
			Assert.assertNotNull(clonedEntry);
		}
		
		[Test]
		public function clone_simpleCall_checkIfReturnedCloneIsEqual_ReturnsTrue(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			var clonedEntry:IMapEntry = entry.clone();
			
			var equal:Boolean = entry.equals(clonedEntry);
			Assert.assertTrue(equal);
		}
		
		///////////////////////////////
		// MapEntry().equals() TESTS //
		///////////////////////////////
		
		[Test]
		public function equals_twoEqualEntriesWithNotEquatableKeyValue_ReturnsTrue(): void
		{
			var entry1:IMapEntry = new MapEntry("element-1", 1);
			var entry2:IMapEntry = new MapEntry("element-1", 1);
			
			var equal:Boolean = entry1.equals(entry2);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function equals_entriesWithDifferentNotEquatableKeys_ReturnsFalse(): void
		{
			var entry1:IMapEntry = new MapEntry("element-1", 1);
			var entry2:IMapEntry = new MapEntry("element-2", 1);
			
			var equal:Boolean = entry1.equals(entry2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_entriesWithDifferentNotEquatableValues_ReturnsFalse(): void
		{
			var entry1:IMapEntry = new MapEntry("element-1", 1);
			var entry2:IMapEntry = new MapEntry("element-1", 2);
			
			var equal:Boolean = entry1.equals(entry2);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_twoEqualEntriesWithEquatableKeys_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var entry1:IMapEntry = new MapEntry(equatableObject1A, 1);
			var entry2:IMapEntry = new MapEntry(equatableObject1B, 1);
			
			var equal:Boolean = entry1.equals(entry2);
			Assert.assertTrue(equal);
		}
		
		[Test]
		public function equals_twoEqualEntriesWithEquatableValues_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var entry1:IMapEntry = new MapEntry(1, equatableObject1A);
			var entry2:IMapEntry = new MapEntry(1, equatableObject1B);
			
			var equal:Boolean = entry1.equals(entry2);
			Assert.assertTrue(equal);
		}
		
		/////////////////////////////////
		// MapEntry().toString() TESTS //
		/////////////////////////////////
		
		[Test]
		public function toString_simpleCall_ReturnsValidString(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			
			var string:String = (entry as MapEntry).toString();
			Assert.assertNotNull(string);
		}
		
		[Test]
		public function toString_simpleCall_checkIfReturnedStringIsCorrect_ReturnsTrue(): void
		{
			var entry:IMapEntry = new MapEntry("element-1", 1);
			
			var string:String = (entry as MapEntry).toString();
			Assert.assertEquals("element-1=1", string);
		}
		
	}

}