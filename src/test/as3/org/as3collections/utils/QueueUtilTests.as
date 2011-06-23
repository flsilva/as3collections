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
	import org.as3collections.IQueue;
	import org.as3collections.queues.LinearQueue;
	import org.as3collections.queues.TypedQueue;
	import org.as3collections.queues.UniqueQueue;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class QueueUtilTests
	{
		
		public function QueueUtilTests()
		{
			
		}
		
		//////////////////////////////////////////
		// QueueUtil constructor TESTS //
		//////////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function constructor_tryToInstanciate_ThrowsError(): void
		{
			new QueueUtil();
		}
		
		/////////////////////////////////////
		// QueueUtil.getTypedQueue() TESTS //
		/////////////////////////////////////
		
		[Test]
		public function getTypedQueue_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var queue:IQueue = QueueUtil.getTypedQueue(new LinearQueue(), String);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(queue, TypedQueue);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getTypedQueue_simpleCall_checkIfReturnedTypedListWithCorrectType_ReturnsTrue(): void
		{
			var queue:TypedQueue = QueueUtil.getTypedQueue(new LinearQueue(), String);
			Assert.assertEquals(String, queue.type);
		}
		
		//////////////////////////////////////
		// QueueUtil.getUniqueQueue() TESTS //
		//////////////////////////////////////
		
		[Test]
		public function getUniqueQueue_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var queue:IQueue = QueueUtil.getUniqueQueue(new LinearQueue());
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(queue, UniqueQueue);
			Assert.assertTrue(classPathEqual);
		}
		
		///////////////////////////////////////////////////
		// QueueUtil.getUniqueTypedQueue() TESTS //
		///////////////////////////////////////////////////
		
		[Test]
		public function getUniqueTypedQueue_simpleCall_checkIfReturnedTypedList_ReturnsTrue(): void
		{
			var queue:IQueue = QueueUtil.getUniqueTypedQueue(new LinearQueue(), String);
			
			var classPathEqual:Boolean = ReflectionUtil.classPathEquals(queue, TypedQueue);
			Assert.assertTrue(classPathEqual);
		}
		
		[Test]
		public function getUniqueTypedQueue_simpleCall_checkIfReturnedTypedListWithCorrectType_ReturnsTrue(): void
		{
			var queue:TypedQueue = QueueUtil.getUniqueTypedQueue(new LinearQueue(), String);
			Assert.assertEquals(String, queue.type);
		}
		
	}

}