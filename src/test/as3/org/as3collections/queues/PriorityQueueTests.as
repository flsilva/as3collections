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
	import org.as3collections.ISortedQueue;
	import org.as3collections.PriorityObject;
	import org.as3coreaddendum.system.comparators.PriorityComparator;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class PriorityQueueTests
	{
		
		public var priorityQueue:ISortedQueue;
		
		public function PriorityQueueTests()
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
			return new PriorityQueue();
		}
		
		///////////////////////////////////////
		// PriorityQueue() constructor TESTS //
		///////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			var newQueue:ISortedQueue = new PriorityQueue([priorityObject1, priorityObject2]);
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			var newQueue:ISortedQueue = new PriorityQueue([priorityObject1, priorityObject2]);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithInvalidElement_ThrowsError(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			new PriorityQueue([priorityObject1, "element-2"]);
		}
		
		////////////////////////////////////////
		// PriorityQueue().comparator() TESTS //
		////////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function comparator_notAllowedSetter_ThrowsError(): void
		{
			priorityQueue.comparator = new PriorityComparator();
		}
		
		/////////////////////////////////////
		// PriorityQueue().options() TESTS //
		/////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function options_notAllowedSetter_ThrowsError(): void
		{
			priorityQueue.options = 0;
		}
		
		/////////////////////////////////
		// PriorityQueue().add() TESTS //
		/////////////////////////////////
		
		[Test(expects="ArgumentError")]
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
			var priorityObject1:PriorityObject = new PriorityObject(1);
			
			var added:Boolean = priorityQueue.add(priorityObject1);
			Assert.assertTrue(added);
		}
		
		///////////////////////////////////
		// PriorityQueue().clone() TESTS //
		///////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsPriorityQueue_ReturnsTrue(): void
		{
			var clonedQueue:IQueue = priorityQueue.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(PriorityQueue, clonedQueue);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_emptyQueue_ReturnValidQueueObject(): void
		{
			var clonedQueue:ICollection = priorityQueue.clone();
			Assert.assertNotNull(clonedQueue);
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			priorityQueue.add(priorityObject1);
			priorityQueue.add(priorityObject2);
			
			var clonedQueue:ICollection = priorityQueue.clone();
			Assert.assertTrue(priorityQueue.equals(clonedQueue));
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_cloneButChangeCollection_checkIfBothCollectionsAreEqual_ReturnsFalse(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			priorityQueue.add(priorityObject1);
			priorityQueue.add(priorityObject2);
			
			var clonedQueue:ICollection = priorityQueue.clone();
			clonedQueue.remove(priorityObject2);
			Assert.assertFalse(priorityQueue.equals(clonedQueue));
		}
		
		////////////////////////////////////
		// PriorityQueue().equals() TESTS //
		////////////////////////////////////
		
		[Test]
		public function equals_twoEmptyQueues_ReturnsTrue(): void
		{
			var priorityQueue2:ISortedQueue = new PriorityQueue();
			Assert.assertTrue(priorityQueue.equals(priorityQueue2));
		}
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			priorityQueue.add(priorityObject1);
			priorityQueue.add(priorityObject2);
			
			var queue2:ICollection = getQueue();
			queue2.add(priorityObject2);
			queue2.add(priorityObject1);
			
			Assert.assertTrue(priorityQueue.equals(queue2));
		}
		
		///////////////////////////////////
		// PriorityQueue().offer() TESTS //
		///////////////////////////////////
		
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
			var priorityObject1:PriorityObject = new PriorityObject(1);
			
			var added:Boolean = priorityQueue.offer(priorityObject1);
			Assert.assertTrue(added);
		}
		
		//////////////////////////////////
		// PriorityQueue().poll() TESTS //
		//////////////////////////////////
		
		[Test]
		public function poll_addTwoValidElements_callPollAndCheckIfCorrectElementWasReturned_ReturnsTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			
			priorityQueue.add(priorityObject1);
			priorityQueue.add(priorityObject2);
			
			var element:PriorityObject = priorityQueue.poll();
			Assert.assertEquals(priorityObject2, element);
		}
		
		/////////////////////////
		// PriorityEvent TESTS //
		/////////////////////////
		
		[Test]
		public function queueWithThreeElements_changePriorityOfLastElementToFirstElement_callPollAndCheckIfCorrectElementWasReturned_ReturnsTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			var priorityObject3:PriorityObject = new PriorityObject(3);
			
			priorityQueue.add(priorityObject1);
			priorityQueue.add(priorityObject2);
			priorityQueue.add(priorityObject3);
			
			priorityObject1.priority = 4;
			
			var element:PriorityObject = priorityQueue.poll();
			Assert.assertEquals(priorityObject1, element);
		}
		
	}

}