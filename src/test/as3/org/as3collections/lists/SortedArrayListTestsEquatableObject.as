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
	import org.as3collections.ISortedList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class SortedArrayListTestsEquatableObject extends IListTestsEquatableObject
	{
		
		public function get sortedList():ISortedList { return collection as ISortedList; }
		
		public function SortedArrayListTestsEquatableObject()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// when using this method in tests
			// it uses the default sort behavior
			// which is sort objects by String using Object.toString()
			
			return new SortedArrayList();
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_listWithTwoEquatableElements_sameElementsAddedInSameOrderButListsCreatedWithDifferentSortOptions_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			sortedList.options = 0;//ASCENDING
			sortedList.add(equatableObject1A);
			sortedList.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var sortedList2:ISortedList = new SortedArrayList();
			sortedList2.options = Array.DESCENDING;
			sortedList2.add(equatableObject1B);
			sortedList2.add(equatableObject2B);
			
			Assert.assertFalse(sortedList.equals(sortedList2));
		}
		
		[Test]
		public function equals_listWithTwoEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var list2:ICollection = getCollection();
			list2.add(equatableObject2B);
			list2.add(equatableObject1B);
			
			Assert.assertTrue(list.equals(list2));
		}
		
		///////////////////////////
		// IList().getAt() TESTS //
		///////////////////////////
		
		[Test]
		public function getAt_listWithEquatableElements_stringDescendingOrder_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			sortedList.options = Array.DESCENDING;
			
			sortedList.add(equatableObject2A);
			sortedList.add(equatableObject1A);
			sortedList.add(equatableObject3A);
			
			var element:EquatableObject = sortedList.getAt(0);
			Assert.assertEquals(equatableObject3A, element);
		}
		
		/////////////////////////////
		// IList().indexOf() TESTS //
		/////////////////////////////
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalEquatableElements_indexOfFromIndexThree_ReturnsThree(): void
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
			
			var index:int = list.indexOf(equatableObject3A, 2);
			Assert.assertEquals(2, index);
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
			
			var index:int = list.lastIndexOf(equatableObject3A);
			Assert.assertEquals(3, index);
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
			
			var index:int = list.lastIndexOf(equatableObject3A, 2);
			Assert.assertEquals(2, index);
		}
		
		/////////////////////////
		// IList() MIXED TESTS //
		/////////////////////////
		
		[Test]
		public function addAt_getAt_listWithOneNotEquatableElement_addAtZeroNotEquatable_checkIfElementWasAddedAtZeroIndex_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.addAt(0, equatableObject2A);
			
			var element1:String = list.getAt(0);
			Assert.assertEquals(equatableObject1A, element1);
		}
		
	}

}