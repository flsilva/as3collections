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
	public class UniqueCollectionTests
	{
		public var collection:ICollection;
		
		public function UniqueCollectionTests()
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
			// using an ArrayList object
			// instead of a fake to simplify tests
			// since ArrayList is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in ArrayList may break some tests in this class
			// when errors in tests of this class occur
			// consider that it can be in the ArrayList object
			return new UniqueCollection(new ArrayList());
		}
		
		////////////////////////////////////
		// UniqueCollection().add() TESTS //
		////////////////////////////////////
		
		[Test]
		public function add_notDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var added:Boolean = collection.add("element-1");
			Assert.assertTrue(added);
		}
		
		///////////////////////////////////////
		// UniqueCollection().addAll() TESTS //
		///////////////////////////////////////
		
		[Test(expects="ArgumentError")]
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
		public function addAll_argumentWithOneNotDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAll_argumentWithOneNotDuplicateNotEquatableElementAndOneDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			collection.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAll_argumentWithTwoDuplicateNotEquatableElements_ReturnsFalse(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertFalse(changed);
		}
		
		//////////////////////////////////////
		// UniqueCollection().clear() TESTS //
		//////////////////////////////////////
		
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
		
		//////////////////////////////////////
		// UniqueCollection().clone() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.add("element-2");
			
			var clonedCollection:ICollection = collection.clone();
			Assert.assertTrue(collection.equals(clonedCollection));
		}
		
		////////////////////////////////////////////
		// UniqueCollection().containsAll() TESTS //
		////////////////////////////////////////////
		
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
		// UniqueCollection().removeAll() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function removeAll_invalidArgument_ThrowsError(): void
		{
			collection.removeAll(null);
		}
		
		[Test]
		public function removeAll_emptyCollection_ReturnsFalse(): void
		{
			var removeAllCollection:ICollection = getCollection();
			removeAllCollection.add("element-1");
			
			var changed:Boolean = collection.removeAll(removeAllCollection);
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
		
		//////////////////////////////////////////
		// UniqueCollection().retainAll() TESTS //
		//////////////////////////////////////////
		
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
		
		////////////////////////////////////////
		// UniqueCollection().toArray() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function toArray_emptyCollection_ReturnsValidArrayObject(): void
		{
			var array:Array = collection.toArray();
			Assert.assertNotNull(array);
		}
		
		/////////////////////////////////////////
		// UniqueCollection().toString() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function toString_emptyCollection_ReturnsValidString(): void
		{
			var string:String = (collection as UniqueCollection).toString();
			Assert.assertNotNull(string);
		}
		
	}

}