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
	import org.as3collections.lists.ArrayList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedCollectionTests
	{
		public var collection:ICollection;
		
		public function TypedCollectionTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			collection = getCollection(String);
		}
		
		[After]
		public function tearDown(): void
		{
			collection = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getCollection(type:Class):TypedCollection
		{
			// using an ArrayList object
			// instead of a fake to simplify tests
			// since ArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in ArrayList may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the ArrayList object
			return new TypedCollection(new ArrayList(), type);
		}
		
		//////////////////////////////////
		// TypedCollection().type TESTS //
		//////////////////////////////////
		
		[Test]
		public function type_createInstanceCheckType_ReturnsCorrectType(): void
		{
			var newCollection:TypedCollection = getCollection(Array);
			
			var type:Class = newCollection.type;
			Assert.assertEquals(Array, type);
		}
		
		///////////////////////////////////
		// TypedCollection().add() TESTS //
		///////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function add_invalidElementType_ThrowsError(): void
		{
			collection.add(1);
		}
		
		[Test]
		public function add_validArgument_ReturnsTrue(): void
		{
			var added:Boolean = collection.add("element-1");
			Assert.assertTrue(added);
		}
		
		//////////////////////////////////////
		// TypedCollection().addAll() TESTS //
		//////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function addAll_invalidArgument_ThrowsError(): void
		{
			collection.addAll(null);
		}
		
		[Test]
		public function addAll_emptyArgument_ReturnsFalse(): void
		{
			var addAllList:IList = new ArrayList();
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function addAll_argumentWithOneValidElement_ReturnsTrue(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function addAll_argumentWithOneInvalidElement_ThrowsError(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add(1);
			
			collection.addAll(addAllList);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function addAll_argumentWithOneValidElementAndOneInvalid_ThrowsError(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add(1);
			
			collection.addAll(addAllList);
		}
		
		/////////////////////////////////////
		// TypedCollection().clear() TESTS //
		/////////////////////////////////////
		
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
		
		/////////////////////////////////////
		// TypedCollection().clone() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var clonedCollection:ICollection = collection.clone();
			Assert.assertTrue(collection.equals(clonedCollection));
		}
		
		///////////////////////////////////////////
		// TypedCollection().containsAll() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function containsAll_notEmptyCollection_containsSomeButNotAllNotEquatableElements_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-3");
			
			var containsCollection:ICollection = getCollection(String);
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
			
			var containsCollection:ICollection = getCollection(String);
			containsCollection.add("element-1");
			containsCollection.add("element-2");
			containsCollection.add("element-3");
			
			var containsAll:Boolean = collection.containsAll(containsCollection);
			Assert.assertTrue(containsAll);
		}
		
		//////////////////////////////////////
		// TypedCollection().remove() TESTS //
		//////////////////////////////////////
		
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
		
		/////////////////////////////////////////
		// TypedCollection().removeAll() TESTS //
		/////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function removeAll_invalidArgument_ThrowsError(): void
		{
			collection.removeAll(null);
		}
		
		[Test]
		public function removeAll_emptyCollection_ReturnsFalse(): void
		{
			var removeAllCollection:ICollection = getCollection(String);
			removeAllCollection.add("element-1");
			
			var changed:Boolean = collection.removeAll(removeAllCollection);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function removeAll_collectionWithTwoNotEquatableElements_argumentWithThreeNotEquatableElementsOfWhichTwoAreContained_ReturnsTrue(): void
		{
			var removeCollection:ICollection = getCollection(String);
			removeCollection.add("element-1");
			removeCollection.add("element-2");
			removeCollection.add("element-3");
			
			collection.add("element-1");
			collection.add("element-3");
			
			var changed:Boolean = collection.removeAll(removeCollection);
			Assert.assertTrue(changed);
		}
		
		/////////////////////////////////////////
		// TypedCollection().retainAll() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function retainAll_collectionWithTwoNotEquatableElements_argumentWithTheTwoCollectionElements_ReturnsFalse(): void
		{
			var retainAllCollection:ICollection = getCollection(String);
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
			var retainAllCollection:ICollection = getCollection(String);
			retainAllCollection.add("element-1");
			retainAllCollection.add("element-2");
			
			collection.add("element-3");
			
			var changed:Boolean = collection.retainAll(retainAllCollection);
			Assert.assertTrue(changed);
		}
		
		///////////////////////////////////////
		// TypedCollection().toArray() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function toArray_emptyCollection_ReturnsValidArrayObject(): void
		{
			var array:Array = collection.toArray();
			Assert.assertNotNull(array);
		}
		
		////////////////////////////////////////
		// TypedCollection().toString() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function toString_emptyCollection_ReturnsValidString(): void
		{
			var string:String = (collection as TypedCollection).toString();
			Assert.assertNotNull(string);
		}
		
	}

}
