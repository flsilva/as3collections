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
	import org.as3collections.IndexableObject;
	import org.as3coreaddendum.system.comparators.NumberComparator;
	import org.as3utils.ReflectionUtil;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class IndexQueueTests
	{
		
		public var indexQueue:ISortedQueue;
		
		public function IndexQueueTests()
		{
			
		}
		
		/////////////////////////
		// TESTS CONFIGURATION //
		/////////////////////////
		
		[Before]
		public function setUp(): void
		{
			indexQueue = getQueue();
		}
		
		[After]
		public function tearDown(): void
		{
			indexQueue = null;
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		public function getQueue():ISortedQueue
		{
			return new IndexQueue();
		}
		
		////////////////////////////////////
		// IndexQueue() constructor TESTS //
		////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			var newQueue:ISortedQueue = new IndexQueue([indexableObject0, indexableObject1]);
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			var newQueue:ISortedQueue = new IndexQueue([indexableObject0, indexableObject1]);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function constructor_argumentWithInvalidElement_ThrowsError(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			new IndexQueue([indexableObject0, "element-2"]);
		}
		
		/////////////////////////////////////
		// IndexQueue().comparator() TESTS //
		/////////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function comparator_notAllowedSetter_ThrowsError(): void
		{
			indexQueue.comparator = new NumberComparator();
		}
		
		//////////////////////////////////
		// IndexQueue().options() TESTS //
		//////////////////////////////////
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function options_notAllowedSetter_ThrowsError(): void
		{
			indexQueue.options = 0;
		}
		
		//////////////////////////////
		// IndexQueue().add() TESTS //
		//////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function add_nullArgument_ThrowsError(): void
		{
			indexQueue.add(null);
		}
		
		[Test(expects="org.as3coreaddendum.errors.ClassCastError")]
		public function add_invalidArgument_ThrowsError(): void
		{
			indexQueue.add("element-1");
		}
		
		[Test]
		public function add_validArgument_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			
			var added:Boolean = indexQueue.add(indexableObject0);
			Assert.assertTrue(added);
		}
		
		////////////////////////////////
		// IndexQueue().clone() TESTS //
		////////////////////////////////
		
		[Test]
		public function clone_simpleCall_checkIfReturnedObjectIsIndexQueue_ReturnsTrue(): void
		{
			var clonedQueue:IQueue = indexQueue.clone();
			
			var isCorrectType:Boolean = ReflectionUtil.classPathEquals(IndexQueue, clonedQueue);
			Assert.assertTrue(isCorrectType);
		}
		
		[Test]
		public function clone_emptyQueue_ReturnValidQueueObject(): void
		{
			var clonedQueue:ICollection = indexQueue.clone();
			Assert.assertNotNull(clonedQueue);
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_checkIfBothCollectionsAreEqual_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			indexQueue.add(indexableObject0);
			indexQueue.add(indexableObject1);
			
			var clonedQueue:ICollection = indexQueue.clone();
			Assert.assertTrue(indexQueue.equals(clonedQueue));
		}
		
		[Test]
		public function clone_collectionWithTwoNotEquatableElements_cloneButChangeCollection_checkIfBothCollectionsAreEqual_ReturnsFalse(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			indexQueue.add(indexableObject0);
			indexQueue.add(indexableObject1);
			
			var clonedQueue:ICollection = indexQueue.clone();
			clonedQueue.remove(indexableObject1);
			Assert.assertFalse(indexQueue.equals(clonedQueue));
		}
		
		/////////////////////////////////
		// IndexQueue().equals() TESTS //
		/////////////////////////////////
		
		[Test]
		public function equals_twoEmptyQueues_ReturnsTrue(): void
		{
			var indexQueue2:ISortedQueue = new IndexQueue();
			Assert.assertTrue(indexQueue.equals(indexQueue2));
		}
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			indexQueue.add(indexableObject0);
			indexQueue.add(indexableObject1);
			
			var queue2:ICollection = getQueue();
			queue2.add(indexableObject1);
			queue2.add(indexableObject0);
			
			Assert.assertTrue(indexQueue.equals(queue2));
		}
		
		////////////////////////////////
		// IndexQueue().offer() TESTS //
		////////////////////////////////
		
		[Test]
		public function offer_nullArgument_ReturnsFalse(): void
		{
			var added:Boolean = indexQueue.offer(null);
			Assert.assertFalse(added);
		}
		
		[Test]
		public function offer_invalidArgument_ReturnsFalse(): void
		{
			var added:Boolean = indexQueue.offer("element-1");
			Assert.assertFalse(added);
		}
		
		[Test]
		public function offer_validArgument_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			
			var added:Boolean = indexQueue.offer(indexableObject0);
			Assert.assertTrue(added);
		}
		
		///////////////////////////////
		// IndexQueue().poll() TESTS //
		///////////////////////////////
		
		[Test]
		public function poll_addTwoValidElements_callPollAndCheckIfCorrectElementWasReturned_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			
			indexQueue.add(indexableObject0);
			indexQueue.add(indexableObject1);
			
			var element:IndexableObject = indexQueue.poll();
			Assert.assertEquals(indexableObject0, element);
		}
		
		//////////////////////
		// IndexEvent TESTS //
		//////////////////////
		
		[Test]
		public function queueWithThreeElements_changeIndexOfLastElementToFirstElement_callPollAndCheckIfCorrectElementWasReturned_ReturnsTrue(): void
		{
			var indexableObject0:IndexableObject = new IndexableObject(0);
			var indexableObject1:IndexableObject = new IndexableObject(1);
			var indexableObject2:IndexableObject = new IndexableObject(2);
			
			indexQueue.add(indexableObject0);
			indexQueue.add(indexableObject1);
			indexQueue.add(indexableObject2);
			
			indexableObject2.index = -1;
			
			var element:IndexableObject = indexQueue.poll();
			Assert.assertEquals(indexableObject2, element);
		}
		
	}

}