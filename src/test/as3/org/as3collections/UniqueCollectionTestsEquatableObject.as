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
	public class UniqueCollectionTestsEquatableObject
	{
		public var collection:ICollection;
		
		public function UniqueCollectionTestsEquatableObject()
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
		public function add_notDuplicateEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var added:Boolean = collection.add(equatableObject1A);
			Assert.assertTrue(added);
		}
		
		[Test]
		public function add_duplicateEquatableElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			collection.add(equatableObject1A);
			
			var added:Boolean = collection.add(equatableObject1B);
			Assert.assertFalse(added);
		}
		
		///////////////////////////////////////
		// UniqueCollection().addAll() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function addAll_argumentWithOneNotDuplicateEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1A);
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAll_argumentWithOneNotDuplicateEquatableElementAndOneDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1B);
			addAllList.add(equatableObject2B);
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAll_argumentWithTwoDuplicateEquatableElements_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			collection.add(equatableObject1A);
			collection.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add(equatableObject1B);
			addAllList.add(equatableObject2B);
			
			var changed:Boolean = collection.addAll(addAllList);
			Assert.assertFalse(changed);
		}
		
	}

}