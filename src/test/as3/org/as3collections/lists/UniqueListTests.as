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
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.IListIterator;
	import org.as3collections.UniqueCollectionTests;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueListTests extends UniqueCollectionTests
	{
		public function get list():IList { return collection as IList; };
		
		public function UniqueListTests()
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
		
		///////////////////////////////////
		// UniqueList().addAllAt() TESTS //
		///////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function addAllAt_invalidArgument_ThrowsError(): void
		{
			list.addAllAt(0, null);
		}
		
		[Test]
		public function addAllAt_emptyArgument_ReturnsFalse(): void
		{
			var addAllList:IList = new ArrayList();
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertFalse(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithOneNotDuplicateNotEquatableElementAndOneDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			list.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertTrue(changed);
		}
		
		[Test]
		public function addAllAt_argumentWithTwoDuplicateNotEquatableElements_ReturnsFalse(): void
		{
			list.add("element-1");
			list.add("element-2");
			
			var addAllList:IList = new ArrayList();
			addAllList.add("element-1");
			addAllList.add("element-2");
			
			var changed:Boolean = list.addAllAt(0, addAllList);
			Assert.assertFalse(changed);
		}
		
		////////////////////////////////
		// UniqueList().addAt() TESTS //
		////////////////////////////////
		
		[Test]
		public function addAt_notDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var added:Boolean = list.addAt(0, "element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function addAt_duplicateNotEquatableElement_ReturnsFalse(): void
		{
			list.add("element-1");
			
			var added:Boolean = list.addAt(0, "element-1");
			Assert.assertFalse(added);
		}
		
		///////////////////////////////////////
		// UniqueList().listIterator() TESTS //
		///////////////////////////////////////
		
		[Test]
		public function listIterator_simpleCall_ReturnsValidObject(): void
		{
			var iterator:IListIterator = list.listIterator();
			Assert.assertNotNull(iterator);
		}
		
		[Test]
		public function listIterator_simpleCall_tryToAddDuplicateNotEquatableElementThroughIListIterator_ReturnsFalse(): void
		{
			list.add("element-1");
			var iterator:IListIterator = list.listIterator();
			
			var added:Boolean = iterator.add("element-1");
			Assert.assertFalse(added);
		}
		
	}

}