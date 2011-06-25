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
	import org.as3collections.IQueueTestsEquatableObject;
	import org.as3collections.ISortedQueue;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class SortedQueueTestsEquatableObject extends IQueueTestsEquatableObject
	{
		
		public function get sortedQueue():ISortedQueue { return collection as ISortedQueue; }
		
		public function SortedQueueTestsEquatableObject()
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
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList:ISortedQueue = new SortedQueue([equatableObject1A, equatableObject2A]);
			
			var isEmpty:Boolean = newList.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newList:ISortedQueue = new SortedQueue([equatableObject1A, equatableObject2A]);
			
			var size:int = newList.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function options_changeOptionsAndCallPollToCheckIfListWasReorderedAndCorrectElementReturned_ReturnTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			sortedQueue.add(equatableObject1A);
			sortedQueue.add(equatableObject2A);
			sortedQueue.options = Array.DESCENDING;
			
			var element:String = sortedQueue.poll();
			Assert.assertEquals(equatableObject2A, element);
		}
		
		///////////////////////////////
		// SortedQueue().add() TESTS //
		///////////////////////////////
		
		[Test(expects="ArgumentError")]
		public function add_nullArgument_ThrowsError(): void
		{
			queue.add(null);
		}
		
		[Test]
		public function add_validDuplicateNotEquatableArgument_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			
			queue.add(equatableObject1A);
			
			var added:Boolean = queue.add(equatableObject1A);
			Assert.assertTrue(added);
		}
		
		[Test]
		public function add_validDuplicateNotEquatableArgument_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			queue.add(equatableObject1A);
			queue.add(equatableObject1B);
			
			var size:int = queue.size();
			Assert.assertEquals(2, size);
		}
		
		///////////////////////////////////
		// SortedQueue().dequeue() TESTS //
		///////////////////////////////////
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			queue.add(equatableObject2A);
			queue.add(equatableObject1A);
			
			var element:String = queue.dequeue();
			Assert.assertEquals(equatableObject1A, element);
		}
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_callTwiceAndCheckIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			queue.add(equatableObject2A);
			queue.add(equatableObject1A);
			queue.dequeue();
			
			var element:String = queue.dequeue();
			Assert.assertEquals(equatableObject2A, element);
		}
		
		////////////////////////////
		// IList().equals() TESTS //
		////////////////////////////
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_createdWithDifferentOrderButShouldBeCorrectlyOrdered_checkIfBothQueuesAreEqual_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			queue.add(equatableObject1A);
			queue.add(equatableObject2A);
			
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2B:EquatableObject = new EquatableObject("equatable-object-2");
			
			var queue2:ICollection = getCollection();
			queue2.add(equatableObject2B);
			queue2.add(equatableObject1B);
			
			Assert.assertTrue(queue.equals(queue2));
		}
		
		/////////////////////////////////
		// SortedQueue().offer() TESTS //
		/////////////////////////////////
		
		[Test]
		public function offer_validDuplicateNotEquatableArgument_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			queue.add(equatableObject1A);
			
			var added:Boolean = queue.offer(equatableObject1A);
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_validDuplicateNotEquatableArgument_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			queue.offer(equatableObject1A);
			queue.offer(equatableObject1B);
			
			var size:int = queue.size();
			Assert.assertEquals(2, size);
		}
		
	}

}