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
	public class AbstractHashMapTests
	{
		
		public function AbstractHashMapTests()
		{
			
		}
		
		/////////////////////////////////////////
		// AbstractHashMap() constructor TESTS //
		/////////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new AbstractHashMap();
		}
		
		/////////////////////////////////////
		// AbstractHashMap().clear() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function clear_simpleCall_ThrowsError(): void
		{
			var fake:FakeAbstractHashMap = new FakeAbstractHashMap();
			fake.clear();
		}
		
		/////////////////////////////////////
		// AbstractHashMap().clone() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.CloneNotSupportedError")]
		public function clone_simpleCall_ThrowsError(): void
		{
			var fake:FakeAbstractHashMap = new FakeAbstractHashMap();
			fake.clone();
		}
		
		//////////////////////////////////////
		// AbstractHashMap().equals() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function equals_twoEqualCollections_ReturnsTrue(): void
		{
			var fake1:FakeAbstractHashMap = new FakeAbstractHashMap();
			var fake2:FakeAbstractHashMap = new FakeAbstractHashMap();
			
			var equal:Boolean = fake1.equals(fake2);
			Assert.assertTrue(equal);
		}
		
		////////////////////////////////////////
		// AbstractHashMap().iterator() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function iterator_simpleCall_ThrowsError(): void
		{
			var fake:FakeAbstractHashMap = new FakeAbstractHashMap();
			fake.iterator();
		}
		
		///////////////////////////////////
		// AbstractHashMap().put() TESTS //
		///////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function put_simpleCall_ThrowsError(): void
		{
			var fake:FakeAbstractHashMap = new FakeAbstractHashMap();
			fake.put("element-1", 1);
		}
		
		//////////////////////////////////////
		// AbstractHashMap().remove() TESTS //
		//////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function remove_simpleCall_ThrowsError(): void
		{
			var fake:FakeAbstractHashMap = new FakeAbstractHashMap();
			fake.remove("element-1");
		}
		
	}

}