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

package org.as3collections.queues
{
	import org.as3collections.ICollection;
	import org.as3collections.IList;
	import org.as3collections.IQueueTests;
	import org.as3collections.lists.ArrayList;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class LinearQueueTests extends IQueueTests
	{
		
		public function LinearQueueTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			return new LinearQueue();
		}
		
		/////////////////////////////////////
		// LinearQueue() constructor TESTS //
		/////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newList:IList = new ArrayList(["element-1", "element-2"]);
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newList:IList = new ArrayList(["element-1", "element-2"]);
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////
		// LinearQueue().add() TESTS //
		///////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function add_nullArgument_ThrowsError(): void
		{
			queue.add(null);
		}
		
		[Test]
		public function add_validDuplicateNotEquatableArgument_ReturnsTrue(): void
		{
			queue.add("element-1");
			
			var added:Boolean = queue.add("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function add_validDuplicateNotEquatableArgument_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.add("element-1");
			
			var size:int = queue.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////////
		// LinearQueue().dequeue() TESTS //
		///////////////////////////////////
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			queue.add("element-2");
			queue.add("element-1");
			
			var element:String = queue.dequeue();
			Assert.assertEquals("element-2", element);
		}
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_callTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			queue.add("element-2");
			queue.add("element-1");
			queue.dequeue();
			
			var element:String = queue.dequeue();
			Assert.assertEquals("element-1", element);
		}
		
		/////////////////////////////////
		// LinearQueue().offer() TESTS //
		/////////////////////////////////
		
		[Test]
		public function offer_nullArgument_ReturnsFalse(): void
		{
			var added:Boolean = queue.offer(null);
			Assert.assertFalse(added);
		}
		
		[Test]
		public function offer_validDuplicateNotEquatableArgument_ReturnsTrue(): void
		{
			queue.add("element-1");
			
			var added:Boolean = queue.offer("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_validDuplicateNotEquatableArgument_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			queue.offer("element-1");
			queue.offer("element-1");
			
			var size:int = queue.size();
			Assert.assertEquals(2, size);
		}
		
	}

}