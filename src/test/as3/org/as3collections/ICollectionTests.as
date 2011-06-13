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
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ICollectionTests
	{
		public var collection:ICollection;
		
		public function ICollectionTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			collection = getCollection();
		}
		
		[After]
		public function tearDown(): void
		{
			collection = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getCollection():ICollection
		{
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		///////////////////////////////////////////////
		// AbstractCollection().allEquatable() TESTS //
		///////////////////////////////////////////////
		
		[Test]
		public function allEquatable_emptyCollection_ReturnsTrue(): void
		{
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_notEmptyCollection_notContainEquatableElement_ReturnsFalse(): void
		{
			collection.add("element-1");
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		//////////////////////////////////////
		// AbstractCollection().add() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function add_validElementNotEquatable_ReturnsTrue(): void
		{
			var added:Boolean = collection.add("element-1");
			Assert.assertTrue(added);
		}
		
		/////////////////////////////////////////
		// AbstractCollection().addAll() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function addAll_validListNoneElementEquatable_ReturnsTrue(): void
		{
			var addCollection:ICollection = getCollection();
			addCollection.add("element-1");
			addCollection.add("element-2");
			
			var added:Boolean = collection.addAll(addCollection);
			Assert.assertTrue(added);
		}
		
		////////////////////////////////////////
		// AbstractCollection().clear() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function clear_emptyCollection_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function clear_collectionWithOneNotEquatableElement_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		///////////////////////////////////////////
		// AbstractCollection().contains() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function contains_emptyCollection_ReturnsFalse(): void
		{
			var contains:Boolean = collection.contains("element-1");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function contains_notEmptyCollection_notContainsNotEquatableElement_ReturnsFalse(): void
		{
			collection.add("element-1");
			
			var contains:Boolean = collection.contains("element-2");
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function contains_collectionWithOnlyOneNotEquatableElement_containsElement_ReturnsTrue(): void
		{
			collection.add("element-1");
			
			var contains:Boolean = collection.contains("element-1");
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function contains_collectionWithTwoNotEquatableElement_containsElement_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var contains:Boolean = collection.contains("element-2");
			Assert.assertTrue(contains);
		}
		
		//////////////////////////////////////////////
		// AbstractCollection().containsAll() TESTS //
		//////////////////////////////////////////////
		
		[Test]
		public function containsAll_emptyCollection_ReturnsFalse(): void
		{
			var containsCollection:ICollection = getCollection();
			containsCollection.add("element-1");
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertFalse(containsAll);
		}
		
		[Test]
		public function containsAll_notEmptyCollection_containsSomeButNotAllNotEquatableElements_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-3");
			
			var containsCollection:ICollection = getCollection();
			containsCollection.add("element-1");
			containsCollection.add("element-2");
			containsCollection.add("element-3");
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertFalse(containsAll);
		}
		
		[Test]
		public function containsAll_notEmptyCollection_containsNotEquatableElements_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			collection.add("element-3");
			
			var containsCollection:ICollection = getCollection();
			containsCollection.add("element-1");
			containsCollection.add("element-2");
			containsCollection.add("element-3");
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertTrue(containsAll);
		}
		
		//////////////////////////////////////////
		// AbstractCollection().isEmpty() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function isEmpty_emptyCollection_ReturnsTrue(): void
		{
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function isEmpty_collectionWithOneNotEquatableElement_ReturnsFalse(): void
		{
			collection.add("element-1");
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		/////////////////////////////////////////
		// AbstractCollection().remove() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function remove_emptyCollection_ReturnsFalse(): void
		{
			var removed:Boolean = collection.remove("element-1");
			Assert.assertFalse(removed);
		}
		
		[Test]
		public function remove_collectionWithThreeNotEquatableElements_containsElement_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			collection.add("element-3");
			
			var removed:Boolean = collection.remove("element-2");
			Assert.assertTrue(removed);
		}
		
		////////////////////////////////////////////
		// AbstractCollection().removeAll() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function removeAll_emptyCollection_ReturnsFalse(): void
		{
			var containsCollection:ICollection = getCollection();
			containsCollection.add("element-1");
			
			var changed:Boolean = collection.removeAll(containsCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function removeAll_collectionWithTwoNotEquatableElements_argumentWithThreeNotEquatableElementsOfWhichTwoAreContained_ReturnsTrue(): void
		{
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-1");
			removeCollection.add("element-2");
			removeCollection.add("element-3");
			
			collection.add("element-1");
			collection.add("element-3");
			
			var changed:Boolean = collection.removeAll(removeCollection);
			Assert.assertTrue(changed);
		}
		
		////////////////////////////////////////////
		// AbstractCollection().retainAll() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function retainAll_collectionWithTwoNotEquatableElements_argumentWithTheTwoCollectionElements_ReturnsFalse(): void
		{
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			
			collection.add("element-1");
			collection.add("element-2");
			
			var changed:Boolean = collection.retainAll(retainAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function retainAll_collectionWithOneNotEquatableElement_argumentWithTwoNotEquatableElementsOfWhichNoneIsContained_ReturnsTrue(): void
		{
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			
			collection.add("element-3");
			
			var changed:Boolean = collection.retainAll(retainAllCollection);
			Assert.assertTrue(changed);
		}
		
		///////////////////////////////////////
		// AbstractCollection().size() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function size_emptyCollection_ReturnsZero(): void
		{
			var size:int = collection.size();
			Assert.assertFalse(size);
		}
		
		//////////////////////////////////////////
		// AbstractCollection().toArray() TESTS //
		//////////////////////////////////////////
		
		[Test]
		public function toArray_emptyCollection_ReturnsValidArrayObject(): void
		{
			var array:Array = collection.toArray();
			Assert.assertNotNull(array);
		}
		
		[Test]
		public function toArray_collectionWithTwoNotEquatableElements_ReturnsArrayObject(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var array:Array = collection.toArray();
			Assert.assertNotNull(array);
		}
		
		//////////////////////////////////////
		// AbstractCollection() MIXED TESTS //
		//////////////////////////////////////
		
		[Test]
		public function add_isEmpty_addNotEquatableElement_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			collection.add("element-1");
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function add_clear_isEmpty_addNotEquatableElementAndThenClear_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function add_size_addNotEquatableElement_checkIfCollectionSizeIsOne_ReturnsTrue(): void
		{
			collection.add("element-1");
			
			var size:int = collection.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function addAll_isEmpty_argumentWithTwoNotEquatableElements_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add("element-1");
			addAllCollection.add("element-2");
			
			collection.addAll(addAllCollection);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function addAll_clear_isEmpty_validArgument_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add("element-1");
			addAllCollection.add("element-2");
			
			collection.addAll(addAllCollection);
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function addAll_size_validArgumentWithTwoElements_checkIfCollectionSizeIsTwo_ReturnsTrue(): void
		{
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add("element-1");
			addAllCollection.add("element-2");
			
			collection.addAll(addAllCollection);
			var size:int = collection.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function remove_isEmpty_addOneNotEquatableElementAndThenRemoveIt_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.remove("element-1");
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function remove_isEmpty_addTwoNotEquatableElementsAndThenRemoveOne_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			collection.remove("element-1");
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function remove_size_addTwoNotEquatableElementsAndThenRemoveOne_checkIfCollectionSizeIsOne_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			collection.remove("element-1");
			
			var size:int = collection.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function removeAll_isEmpty_collectionWithTwoNotEquatableElements_argumentWithTheTwoElements_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-1");
			removeCollection.add("element-2");
			
			collection.add("element-1");
			collection.add("element-2");
			
			collection.removeAll(removeCollection);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeAll_size_collectionWithTwoNotEquatableElements_argumentWithTheTwoElements_checkIfCollectionSizeIsZero_ReturnsTrue(): void
		{
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-1");
			removeCollection.add("element-2");
			
			collection.add("element-1");
			collection.add("element-2");
			
			collection.removeAll(removeCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function removeAll_isEmpty_collectionWithTwoElements_argumentWithOneElement_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-2");
			
			collection.add("element-1");
			collection.add("element-3");
			
			collection.removeAll(removeCollection);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function removeAll_size_collectionWithTwoElements_argumentWithOneElement_checkIfCollectionSizeIsOne_ReturnsTrue(): void
		{
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-2");
			
			collection.add("element-1");
			collection.add("element-2");
			
			collection.removeAll(removeCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function retainAll_size_collectionWithFourNotEquatableElements_argumentWithThreeContainedElements_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			
			collection.add("element-1");
			collection.add("element-2");
			collection.add("element-3");
			collection.add("element-4");
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_size_collectionWithThreeNotEquatableElements_argumentWithFourElementsOfWhichThreeContained_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			retainAllCollection.add("element-4");
			
			collection.add("element-1");
			collection.add("element-2");
			collection.add("element-4");
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_size_collectionWithFourNotEquatableElements_argumentWithFourElementsOfWhichThreeContained_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			retainAllCollection.add("element-3");
			retainAllCollection.add("element-4");
			
			collection.add("element-1");
			collection.add("element-2");
			collection.add("element-4");
			collection.add("element-8");
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function toArray_collectionWithTwoNotEquatableElements_checkIfReturnedArrayLengthIsTwo_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var array:Array = collection.toArray();
			
			var length:int = array.length;
			Assert.assertEquals(2, length);
		}
		
	}

}