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
	public class ICollectionTestsEquatableObject
	{
		public var collection:ICollection;
		
		public function ICollectionTestsEquatableObject()
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
		
		////////////////////////////////////////
		// ICollection().allEquatable() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function allEquatable_collectionWithOneEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			collection.add(equatableObject1A);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_collectionWithThreeEquatableElements_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add(equatableObject3A);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function allEquatable_collectionWithTwoEquatableElementsAndOneNotEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add("element-1");
			collection.add(equatableObject2A);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		/////////////////////////////////
		// ICollection().clone() TESTS //
		/////////////////////////////////
		
		[Test]
		public function clone_collectionWithTwoEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var clonedCollection:ICollection = collection.clone();
			Assert.assertTrue(collection.equals(clonedCollection));
		}
		
		[Test]
		public function clone_collectionWithTwoEquatableElements_cloneButChangeCollection_checkIfBothCollectionsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var clonedCollection:ICollection = collection.clone();
			clonedCollection.remove(equatableObject2A);
			Assert.assertFalse(collection.equals(clonedCollection));
		}
		
		//////////////////////////////////
		// ICollection().equals() TESTS //
		//////////////////////////////////
		
		[Test]
		public function equals_collectionWithTwoEquatableElements_differentCollections_checkIfBothCollectionsAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var collection2:ICollection = getCollection();
			collection2.add(equatableObject2A);
			
			Assert.assertFalse(collection.equals(collection2));
		}
		
		[Test]
		public function equals_collectionWithTwoEquatableElements_equalCollections_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
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
		
		///////////////////////////////
		// ICollection().add() TESTS //
		///////////////////////////////
		
		[Test]
		public function add_validElementEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var added:Boolean = collection.add(equatableObject1A);
			Assert.assertTrue(added);
		}
		
		//////////////////////////////////
		// ICollection().addAll() TESTS //
		//////////////////////////////////
		
		[Test]
		public function addAll_validListSomeElementsEquatableAndSomeNot_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addCollection:ICollection = getCollection();
			addCollection.add("element-1");
			addCollection.add("element-2");
			addCollection.add(equatableObject1A);
			addCollection.add(equatableObject2A);
			
			var added:Boolean = collection.addAll(addCollection);
			Assert.assertTrue(added);
		}
		
		/////////////////////////////////
		// ICollection().clear() TESTS //
		/////////////////////////////////
		
		[Test]
		public function clear_collectionWithOneEquatableElement_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		////////////////////////////////////
		// ICollection().contains() TESTS //
		////////////////////////////////////
		
		[Test]
		public function contains_collectionWithOneEquatableElement_notContainsEquatableElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			
			var contains:Boolean = collection.contains(equatableObject2A);
			Assert.assertFalse(contains);
		}
		
		[Test]
		public function contains_collectionWithOneEquatableElement_containsElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			
			var contains:Boolean = collection.contains(equatableObject1B);
			Assert.assertTrue(contains);
		}
		
		[Test]
		public function contains_collectionWithTwoEquatableElements_containsElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var contains:Boolean = collection.contains(equatableObject2B);
			Assert.assertTrue(contains);
		}
		
		///////////////////////////////////////
		// ICollection().containsAll() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function containsAll_notEmptyCollection_containsSomeButNotAllEquatableElements_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject3A);
			
			var containsCollection:ICollection = getCollection();
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			containsCollection.add(equatableObject1B);
			containsCollection.add(equatableObject2B);
			containsCollection.add(equatableObject3B);
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertFalse(containsAll);
		}
		
		[Test]
		public function containsAll_notEmptyCollection_containsEquatableElements_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add(equatableObject3A);
			
			var containsCollection:ICollection = getCollection();
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			containsCollection.add(equatableObject1B);
			containsCollection.add(equatableObject2B);
			containsCollection.add(equatableObject3B);
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertTrue(containsAll);
		}
		
		///////////////////////////////////
		// ICollection().isEmpty() TESTS //
		///////////////////////////////////
		
		[Test]
		public function isEmpty_collectionWithOneEquatableElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			collection.add(equatableObject1A);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		//////////////////////////////////
		// ICollection().remove() TESTS //
		//////////////////////////////////
		
		[Test]
		public function remove_collectionWithThreeEquatableElements_containsElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add(equatableObject3A);
			
			var removed:Boolean = collection.remove(equatableObject2B);
			Assert.assertTrue(removed);
		}
		
		[Test]
		public function remove_notEmptyCollection_containsEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add(equatableObject3A);
			
			var removed:Boolean = collection.remove(equatableObject3B);
			Assert.assertTrue(removed);
		}
		
		/////////////////////////////////////
		// ICollection().removeAll() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function removeAll_collectionWithTwoEquatableElements_argumentWithThreeEquatableElementsOfWhichTwoAreContained_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			
			var removeCollection:ICollection = getCollection();
			removeCollection.add(equatableObject1A);
			removeCollection.add(equatableObject2A);
			removeCollection.add(equatableObject3A);
			
			collection.add(equatableObject1B);
			collection.add(equatableObject3B);
			
			var changed:Boolean = collection.removeAll(removeCollection);
			Assert.assertTrue(changed);
		}
		
		/////////////////////////////////////
		// ICollection().retainAll() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function retainAll_collectionWithTwoEquatableElements_argumentWithTheTwoCollectionElements_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			
			var changed:Boolean = collection.retainAll(retainAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function retainAll_collectionWithOneEquatableElement_argumentWithTwoEquatableElementsOfWhichNoneIsContained_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			collection.add(equatableObject3A);
			
			var changed:Boolean = collection.retainAll(retainAllCollection);
			Assert.assertTrue(changed);
		}
		
		////////////////////////////////
		// ICollection().size() TESTS //
		////////////////////////////////
		
		[Test]
		public function size_emptyCollection_ReturnsZero(): void
		{
			var size:int = collection.size();
			Assert.assertFalse(size);
		}
		
		///////////////////////////////////
		// ICollection().toArray() TESTS //
		///////////////////////////////////
		
		[Test]
		public function toArray_collectionWithTwoEquatableElements_ReturnsArrayObject(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var array:Array = collection.toArray();
			Assert.assertNotNull(array);
		}
		
		///////////////////////////////
		// ICollection() MIXED TESTS //
		///////////////////////////////
		
		[Test]
		public function add_allEquatable_addEquatableElementAndThenAddNotEquatableElement_checkIfAllEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.add("element-1");
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		[Test]
		public function add_allEquatable_addNotEquatableElementAndThenAddEquatableElement_checkIfAllEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add("element-1");
			collection.add(equatableObject1A);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		[Test]
		public function add_remove_allEquatable_collectionWithThreeElementsOfWhichTwoEquatable_removeNotEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add("element-1");
			
			collection.remove("element-1");
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function add_isEmpty_addEquatableElement_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			collection.add(equatableObject1A);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function add_clear_isEmpty_addEquatableElementAndThenClear_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.clear();
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function add_size_addEquatableElement_checkIfCollectionSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			collection.add(equatableObject1A);
			
			var size:int = collection.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function addAll_isEmpty_argumentWithTwoEquatableElements_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add(equatableObject1A);
			addAllCollection.add(equatableObject2A);
			
			collection.addAll(addAllCollection);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function addAll_allEquatable_validArgumentWithTwoEquatableElements_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add(equatableObject1A);
			addAllCollection.add(equatableObject2A);
			
			collection.addAll(addAllCollection);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function addAll_allEquatable_collectionContainsTwoEquatableElements_thenAddAllCollectionArgumentWithOneNotEquatableElements_checkIfAllEquatable_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var addAllCollection:ICollection = getCollection();
			addAllCollection.add("element-1");
			
			collection.addAll(addAllCollection);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertFalse(allEquatable);
		}
		
		[Test]
		public function remove_isEmpty_addOneEquatableElementAndThenRemoveIt_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.remove(equatableObject1B);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function remove_isEmpty_addTwoEquatableElementsAndThenRemoveOne_checkIfCollectionIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.remove(equatableObject1B);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function remove_size_addTwoEquatableElementsAndThenRemoveOne_checkIfCollectionSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.remove(equatableObject1B);
			
			var size:int = collection.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function removeAll_isEmpty_collectionWithTwoEquatableElements_argumentWithTheTwoElements_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeCollection:ICollection = getCollection();
			removeCollection.add(equatableObject1A);
			removeCollection.add(equatableObject2A);
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			
			collection.removeAll(removeCollection);
			
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function removeAll_size_collectionWithTwoEquatableElements_argumentWithTheTwoElements_checkIfCollectionSizeIsZero_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var removeCollection:ICollection = getCollection();
			removeCollection.add(equatableObject1A);
			removeCollection.add(equatableObject2A);
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			
			collection.removeAll(removeCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function removeAll_allEquatable_collectionWithThreeElementsOfWhichTwoEquatable_removeNotEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add("element-1");
			
			var removeCollection:ICollection = getCollection();
			removeCollection.add("element-1");
			
			collection.removeAll(removeCollection);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function retainAll_size_collectionWithFourEquatableElements_argumentWithThreeContainedElements_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3B:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			collection.add(equatableObject3B);
			collection.add(equatableObject4B);
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_size_collectionWithThreeEquatableElements_argumentWithFourElementsOfWhichThreeContained_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			retainAllCollection.add(equatableObject4A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			collection.add(equatableObject4B);
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_size_collectionWithFourEquatableElements_argumentWithFourElementsOfWhichThreeContained_checkIfCollectionSizeIsThree_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject3A:EquatableObject = new EquatableObject("equatable-object-3");
			var equatableObject4A:EquatableObject = new EquatableObject("equatable-object-4");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			retainAllCollection.add(equatableObject3A);
			retainAllCollection.add(equatableObject4A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			var equatableObject4B:EquatableObject = new EquatableObject("equatable-object-4");
			var equatableObject8B:EquatableObject = new EquatableObject("equatable-object-8");
			
			collection.add(equatableObject1B);
			collection.add(equatableObject2B);
			collection.add(equatableObject4B);
			collection.add(equatableObject8B);
			
			collection.retainAll(retainAllCollection);
			
			var size:int = collection.size();
			Assert.assertEquals(3, size);
		}
		
		[Test]
		public function retainAll_allEquatable_collectionWithThreeElementsOfWhichTwoEquatable_removeNotEquatableElement_checkIfAllEquatable_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			collection.add("element-1");
			
			var retainAllCollection:ICollection = getCollection();
			retainAllCollection.add(equatableObject1A);
			retainAllCollection.add(equatableObject2A);
			
			collection.retainAll(retainAllCollection);
			
			var allEquatable:Boolean = collection.allEquatable;
			Assert.assertTrue(allEquatable);
		}
		
		[Test]
		public function toArray_collectionWithTwoEquatableElements_checkIfReturnedArrayLengthIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var array:Array = collection.toArray();
			
			var length:int = array.length;
			Assert.assertEquals(2, length);
		}
		
	}

}