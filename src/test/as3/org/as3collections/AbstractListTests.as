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

	/**
	 * @author Flávio Silva
	 */
	public class AbstractListTests
	{
		
		public function AbstractListTests()
		{
			
		}
		
		//////////////////////////////////////
		// AbstractList() constructor TESTS //
		//////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new AbstractList();
		}
		
		//////////////////////////////////
		// AbstractList().addAt() TESTS //
		//////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function addAt_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.addAt(0, "element-1");
		}
		
		/////////////////////////////////////////
		// AbstractList().listIterator() TESTS //
		/////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function iterator_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.listIterator();
		}
		
		/////////////////////////////////////
		// AbstractList().removeAt() TESTS //
		/////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeAt_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.removeAt(0);
		}
		
		////////////////////////////////////////
		// AbstractList().removeRange() TESTS //
		////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function removeRange_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.removeRange(0, 1);
		}
		
		//////////////////////////////////
		// AbstractList().setAt() TESTS //
		//////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function setAt_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.setAt(0, "element-1");
		}
		
		////////////////////////////////////
		// AbstractList().subList() TESTS //
		////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.UnsupportedOperationError")]
		public function subList_simpleCall_ThrowsError(): void
		{
			var fake:IList = new FakeList();
			fake.subList(0, 1);
		}
		
	}

}