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
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.iterators.ReadOnlyArrayIterator;
	import org.as3collections.iterators.ReadOnlyListIterator;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ReadOnlyArrayListTests
	{
		public var list:IList;
		
		public function ReadOnlyArrayListTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			list = getList();
		}
		
		[After]
		public function tearDown(): void
		{
			list = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getList():IList
		{
			var array:Array = ["element-1", "element-2", "element-3"];
			return new ReadOnlyArrayList(array);
		}
		
		///////////////////////////////////////////
		// ReadOnlyArrayList() constructor TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function constructor_invalidArgument_ThrowsError(): void
		{
			new ReadOnlyArrayList(null);
		}
		
		//////////////////////////////////////////////
		// ReadOnlyArrayList().allEquatable() TESTS //
		//////////////////////////////////////////////
		
		[Test]
		public function allEquatable_emptyList_ReturnsTrue(): void
		{
			var newList:IList = new ReadOnlyArrayList([]);
			
			var allEquatable:Boolean = newList.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_listWithThreeNotEquatableElements_ReturnsFalse(): void
		{
			var allEquatable:Boolean = list.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		[Test]
		public function allEquatable_listWithThreeEquatableElements_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList:IList = new ReadOnlyArrayList([equatableObject1A, equatableObject2A]);
			
			var allEquatable:Boolean = newList.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		/////////////////////////////////////
		// ReadOnlyArrayList().add() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function add_validArgument_ThrowsError(): void
		{
			list.add("element-4");
		}
		
		////////////////////////////////////////
		// ReadOnlyArrayList().addAll() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function addAll_validArgument_ThrowsError(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-4");
			
			list.addAll(addAllList);
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayList().addAllAt() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function addAllAt_validArgument_ThrowsError(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-4");
			
			list.addAllAt(0, addAllList);
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayList().addAt() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function addAt_validArgument_ThrowsError(): void
		{
			list.addAt(0, "element-4");
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayList().clear() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function clear_simpleCall_ThrowsError(): void
		{
			list.clear();
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayList().clone() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function clone_listWithTwoNotEquatableElements_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var newList1:IList = new ReadOnlyArrayList(["element-1", "element-2"]);
			
			var clonedList:IList = newList1.clone();
			Assert.assertTrue(newList1.equals(clonedList));
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayList().contains() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function contains_argumentContained_ReturnsTrue(): void
		{
			var contains:Boolean = list.contains("element-1");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function contains_argumentNotContained_ReturnsFalse(): void
		{
			var contains:Boolean = list.contains("element-4");
			Assert.assertFalse(contains);
		}
		
		/////////////////////////////////////////////
		// ReadOnlyArrayList().containsAll() TESTS //
		/////////////////////////////////////////////
		
		[Test]
		public function containsAll_argumentContained_ReturnsTrue(): void
		{
			var containsAllList:IList = new ArrayList();
			containsAllList.add("element-1");
			containsAllList.add("element-2");
			
			var contains:Boolean = list.containsAll(containsAllList);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function containsAll_argumentNotContained_ReturnsFalse(): void
		{
			var containsAllList:IList = new ArrayList();
			containsAllList.add("element-1");
			containsAllList.add("element-4");
			
			var contains:Boolean = list.containsAll(containsAllList);
			Assert.assertFalse(contains);
		}
		
		////////////////////////////////////////
		// ReadOnlyArrayList().equals() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothListsAreEqual_ReturnsFalse(): void
		{
			var newList1:IList = new ReadOnlyArrayList(["element-1", "element-2"]);
			var newList2:IList = new ReadOnlyArrayList(["element-2", "element-1"]);
			
			Assert.assertFalse(newList1.equals(newList2));
		}
		
		[Test]
		public function equals_listWithTwoNotEquatableElements_sameElementsAndSameOrder_checkIfBothListsAreEqual_ReturnsTrue(): void
		{
			var newList1:IList = new ReadOnlyArrayList(["element-1", "element-2"]);
			var newList2:IList = new ReadOnlyArrayList(["element-1", "element-2"]);
			
			Assert.assertTrue(newList1.equals(newList2));
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayList().getAt() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function getAt_validArgument_checkIfReturnedObjectIsCorrect_ReturnsTrue(): void
		{
			var element:String = list.getAt(1);
			Assert.assertEquals("element-2", element);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayList().indexOf() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function indexOf_argumentContained_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var index:int = list.indexOf("element-3");
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function indexOf_argumentNotContained_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var index:int = list.indexOf("element-4");
			Assert.assertEquals(-1, index);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayList().isEmpty() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function isEmpty_notEmptyList_ReturnsFalse(): void
		{
			var isEmpty:Boolean = list.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function isEmpty_emptyList_ReturnsTrue(): void
		{
			var emptyList:IList = new ReadOnlyArrayList([]);
			
			var isEmpty:Boolean = emptyList.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayList().iterator() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function iterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IIterator = list.iterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function iterator_simpleCall_checkIfReturnedIteratorIsReadOnly_ReturnsTrue(): void
		{
			var iterator:IIterator = list.iterator();
			
			var isClassPathEqual:Boolean = ReflectionUtil.classPathEquals(ReadOnlyArrayIterator, iterator);
			Assert.assertTrue(isClassPathEqual);
		}
		
		/////////////////////////////////////////////
		// ReadOnlyArrayList().lastIndexOf() TESTS //
		/////////////////////////////////////////////
		
		[Test]
		public function lastIndexOf_argumentContained_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var index:int = list.lastIndexOf("element-3");
			Assert.assertEquals(2, index);
		}
		
		[Test]
		public function lastIndexOf_argumentNotContained_checkIfReturnedIndexIsCorrect_ReturnsTrue(): void
		{
			var index:int = list.lastIndexOf("element-4");
			Assert.assertEquals(-1, index);
		}
		
		//////////////////////////////////////////////
		// ReadOnlyArrayList().listIterator() TESTS //
		//////////////////////////////////////////////
		
		[Test]
		public function listIterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IListIterator = list.listIterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function listIterator_simpleCall_checkIfReturnedIteratorIsReadOnly_ReturnsTrue(): void
		{
			var iterator:IListIterator = list.listIterator();
			
			var isClassPathEqual:Boolean = ReflectionUtil.classPathEquals(ReadOnlyListIterator, iterator);
			Assert.assertTrue(isClassPathEqual);
		}
		
		////////////////////////////////////////
		// ReadOnlyArrayList().remove() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_validArgument_ThrowsError(): void
		{
			list.remove("element-1");
		}
		
		///////////////////////////////////////////
		// ReadOnlyArrayList().removeAll() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeAll_validArgument_ThrowsError(): void
		{
			var removeAllList:IList = new ArrayList();
			removeAllList.add("element-4");
			
			list.removeAll(removeAllList);
		}
		
		//////////////////////////////////////////
		// ReadOnlyArrayList().removeAt() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeAt_validArgument_ThrowsError(): void
		{
			list.removeAt(0);
		}
		
		/////////////////////////////////////////////
		// ReadOnlyArrayList().removeRange() TESTS //
		/////////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeRange_validArgument_ThrowsError(): void
		{
			list.removeRange(0, 1);
		}
		
		///////////////////////////////////////////
		// ReadOnlyArrayList().retainAll() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function retainAll_validArgument_ThrowsError(): void
		{
			var retainAllList:IList = new ArrayList();
			retainAllList.add("element-1");
			retainAllList.add("element-2");
			retainAllList.add("element-3");
			
			list.retainAll(retainAllList);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayList().reverse() TESTS //
		/////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function reverse_validArgument_ThrowsError(): void
		{
			list.reverse();
		}
		
		///////////////////////////////////////
		// ReadOnlyArrayList().setAt() TESTS //
		///////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function setAt_validArgument_ThrowsError(): void
		{
			list.setAt(0, "element-4");
		}
		
		//////////////////////////////////////
		// ReadOnlyArrayList().size() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function size_listWithThreeElements_ReturnsThree(): void
		{
			var size:int = list.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function size_emptyList_ReturnsZero(): void
		{
			var emptyList:IList = new ReadOnlyArrayList([]);
			
			var size:int = emptyList.size();
			Assert.assertEquals(0, size);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayList().subList() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function subList_validArgument_ReturnsValidObject(): void
		{
			var subList:IList = list.subList(0, 1);
			Assert.assertNotNull(subList);
		}
		
		[Test]
		public function subList_validArgument_checkIfSubListIsReadOnly_ReturnsTrue(): void
		{
			var subList:IList = list.subList(0, 1);
			
			var isClassPathEqual:Boolean = ReflectionUtil.classPathEquals(ReadOnlyArrayList, subList);
			Assert.assertTrue(isClassPathEqual);
		}
		
		/////////////////////////////////////////
		// ReadOnlyArrayList().toArray() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function toArray_simpleCall_ReturnsValidObject(): void
		{
			var array:Array = list.toArray();
			Assert.assertNotNull(array);
		}
		
	}

}