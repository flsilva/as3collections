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
	public class AbstractCollectionTests
	{
		public var collection:ICollection;
		
		public function AbstractCollectionTests()
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
		
		//////////////////////////////////////
		// AbstractCollection().add() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function add_validArgument_ReturnsTrue(): void
		{
			var added:Boolean = collection.add("element-1");
			Assert.assertTrue(added);
		}
		
		/////////////////////////////////////////
		// AbstractCollection().addAll() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function addAll_validArgument_ReturnsTrue(): void
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
		public function clear_notEmptyCollection_checkIfCollectionIsEmpty_ReturnsTrue(): void
		{
			collection.add("element-1");
			collection.clear();
			var isEmpty:Boolean = collection.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
	}

}