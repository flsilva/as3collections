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
	import org.as3collections.UniqueCollectionTests;
	import org.flexunit.Assert;

	/**
	 * @author Flávio Silva
	 */
	public class UniqueQueueTestsEquatableObject extends UniqueCollectionTests
	{
		
		public function get queue():IQueue { return collection as IQueue; }
		
		public function UniqueQueueTestsEquatableObject()
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
		// LinearQueue() constructor TESTS //
		/////////////////////////////////////
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfIsEmpty_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newQueue:IQueue = new UniqueQueue(new LinearQueue([equatableObject1A, equatableObject2A]));
			
			var isEmpty:Boolean = newQueue.isEmpty();
			Assert.assertFalse(isEmpty);
		}
		
		[Test]
		public function constructor_argumentWithTwoNotDuplicateNotEquatableElements_checkIfSizeIsTwo_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			var newQueue:IQueue = new UniqueQueue(new LinearQueue([equatableObject1A, equatableObject2A]));
			
			var size:int = newQueue.size();
			Assert.assertEquals(2, size);
		}
		
		[Test]
		public function constructor_argumentWithTwoDuplicateNotEquatableElements_checkIfSizeIsOne_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			var newQueue:IQueue = new UniqueQueue(new LinearQueue([equatableObject1A, equatableObject1B]));
			
			var size:int = newQueue.size();
			Assert.assertEquals(1, size);
		}
		
		///////////////////////////////
		// LinearQueue().add() TESTS //
		///////////////////////////////
		
		[Test(expects="org.as3coreaddendum.errors.NullPointerError")]
		public function add_nullArgument_ThrowsError(): void
		{
			queue.add(null);
		}
		
		[Test(expects="flash.errors.IllegalOperationError")]
		public function add_duplicateNotEquatableArgument_ThrowsError(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject1B:EquatableObject = new EquatableObject("equatable-object-1");
			
			queue.add(equatableObject1A);
			queue.add(equatableObject1B);
		}
		
		///////////////////////////////////
		// LinearQueue().dequeue() TESTS //
		///////////////////////////////////
		
		[Test]
		public function dequeue_queueWithTwoNotEquatableElement_checkIfReturnedElementIsCorrect_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var equatableObject2A:EquatableObject = new EquatableObject("equatable-object-2");
			
			queue.add(equatableObject2A);
			queue.add(equatableObject1A);
			
			var element:String = queue.dequeue();
			Assert.assertEquals(equatableObject2A, element);
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
			Assert.assertEquals(equatableObject1A, element);
		}
		
		//////////////////////////////////
		// UniqueQueue().equals() TESTS //
		//////////////////////////////////
		
		[Test]
		public function equals_queueWithTwoNotEquatableElements_sameElementsButDifferentOrder_checkIfBothQueueAreEqual_ReturnsFalse(): void
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
			
			Assert.assertFalse(queue.equals(queue2));
		}
		
		/////////////////////////////////
		// UniqueQueue().offer() TESTS //
		/////////////////////////////////
		
		[Test]
		public function offer_notDuplicateNotEquatableElement_ReturnsTrue(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			var added:Boolean = queue.offer(equatableObject1A);
			Assert.assertTrue(added);
		}
		
		[Test]
		public function offer_duplicateNotEquatableElement_ReturnsFalse(): void
		{
			var equatableObject1A:EquatableObject = new EquatableObject("equatable-object-1");
			queue.offer(equatableObject1A);
			
			var added:Boolean = queue.offer(equatableObject1A);
			Assert.assertFalse(added);
		}
		
	}

}