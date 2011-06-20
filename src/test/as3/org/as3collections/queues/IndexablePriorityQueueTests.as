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
	import org.as3collections.ISortedQueue;
	import org.as3collections.IndexablePriorityObject;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IndexablePriorityQueueTests
	{
		
		public var priorityQueue:ISortedQueue;
		
		public function IndexablePriorityQueueTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			priorityQueue = getQueue();
		}
		
		[After]
		public function tearDown(): void
		{
			priorityQueue = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getQueue():ISortedQueue
		{
			return new IndexablePriorityQueue();
		}
		
		////////////////////////////////////////////////
		// IndexablePriorityQueue() constructor TESTS //
		////////////////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(2, 1);
			
			var newQueue:ISortedQueue = new IndexablePriorityQueue([indexablePriorityObject1, indexablePriorityObject2]);
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(2, 1);
			
			var newQueue:ISortedQueue = new IndexablePriorityQueue([indexablePriorityObject1, indexablePriorityObject2]);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithInvalidElement_ThrowsError(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			new IndexablePriorityQueue([indexablePriorityObject1, "element-2"]);
		}
		
		//////////////////////////////////////////
		// IndexablePriorityQueue().add() TESTS //
		//////////////////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function add_nullArgument_ThrowsError(): void
		{
			priorityQueue.add(null);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function add_invalidArgument_ThrowsError(): void
		{
			priorityQueue.add("element-1");
		}
		
		[Test]
		public function add_validArgument_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			
			var added:Boolean = priorityQueue.add(indexablePriorityObject1);
			Assert.assertTrue(added);
		}
		
		////////////////////////////////////////////
		// IndexablePriorityQueue().clone() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function clone_emptyQueue_ReturnValidQueueObject(): void
		{
			var clonedQueue:ICollection = priorityQueue.clone();
			Assert.assertNotNull(clonedQueue);
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(2, 1);
			
			priorityQueue.add(indexablePriorityObject1);
			priorityQueue.add(indexablePriorityObject2);
			
			var clonedQueue:ICollection = priorityQueue.clone();
			Assert.assertTrue(priorityQueue.equals(clonedQueue));
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_cloneButChangeCollection_checkIfBothCollectionsAreEqual_ReturnsFalse(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(2, 1);
			
			priorityQueue.add(indexablePriorityObject1);
			priorityQueue.add(indexablePriorityObject2);
			
			var clonedQueue:ICollection = priorityQueue.clone();
			clonedQueue.remove(indexablePriorityObject2);
			Assert.assertFalse(priorityQueue.equals(clonedQueue));
		}
		
		/////////////////////////////////////////////
		// IndexablePriorityQueue().equals() TESTS //
		/////////////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyQueues_ReturnsTrue(): void
		{
			var priorityQueue2:ISortedQueue = new IndexablePriorityQueue();
			Assert.assertTrue(priorityQueue.equals(priorityQueue2));
		}
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(2, 1);
			
			priorityQueue.add(indexablePriorityObject1);
			priorityQueue.add(indexablePriorityObject2);
			
			var queue2:ICollection = getQueue();
			queue2.add(indexablePriorityObject2);
			queue2.add(indexablePriorityObject1);
			
			Assert.assertTrue(priorityQueue.equals(queue2));
		}
		
		////////////////////////////////////////////
		// IndexablePriorityQueue().offer() TESTS //
		////////////////////////////////////////////
		
		[Test]
		public function offer_nullArgument_ReturnsFalse(): void
		{
			var added:Boolean = priorityQueue.offer(null);
			Assert.assertFalse(added);
		}
		
		[Test]
		public function offer_invalidArgument_ReturnsFalse(): void
		{
			var added:Boolean = priorityQueue.offer("element-1");
			Assert.assertFalse(added);
		}
		
		[Test]
		public function offer_validArgument_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			
			var added:Boolean = priorityQueue.offer(indexablePriorityObject1);
			Assert.assertTrue(added);
		}
		
		///////////////////////////////////////////
		// IndexablePriorityQueue().poll() TESTS //
		///////////////////////////////////////////
		
		[Test]
		public function poll_addTwoValidElements_callPollAndCheckIfCorrectElementWasReturned_ReturnsTrue(): void
		{
			var indexablePriorityObject1:IndexablePriorityObject = new IndexablePriorityObject(1, 2);
			var indexablePriorityObject2:IndexablePriorityObject = new IndexablePriorityObject(1, 1);
			
			priorityQueue.add(indexablePriorityObject1);
			priorityQueue.add(indexablePriorityObject2);
			
			var element:IndexablePriorityObject = priorityQueue.poll();
			Assert.assertEquals(indexablePriorityObject2, element);
		}
		
	}

}