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
	import org.as3collections.IQueueTests;
	import org.as3collections.ISortedList;
	import org.as3collections.ISortedQueue;
	import org.as3collections.PriorityObject;
	import org.as3collections.lists.SortedArrayList;
	import org.as3coreaddendum.system.IComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparator;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3coreaddendum.system.comparators.NumberComparator;
	import org.as3coreaddendum.system.comparators.PriorityComparator;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class SortedQueueTests extends IQueueTests
	{
		
		public function get sortedQueue():ISortedQueue { return collection as ISortedQueue; }
		
		public function SortedQueueTests()
		{
			
		}
		
		////////////////////
		// HELPER METHODS //
		////////////////////
		
		override public function getCollection():ICollection
		{
			return new SortedQueue();
		}
		
		/////////////////////////////////////
		// SortedQueue() constructor TESTS //
		/////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var newQueue:ISortedQueue = new SortedQueue(["element-1", "element-2"]);
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var newQueue:ISortedQueue = new SortedQueue(["element-1", "element-2"]);
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		////////////////////////////////////
		// SortedQueue().comparator TESTS //
		////////////////////////////////////
		
		[Test]
		public function comparator_createQueueWithComparator_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedQueue:ISortedQueue = new SortedQueue(null, comparator);
			
			Assert.assertEquals(comparator, newSortedQueue.comparator);
		}
		
		[Test]
		public function comparator_createQueueWithComparatorButChangesIt_checkIfReturnedComparatorMathes_ReturnTrue(): void
		{
			var comparator1:IComparator = new AlphabeticalComparator(AlphabeticalComparison.CASE_INSENSITIVE);
			var newSortedQueue:ISortedQueue = new SortedQueue(null, comparator1);
			
			var comparator2:IComparator = new NumberComparator();
			newSortedQueue.comparator = comparator2;
			
			Assert.assertEquals(comparator2, newSortedQueue.comparator);
		}
		
		[Test]
		public function comparator_changeComparatorAndCallPollToCheckIfListWasReorderedAndCorrectElementReturned_ReturnTrue(): void
		{
			var priorityObject1:PriorityObject = new PriorityObject(1);
			var priorityObject2:PriorityObject = new PriorityObject(2);
			var priorityObject3:PriorityObject = new PriorityObject(3);
			
			sortedQueue.add(priorityObject2);
			sortedQueue.add(priorityObject3);
			sortedQueue.add(priorityObject1);
			
			var newComparator:IComparator = new PriorityComparator();
			sortedQueue.comparator = newComparator;
			
			var element:PriorityObject = sortedQueue.poll();
			Assert.assertEquals(priorityObject3, element);
		}
		
		/////////////////////////////////
		// SortedQueue().options TESTS //
		/////////////////////////////////
		
		[Test]
		public function options_createQueueWithOptions_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedQueue:ISortedQueue = new SortedQueue(null, null, options);
			
			Assert.assertEquals(options, newSortedQueue.options);
		}
		
		[Test]
		public function options_createQueueWithOptionsButChangesIt_checkIfReturnedOptionsMathes_ReturnTrue(): void
		{
			var options:uint = Array.CASEINSENSITIVE;
			var newSortedQueue:ISortedQueue = new SortedQueue(null, null, options);
			
			var options2:uint = Array.NUMERIC;
			newSortedQueue.options = options2;
			
			Assert.assertEquals(options2, newSortedQueue.options);
		}
		
		[Test]
		public function options_changeOptionsAndCallPollToCheckIfListWasReorderedAndCorrectElementReturned_ReturnTrue(): void
		{
			sortedQueue.add("element-1");
			sortedQueue.add("element-2");
			sortedQueue.options = Array.DESCENDING;
			
			var element:String = sortedQueue.poll();
			Assert.assertEquals("element-2", element);
		}
		
		///////////////////////////////
		// SortedQueue().add() TESTS //
		///////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
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
		// SortedQueue().dequeue() TESTS //
		///////////////////////////////////
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			queue.add("element-2");
			queue.add("element-1");
			
			var element:String = queue.dequeue();
			Assert.assertEquals("element-1", element);
		}
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_callTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			queue.add("element-2");
			queue.add("element-1");
			queue.dequeue();
			
			var element:String = queue.dequeue();
			Assert.assertEquals("element-2", element);
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_twoEmptyQueuesCreatedWithDifferentSortOptions_checkIfBothQueuesAreEqual_ReturnsFalse(): void
		{
			sortedQueue.options = 0;//ASCENDING
			
			var sortedQueue2:ISortedList = new SortedArrayList();
			sortedQueue2.options = Array.DESCENDING;
			
			Assert.assertFalse(sortedQueue.equals(sortedQueue2));
		}
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			queue.add("element-1");
			queue.add("element-2");
			
			var queue2:ICollection = getCollection();
			queue2.add("element-2");
			queue2.add("element-1");
			
			Assert.assertTrue(queue.equals(queue2));
		}
		
		/////////////////////////////////
		// SortedQueue().offer() TESTS //
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
		
		////////////////////////////////
		// SortedQueue().poll() TESTS //
		////////////////////////////////
		
		[Test]
		public function poll_queueWithIntegerElements_numericAscendingOrder_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			sortedQueue.options = Array.NUMERIC;
			
			sortedQueue.add(5);
			sortedQueue.add(9);
			sortedQueue.add(7);
			
			sortedQueue.poll();
			
			var element:int = sortedQueue.poll();
			Assert.assertEquals(7, element);
		}
		
		[Test]
		public function poll_queueWithIntegerElements_numericDescendingOrder_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			sortedQueue.options = Array.NUMERIC | Array.DESCENDING;
			
			sortedQueue.add(5);
			sortedQueue.add(9);
			sortedQueue.add(7);
			
			var element:int = sortedQueue.poll();
			Assert.assertEquals(9, element);
		}
		
		//////////////////////////////////
		// SortedQueue().sortOn() TESTS //
		//////////////////////////////////
		
		[Test]
		public function sortOn_queueWithObjectsWithProperty_checkIfElementIsInCorrectIndex_ReturnsTrue(): void
		{
			var obj1:Object = {name:"element-1", age:30};
			var obj2:Object = {name:"element-2", age:10};
			var obj3:Object = {name:"element-3", age:20};
			
			sortedQueue.add(obj1);
			sortedQueue.add(obj2);
			sortedQueue.add(obj3);
			sortedQueue.sortOn("age", Array.NUMERIC);
			
			var element:Object = sortedQueue.poll();
			Assert.assertEquals(obj2, element);
		}
		
	}

}