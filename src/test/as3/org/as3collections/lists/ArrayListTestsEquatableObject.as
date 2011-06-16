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

package org.as3collections.lists
{
	import org.as3collections.EquatableObject;
	import org.as3collections.ICollection;
	import org.as3collections.IListTestsEquatableObject;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayListTestsEquatableObject extends IListTestsEquatableObject
	{
		
		public function ArrayListTestsEquatableObject()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			return new ArrayList();
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_equalElementsButDifferentOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var collection2:ICollection = getCollection();
			collection2.add(equatableObject2A);
			collection2.add(equatableObject1A);
			
			Assert.assertFalse(collection.equals(collection2));
		}
		
		[Test]
		public function equals_listWithTwoEquatableElements_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var collection2:ICollection = getCollection();
			collection2.add(equatableObject1B);
			collection2.add(equatableObject2B);
			
			Assert.assertTrue(collection.equals(collection2));
		}
		
		/////////////////////////////
		// IList().indexOf() TESTS //
		/////////////////////////////
		
		[Test]
		public function indexOf_listWithIdenticalAndNotIdenticalEquatableElements_indexOfFromIndexTwo_ReturnsTwo(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject5A:EquatableObject = new EquatableObject("equatable-object-5");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			list.add(equatableObject4A);
			list.add(equatableObject3A);
			list.add(equatableObject5A);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var index:int = list.indexOf(equatableObject3B, 2);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithIdenticalAndNotIdenticalEquatableElements_indexOfFromIndexThree_ReturnsFour(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject5A:EquatableObject = new EquatableObject("equatable-object-5");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			list.add(equatableObject4A);
			list.add(equatableObject3A);
			list.add(equatableObject5A);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var index:int = list.indexOf(equatableObject3B, 3);
			Assert.assertEquals(4, index);
		}
		
		/////////////////////////////////
		// IList().lastIndexOf() TESTS //
		/////////////////////////////////
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalEquatableElements_lastIndexOf_ReturnsCorrectIndex(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject5A:EquatableObject = new EquatableObject("equatable-object-5");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			list.add(equatableObject4A);
			list.add(equatableObject3A);
			list.add(equatableObject5A);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var index:int = list.lastIndexOf(equatableObject3B);
			Assert.assertEquals(4, index);
		}
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalEquatableElements_lastIndexOfFromIndex_ReturnsCorrectIndex(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject5A:EquatableObject = new EquatableObject("equatable-object-5");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			list.add(equatableObject4A);
			list.add(equatableObject3A);
			list.add(equatableObject5A);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var index:int = list.lastIndexOf(equatableObject3B, 3);
			Assert.assertEquals(2, index);
		}
		
		/////////////////////////
		// IList() MIXED TESTS //
		/////////////////////////
		
		[Test]
		public function addAt_removeAt_allEquatable_listWithThreeElementsOfWhichTwoEquatable_removeNotEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add("element-1");
			
			list.removeAt(2);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
	}

}