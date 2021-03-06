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
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class AbstractArrayCollectionTests
	{
		
		public function AbstractArrayCollectionTests()
		{
			
		}
		
		////////////////////////////////////////////
		// AbstractArrayCollection() constructor TESTS //
		////////////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new AbstractArrayCollection();
		}
		
		//////////////////////////////////////
		// AbstractArrayCollection().add() TESTS //
		//////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function add_simpleCall_ThrowsError(): void
		{
			var fake:ICollection = new FakeArrayCollection();
			fake.add("element-1");
		}
		
		////////////////////////////////////////
		// AbstractArrayCollection().clear() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function clear_simpleCall_ThrowsError(): void
		{
			var fake:ICollection = new FakeArrayCollection();
			fake.clear();
		}
		
		////////////////////////////////////////
		// AbstractArrayCollection().clone() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.CloneNotSupportedError")]
		public function clone_simpleCall_ThrowsError(): void
		{
			var fake:ICollection = new FakeArrayCollection();
			fake.clone();
		}
		
		/////////////////////////////////////////
		// AbstractArrayCollection().equals() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function equals_twoEqualCollections_ReturnsTrue(): void
		{
			var fake1:ICollection = new FakeArrayCollection();
			var fake2:ICollection = new FakeArrayCollection();
			
			var equal:Boolean = fake1.equals(fake2);
			Assert.assertTrue(equal);
		}
		
		///////////////////////////////////////////
		// AbstractArrayCollection().iterator() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function iterator_simpleCall_ThrowsError(): void
		{
			var fake:ICollection = new FakeArrayCollection();
			fake.iterator();
		}
		
		///////////////////////////////////////////
		// AbstractArrayCollection().toString() TESTS //
		///////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function toString_simpleCall_ThrowsError(): void
		{
			var fake:ICollection = new FakeArrayCollection();
			(fake as FakeArrayCollection).toString();
		}
		
	}

}