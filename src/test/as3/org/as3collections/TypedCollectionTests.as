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
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;
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
			throw new UnsupportedOperationError("Method must be overridden in subclass: " + ReflectionUtil.getClassPath(this));
		}
		
		///////////////////////////////////////
		// TypedCollectionTests().type TESTS //
		///////////////////////////////////////
		
		[Test]
		public function type_createInstanceCheckType_ReturnsCorrectType(): void
		{
			var newCollection:TypedCollection = getCollection(Array);
			
			var type:Class = newCollection.type;
			Assert.assertEquals(Array, type);
		}
		
		////////////////////////////////////////
		// TypedCollectionTests().add() TESTS //
		////////////////////////////////////////
		
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
		
		///////////////////////////////////////////
		// TypedCollectionTests().addAll() TESTS //
		///////////////////////////////////////////
		
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
		
	}

}
