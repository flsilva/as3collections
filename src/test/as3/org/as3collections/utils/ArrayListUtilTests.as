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

package org.as3collections.utils
{
	import org.as3collections.IList;
	import org.as3collections.lists.ArrayList;
	import org.as3collections.lists.TypedList;
	import org.as3collections.lists.UniqueList;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class ArrayListUtilTests
	{
		
		public function ArrayListUtilTests()
		{
			
		}
		
		/////////////////////////////////////
		// ArrayListUtil constructor TESTS //
		/////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new ArrayListUtil();
		}
		
		////////////////////////////////////////
		// ArrayListUtil.getTypedList() TESTS //
		////////////////////////////////////////
		
		[Test]
		public function getTypedList_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var list:IList = ArrayListUtil.getTypedList(new ArrayList(), String);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(list, TypedList);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedList_simpleCall_checkIfReturnedTypedListWithCorrectType_ReturnsTrue(): void
		{
			var list:TypedList = ArrayListUtil.getTypedList(new ArrayList(), String);
			Assert.assertEquals(String, list.type);
		}
		
		/////////////////////////////////////////
		// ArrayListUtil.getUniqueList() TESTS //
		/////////////////////////////////////////
		
		[Test]
		public function getUniqueList_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var list:IList = ArrayListUtil.getUniqueList(new ArrayList());
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(list, UniqueList);
			Assert.assertTrue(classPathEqual);
		}
		
		//////////////////////////////////////////////
		// ArrayListUtil.getUniqueTypedList() TESTS //
		//////////////////////////////////////////////
		
		[Test]
		public function getUniqueTypedList_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var list:IList = ArrayListUtil.getUniqueTypedList(new ArrayList(), String);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(list, TypedList);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getUniqueTypedList_simpleCall_checkIfReturnedTypedListWithCorrectType_ReturnsTrue(): void
		{
			var list:TypedList = ArrayListUtil.getUniqueTypedList(new ArrayList(), String);
			Assert.assertEquals(String, list.type);
		}
		
	}

}