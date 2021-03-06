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
	import org.as3utils.ReflectionUtil;
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.IListTests;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayListTests extends IListTests
	{
		
		public function ArrayListTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			return new ArrayList();
		}
		
		///////////////////////////////////
		// ArrayList() constructor TESTS //
		///////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newList:IList = new ArrayList(["element-1", "element-2"]);
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newList:IList = new ArrayList(["element-1", "element-2"]);
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////
		// ArrayList().addAt() TESTS //
		///////////////////////////////
		
		[Test]
		public function addAt_listWithOneNotEquatableElement_addAtZeroNotEquatable_checkIfElementWasAddedAtZeroIndex_ReturnsTrue(): void
		{
			list.add("element-1");
			list.addAt(0, "element-2");
			
			var element2:String = list.getAt(0);
			Assert.assertEquals("element-2", element2);
		}
		
		///////////////////////////////
		// ArrayList().clone() TESTS //
		///////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsArrayList_ReturnsTrue(): void
		{
			var clonedList:IList = collection.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(ArrayList, clonedList);
			Assert.assertTrue(isCorrectType);
		}
		
		////////////////////////////////////////
		// ArrayList().ensureCapacity() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function ensureCapacity_checkIfSizeMatches_ReturnsTrue(): void
		{
			(list as ArrayList).ensureCapacity(5);
			
			var size:int = list.size();
			Assert.assertEquals(5, size);
		}
		
		[Test]
		public function ensureCapacity_tryToSetAt_ReturnsTrue(): void
		{
			(list as ArrayList).ensureCapacity(5);
			
			var added:Boolean = list.addAt(4, "element-1");
			Assert.assertTrue(added);
		}
		
		////////////////////////////////
		// ArrayList().equals() TESTS //
		////////////////////////////////
		
		[Test]
		public function equals_twoEmptyLists_oneListIsReadOnly_ReturnsFalse(): void
		{
			var readOnlyList:IList = new ReadOnlyArrayList([]);
			
			var equal:Boolean = collection.equals(readOnlyList);
			Assert.assertFalse(equal);
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var collection2:ICollection = getCollection();
			collection2.add("element-2");
			collection2.add("element-1");
			
			Assert.assertFalse(collection.equals(collection2));
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var collection2:ICollection = getCollection();
			collection2.add("element-1");
			collection2.add("element-2");
			
			Assert.assertTrue(collection.equals(collection2));
		}
		
		/////////////////////////////////
		// ArrayList().indexOf() TESTS //
		/////////////////////////////////
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalNotEquatableElements_indexOfFromIndexTwo_ReturnsTwo(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.indexOf("element-3", 2);
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_listWithFiveIdenticalAndNotIdenticalNotEquatableElements_indexOfFromIndexThree_ReturnsFour(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.indexOf("element-3", 3);
			Assert.assertEquals(4, index);
		}
		
		/////////////////////////////////////
		// ArrayList().lastIndexOf() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalNotEquatableElements_lastIndexOf_ReturnsCorrectIndex(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.lastIndexOf("element-3");
			Assert.assertEquals(4, index);
		}
		
		[Test]
		public function lastIndexOf_listWithIdenticalAndNotIdenticalNotEquatableElements_lastIndexOfFromIndex_ReturnsCorrectIndex(): void
		{
			list.add("element-1");
			list.add("element-2");
			list.add("element-3");
			list.add("element-4");
			list.add("element-3");
			list.add("element-5");
			
			var index:int = list.lastIndexOf("element-3", 3);
			Assert.assertEquals(2, index);
		}
		
		//////////////////////////////////
		// ArrayList().toString() TESTS //
		//////////////////////////////////
		
		[Test]
		public function toString_emptyList_ReturnsValidString(): void
		{
			Assert.assertEquals("[]", list);
		}
		
		[Test]
		public function toString_notEmptyList_ReturnsValidString(): void
		{
			list.add("element-2");
			list.add(3);
			
			Assert.assertEquals("[element-2,3]", list);
		}
		
	}

}