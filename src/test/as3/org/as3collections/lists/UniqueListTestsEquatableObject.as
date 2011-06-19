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
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.UniqueCollectionTestsEquatableObject;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueListTestsEquatableObject extends UniqueCollectionTestsEquatableObject
	{
		public function get list():IList { return collection as IList; };
		
		public function UniqueListTestsEquatableObject()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// using an ArrayList object
			// instead of a fake to simplify tests
			// since ArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in ArrayList may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the ArrayList object
			return new UniqueList(new ArrayList());
		}
		
		////////////////////////////////////
		// UniqueList() constructor TESTS //
		////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateEquatableElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList:IList = new UniqueList(new ArrayList([equatableObject1A, equatableObject2A]));
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateEquatableElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList:IList = new UniqueList(new ArrayList([equatableObject1A, equatableObject2A]));
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function constructor_argumentWithTwoDuplicateEquatableElements_checkIfSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var newList:IList = new UniqueList(new ArrayList([equatableObject1A, equatableObject1B]));
			
			var size:int = newList.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////////////
		// UniqueList().addAllAt() TESTS //
		///////////////////////////////////
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1A);
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateEquatableElementAndOneDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1B);
			addAllList.add(equatableObject2B);
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithTwoDuplicateEquatableElements_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			list.add(equatableObject1A);
			list.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1B);
			addAllList.add(equatableObject2B);
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertFalse(changed);
		}
		
		////////////////////////////////
		// UniqueList().addAt() TESTS //
		////////////////////////////////
		
		[Test]
		public function addAt_notDuplicateEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var added:Boolean = list.addAt(0, equatableObject1A);
			Assert.assertTrue(added);
		}
		
		[Test]
		public function addAt_duplicateEquatableElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			
			var added:Boolean = list.addAt(0, equatableObject1A);
			Assert.assertFalse(added);
		}
		
		/////////////////////////////////
		// UniqueList().equals() TESTS //
		/////////////////////////////////
		
		[Test]
		public function equals_listWithTwoEquatableElements_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList1:ICollection = getCollection();
			newList1.add(equatableObject1A);
			newList1.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var list2:ICollection = getCollection();
			list2.add(equatableObject1B);
			list2.add(equatableObject2B);
			
			Assert.assertTrue(newList1.equals(list2));
		}
		
		///////////////////////////////////////
		// UniqueList().listIterator() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function listIterator_simpleCall_tryToAddDuplicateEquatableElementThroughIListIterator_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			list.add(equatableObject1A);
			var iterator:IListIterator = list.listIterator();
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var added:Boolean = iterator.add(equatableObject1B);
			Assert.assertFalse(added);
		}
		
	}

}