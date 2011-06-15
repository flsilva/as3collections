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
	import org.as3collections.ICollectionTestsEquatableObject;
	import org.as3collections.IList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IListTestsEquatableObject extends ICollectionTestsEquatableObject
	{
		public function get list():IList { return collection as IList; }
		
		public function IListTestsEquatableObject ()
		{
			
		}
		
		//////////////////////////////////
		// IList().allEquatable() TESTS //
		//////////////////////////////////
		
		[Test]
		public function allEquatable_listWithOneEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			list.addAt(0, equatableObject1A);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_listWithThreeEquatableElements_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.addAt(0, equatableObject1A);
			list.addAt(1, equatableObject2A);
			list.addAt(2, equatableObject3A);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_listWithTwoEquatableElementsAndOneNotEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.addAt(0, equatableObject1A);
			list.addAt(1, "element-1");
			list.addAt(2, equatableObject2A);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		///////////////////////////
		// IList().clone() TESTS //
		///////////////////////////
		
		[Test]
		public function clone_listWithTwoEquatableElements_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			
			var clonedList:IList = list.clone();
			Assert.assertTrue(list.equals(clonedList));
		}
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_cloneButChangeElementsOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			
			var clonedList:IList = list.clone();
			clonedList.reverse();
			
			Assert.assertFalse(list.equals(clonedList));
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
		
		///////////////////////////
		// IList().getAt() TESTS //
		///////////////////////////
		
		[Test]
		public function getAt_addedOneEquatableElement_getAtIndexZero_checkIfReturnedElementMatches_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			list.add(equatableObject1A);
			
			var element:EquatableObject = list.getAt(0);
			Assert.assertEquals(equatableObject1A, element);
		}
		
		[Test]
		public function getAt_addedThreeEquatableElements_boundaryCondition_checkIfReturnedElementMatches_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var element:EquatableObject = list.getAt(2);
			Assert.assertEquals(equatableObject3A, element);
		}
		
		/////////////////////////////
		// IList().indexOf() TESTS //
		/////////////////////////////
		
		[Test]
		public function indexOf_listWithThreeEquatableElements_indexOfElementNotAdded_ReturnsNegative(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var index:int = list.indexOf(equatableObject4A);
			Assert.assertEquals(-1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeEquatableElements_indexOfFirtElement_ReturnsZero(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.indexOf(equatableObject1B);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOf_listWithThreeEquatableElements_indexOfSecondElement_ReturnsOne(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var index:int = list.indexOf(equatableObject2B);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeEquatableElements_indexOfThirdElement_ReturnsTwo(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var index:int = list.indexOf(equatableObject3B);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalEquatableElements_indexOf_ReturnsZero(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.indexOf(equatableObject1D);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalEquatableElements_indexOfFromIndexOne_ReturnsOne(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.indexOf(equatableObject1D, 1);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function indexOf_listWithThreeIdenticalEquatableElements_indexOfFromIndexTwo_ReturnsTwo(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.indexOf(equatableObject1D, 2);
			Assert.assertEquals(2, index);
		}
		
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
		public function lastIndexOf_listWithThreeEquatableElements_lastIndexOfFirtElement_ReturnsZero(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.lastIndexOf(equatableObject1B);
			Assert.assertEquals(0, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalEquatableElements_lastIndexOf_ReturnsTwo(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.lastIndexOf(equatableObject1D);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalEquatableElements_lastIndexOfFromIndexOne_ReturnsOne(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.lastIndexOf(equatableObject1D, 1);
			Assert.assertEquals(1, index);
		}
		
		[Test]
		public function lastIndexOf_listWithThreeIdenticalEquatableElements_lastIndexOfFromIndexZero_ReturnsZero(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1C:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			list.add(equatableObject1B);
			list.add(equatableObject1C);
			
			var equatableObject1D:EquatableObject = new EquatableObject("equatable-object-1");
			
			var index:int = list.lastIndexOf(equatableObject1D, 0);
			Assert.assertEquals(0, index);
		}
		
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
		
		///////////////////////////
		// IList().setAt() TESTS //
		///////////////////////////
		
		[Test]
		public function setAt_notEmptyList_validArgumentEquatable_boundaryCondition_checkIfListContainsAddedElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			list.setAt(2, equatableObject4A);
			
			var contains:Boolean = list.contains(equatableObject4A);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function setAt_notEmptyList_validArgumentEquatable_boundaryCondition_checkIfListNotContainsReplacedElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			list.setAt(2, equatableObject4A);
			
			var contains:Boolean = list.contains(equatableObject3A);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function setAt_notEmptyList_validArgumentEquatable_boundaryCondition_checkIfReturnedCorrectElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add(equatableObject3A);
			
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var removedElement:String = list.setAt(1, equatableObject4A);
			Assert.assertTrue(equatableObject2A, removedElement);
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
		
		[Test]
		public function removeRange_allEquatable_listWithThreeElementsOfWhichTwoEquatable_removeNotEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add("element-1");
			
			list.removeRange(2, 3);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function setAt_allEquatable_listWithTwoElementsEquatable_thenSetAtNotEquatableElement_checkIfAllEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			
			list.setAt(0, "element-1");
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		[Test]
		public function setAt_allEquatable_listWithThreeElementsOfWhichTwoEquatable_setAtEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			list.add("element-1");
			
			list.setAt(2, equatableObject3A);
			
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
	}

}