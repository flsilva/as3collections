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
	import org.as3collections.IQueue;
	import org.as3collections.UniqueCollectionTests;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueQueueTests extends UniqueCollectionTests
	{
		
		public function get queue():IQueue { return collection as IQueue; }
		
		public function UniqueQueueTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			// using an LinearQueue object
			// instead of a fake to simplify tests
			// since LinearQueue is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in LinearQueue may break some tests in this class
			// when errors in tests in this class occur
			// consider that it can be in the LinearQueue object
			return new UniqueQueue(new LinearQueue());
		}
		
		/////////////////////////////////////
		// UniqueQueue() constructor TESTS //
		/////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newQueue:IQueue = new UniqueQueue(new LinearQueue(["element-1", "element-2"]));
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newQueue:IQueue = new UniqueQueue(new LinearQueue(["element-1", "element-2"]));
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function constructor_argumentWithTwoDuplicateNotEquatableElements_checkIfSizeIsOne_ReturnsTrue(): void
		{
			var newQueue:IQueue = new UniqueQueue(new LinearQueue(["element-1", "element-1"]));
			
			var size:int = newQueue.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////////
		// LinearQueue().add() TESTS //
		///////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function add_nullArgument_ThrowsError(): void
		{
			queue.add(null);
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function add_duplicateNotEquatableArgument_ThrowsError(): void
		{
			queue.add("element-1");
			queue.add("element-1");
		}
		
		/////////////////////////////////
		// UniqueQueue().clone() TESTS //
		/////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsUniqueQueue_ReturnsTrue(): void
		{
			var clonedQueue:IQueue = queue.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(UniqueQueue, clonedQueue);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_emptyQueue_ReturnValidiQueueObject(): void
		{
			var clonedQueue:IQueue = queue.clone();
			Assert.assertNotNull(clonedQueue);
		}
		
		[Test]
		public function clone_queueWithTwoNotEquatableElements_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.add("element-2");
			
			var clonedQueue:ICollection = collection.clone();
			Assert.assertTrue(collection.equals(clonedQueue));
		}
		
		[Test]
		public function clone_queueWithTwoNotEquatableElements_cloneButChangeQueue_checkIfBothQueuesAreEqual_ReturnsFalse(): void
		{
			queue.add("element-1");
			queue.add("element-2");
			
			var clonedQueue:ICollection = collection.clone();
			clonedQueue.remove("element-2");
			Assert.assertFalse(collection.equals(clonedQueue));
		}
		
		///////////////////////////////////
		// UniqueQueue().dequeue() TESTS //
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
		
		//////////////////////////////////
		// UniqueQueue().equals() TESTS //
		//////////////////////////////////
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothQueueAreEqual_ReturnsFalse(): void
		{
			queue.add("element-1");
			queue.add("element-2");
			
			var queue2:ICollection = getCollection();
			queue2.add("element-2");
			queue2.add("element-1");
			
			Assert.assertFalse(queue.equals(queue2));
		}
		
		///////////////////////////////////
		// UniqueQueue().element() TESTS //
		///////////////////////////////////
		
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
		
		/////////////////////////////////
		// UniqueQueue().offer() TESTS //
		/////////////////////////////////
		
		[Test]
		public function offer_notDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var added:Boolean = queue.offer("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_duplicateNotEquatableElement_ReturnsFalse(): void
		{
			queue.offer("element-1");
			
			var added:Boolean = queue.offer("element-1");
			Assert.assertFalse(added);
		}
		
		////////////////////////////////
		// UniqueQueue().peek() TESTS //
		////////////////////////////////
		
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
		
		////////////////////////////////
		// UniqueQueue().poll() TESTS //
		////////////////////////////////
		
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
		
	}

}