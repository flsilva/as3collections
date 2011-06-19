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
	public class IQueueTests extends ICollectionTests
	{
		public function get queue():IQueue { return collection as IQueue; }
		
		public function IQueueTests()
		{
			
		}
		
		//////////////////////////
		// IQueue().add() TESTS //
		//////////////////////////
		
		[Test]
		public function add_validArgument_ReturnsTrue(): void
		{
			var added:Boolean = queue.add("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function add_validArgument_checkIfSizeIsOne_ReturnsTrue(): void
		{
			queue.add("element-1");
			
			var size:int = queue.size();
			Assert.assertEquals(1, size);
		}
		
		//////////////////////////////
		// IQueue().dequeue() TESTS //
		//////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function dequeue_emptyQueue_ThrowsError(): void
		{
			queue.dequeue();
		}
		
		[Test]
		public function dequeue_queueWithOneNotEquatableElement_ReturnsValidObject(): void
		{
			queue.add("element-1");
			
			var element:String = queue.dequeue();
			Assert.assertNotNull(element);
		}
		
		[Test]
		public function dequeue_queueWithOneNotEquatableElement_checkIfQueueIsEmpty_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.dequeue();
			
			var isEmpty:Boolean = queue.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function dequeue_queueWithOneNotEquatableElement_checkIfSizeIsZero_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.dequeue();
			
			var size:int = queue.size();
			Assert.assertEquals(0, size);
		}
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function dequeue_queueWithOneNotEquatableElement_callTwice_ThrowsError(): void
		{
			queue.add("element-1");
			queue.dequeue();
			queue.dequeue();
		}
		
		//////////////////////////////
		// IQueue().element() TESTS //
		//////////////////////////////
		
		[Test(expects="org.as3collections.errors.NoSuchElementError")]
		public function element_emptyQueue_ThrowsError(): void
		{
			queue.element();
		}
		
		[Test]
		public function element_queueWithOneNotEquatableElement_ReturnsValidObject(): void
		{
			queue.add("element-1");
			
			var element:String = queue.element();
			Assert.assertNotNull(element);
		}
		
		[Test]
		public function element_queueWithOneNotEquatableElement_checkIfQueueIsEmpty_ReturnsFalse(): void
		{
			queue.add("element-1");
			queue.element();
			
			var isEmpty:Boolean = queue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function element_queueWithOneNotEquatableElement_checkIfSizeIsOne_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.element();
			
			var size:int = queue.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function element_queueWithOneNotEquatableElement_callTwice_checkIfReturnedElementIsCorrect_ReturnTrue(): void
		{
			queue.add("element-1");
			queue.element();
			
			var element:String = queue.element();
			Assert.assertEquals("element-1", element);
		}
		
		////////////////////////////
		// IQueue().offer() TESTS //
		////////////////////////////
		
		[Test]
		public function offer_validArgument_ReturnsTrue(): void
		{
			var added:Boolean = queue.offer("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_validArgument_checkIfIsEmpty_ReturnsFalse(): void
		{
			queue.offer("element-1");
			
			var isEmpty:Boolean = queue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		///////////////////////////
		// IQueue().peek() TESTS //
		///////////////////////////
		
		[Test]
		public function peek_emptyQueue_ReturnsNull(): void
		{
			var element:* = queue.peek();
			Assert.assertNull(element);
		}
		
		[Test]
		public function peek_queueWithOneNotEquatableElement_ReturnsValidObject(): void
		{
			queue.add("element-1");
			
			var element:String = queue.peek();
			Assert.assertNotNull(element);
		}
		
		[Test]
		public function peek_queueWithOneNotEquatableElement_checkIfQueueIsEmpty_ReturnsFalse(): void
		{
			queue.add("element-1");
			queue.peek();
			
			var isEmpty:Boolean = queue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function peek_queueWithOneNotEquatableElement_checkIfSizeIsOne_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.peek();
			
			var size:int = queue.size();
			Assert.assertEquals(1, size);
		}
		
		[Test]
		public function peek_queueWithOneNotEquatableElement_callTwice_checkIfReturnedElementIsCorrect_ReturnTrue(): void
		{
			queue.add("element-1");
			queue.peek();
			
			var element:String = queue.peek();
			Assert.assertEquals("element-1", element);
		}
		
		///////////////////////////
		// IQueue().poll() TESTS //
		///////////////////////////
		
		[Test]
		public function poll_emptyQueue_ReturnsNull(): void
		{
			var element:* = queue.poll();
			Assert.assertNull(element);
		}
		
		[Test]
		public function poll_queueWithOneNotEquatableElement_ReturnsValidObject(): void
		{
			queue.add("element-1");
			
			var element:String = queue.poll();
			Assert.assertNotNull(element);
		}
		
		[Test]
		public function poll_queueWithOneNotEquatableElement_checkIfQueueIsEmpty_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.poll();
			
			var isEmpty:Boolean = queue.isEmpty();
			Assert.assertTrue(isEmpty);
		}
		
		[Test]
		public function poll_queueWithOneNotEquatableElement_checkIfSizeIsZero_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.poll();
			
			var size:int = queue.size();
			Assert.assertEquals(0, size);
		}
		
		[Test]
		public function poll_queueWithOneNotEquatableElement_callTwice_ReturnsNull(): void
		{
			queue.add("element-1");
			queue.poll();
			
			var element:* = queue.poll();
			Assert.assertNull(element);
		}
		
	}

}