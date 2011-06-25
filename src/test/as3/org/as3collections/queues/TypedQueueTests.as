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
	import org.as3collections.EquatableObject;
	import org.as3collections.ICollection;
	import org.as3collections.IQueue;
	import org.as3collections.TypedCollection;
	import org.as3collections.TypedCollectionTests;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class TypedQueueTests extends TypedCollectionTests
	{
		
		public function get queue():IQueue { return collection as IQueue; }
		
		public function TypedQueueTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection(type:Class):TypedCollection
		{
			// using an LinearQueue object
			// instead of a fake to simplify tests
			// since LinearQueue is fully tested it is ok
			// but it means that unit testing of this class are in some degree "integration testing"
			// so changes in LinearQueue may break some tests in this class
			// when errors in tests in this class occur
			// consider that it can be in the LinearQueue object
			return new TypedQueue(new LinearQueue(), type);
		}
		
		////////////////////////////////////
		// TypedQueue() constructor TESTS //
		////////////////////////////////////
		
		[Test]
		public function constructor_argumentValidElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newQueue:IQueue = new TypedQueue(new LinearQueue(["element-1", "element-2"]), String);
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentInvalidElements_ThrowsError(): void
		{
			var newQueue:IQueue = new TypedQueue(new LinearQueue([1, 5]), String);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithValidAndInvalidElements_ThrowsError(): void
		{
			var newQueue:IQueue = new TypedQueue(new LinearQueue(["element-1", 5]), String);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		//////////////////////////////
		// TypedQueue().add() TESTS //
		//////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function add_nullArgument_ThrowsError(): void
		{
			queue.add(null);
		}
		
		////////////////////////////////
		// TypedQueue().clone() TESTS //
		////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsTypedQueue_ReturnsTrue(): void
		{
			var clonedQueue:IQueue = queue.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(TypedQueue, clonedQueue);
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
		
		//////////////////////////////////
		// TypedQueue().dequeue() TESTS //
		//////////////////////////////////
		
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
		// TypedQueue().equals() TESTS //
		/////////////////////////////////
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothQueueAreEqual_ReturnsFalse(): void
		{
			queue.add("element-1");
			queue.add("element-2");
			
			var queue2:ICollection = getCollection(String);
			queue2.add("element-2");
			queue2.add("element-1");
			
			Assert.assertFalse(queue.equals(queue2));
		}
		
		[Test]
		public function equals_queueWithTwoEquatableElements_sameElementsButDifferentOrder_checkIfBothQueueAreEqual_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newQueue1:ICollection = getCollection(EquatableObject);
			newQueue1.add(equatableObject1A);
			newQueue1.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newQueue2:ICollection = getCollection(EquatableObject);
			newQueue2.add(equatableObject2B);
			newQueue2.add(equatableObject1B);
			
			Assert.assertFalse(newQueue1.equals(newQueue2));
		}
		
		[Test]
		public function equals_twoEmptyQueuesWithSameType_ReturnsTrue(): void
		{
			var queue2:ICollection = getCollection(String);
			Assert.assertTrue(queue.equals(queue2));
		}
		
		[Test]
		public function equals_twoEmptyQueuesWithDifferentType_ReturnsFalse(): void
		{
			var queue2:ICollection = getCollection(int);
			Assert.assertFalse(queue.equals(queue2));
		}
		
		//////////////////////////////////
		// TypedQueue().element() TESTS //
		//////////////////////////////////
		
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
		
		////////////////////////////////
		// TypedQueue().offer() TESTS //
		////////////////////////////////
		
		[Test]
		public function offer_validType_ReturnsTrue(): void
		{
			var added:Boolean = queue.offer("element-1");
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_invalidType_ReturnsFalse(): void
		{
			var added:Boolean = queue.offer(1);
			Assert.assertFalse(added);
		}
		
		///////////////////////////////
		// TypedQueue().peek() TESTS //
		///////////////////////////////
		
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
		
		///////////////////////////////
		// TypedQueue().poll() TESTS //
		///////////////////////////////
		
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