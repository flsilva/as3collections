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

package 
{
	import org.as3collections.AbstractCollectionTests;
	import org.as3collections.AbstractListTests;
	import org.as3collections.iterators.ArrayIteratorTests;
	import org.as3collections.iterators.ListIteratorTests;
	import org.as3collections.iterators.MapIteratorTests;
	import org.as3collections.iterators.ReadOnlyArrayIteratorTests;
	import org.as3collections.iterators.ReadOnlyListIteratorTests;
	import org.as3collections.iterators.ReadOnlyMapIteratorTests;
	import org.as3collections.lists.ArrayListTests;
	import org.as3collections.lists.ArrayListTestsEquatableObject;
	import org.as3collections.lists.ReadOnlyArrayListTests;
	import org.as3collections.lists.SortedArrayListTests;
	import org.as3collections.lists.SortedArrayListTestsEquatableObject;
	import org.as3collections.lists.TypedListTests;
	import org.as3collections.lists.UniqueListTests;
	import org.as3collections.lists.UniqueListTestsEquatableObject;
	import org.as3collections.maps.ArrayMapTests;
	import org.as3collections.maps.ArrayMapTestsEquatableObject;
	import org.as3collections.maps.HashMapTests;
	import org.as3collections.maps.HashMapTestsEquatableObject;
	import org.as3collections.maps.ReadOnlyArrayMapTests;
	import org.as3collections.maps.ReadOnlyHashMapTests;
	import org.as3collections.maps.SortedArrayMapTests;
	import org.as3collections.maps.TypedMapTests;
	import org.as3collections.maps.TypedMapTestsConstructor;
	import org.as3collections.maps.TypedSortedMapTests;
	import org.as3collections.maps.TypedSortedMapTestsConstructor;
	import org.as3collections.queues.IndexablePriorityQueueTests;
	import org.as3collections.queues.LinearQueueTests;
	import org.as3collections.queues.LinearQueueTestsEquatableObject;
	import org.as3collections.queues.PriorityQueueTests;
	import org.as3collections.queues.SortedQueueTests;
	import org.as3collections.queues.SortedQueueTestsEquatableObject;
	import org.as3collections.queues.TypedQueueTests;
	import org.as3collections.queues.UniqueQueueTests;
	import org.as3collections.queues.UniqueQueueTestsEquatableObject;

	/**
	 * @author Flávio Silva
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		
		//org.as3collections
		public var abstractCollectionTests:AbstractCollectionTests;
		public var abstractListTests:AbstractListTests;
		
		//org.as3collections.iterators
		public var arrayIteratorTests:ArrayIteratorTests;
		public var listIteratorTests:ListIteratorTests;
		public var mapIteratorTests:MapIteratorTests;
		public var readOnlyArrayIteratorTests:ReadOnlyArrayIteratorTests;
		public var readOnlyListIteratorTests:ReadOnlyListIteratorTests;
		public var readOnlyMapIteratorTests:ReadOnlyMapIteratorTests;
		
		//org.as3collections.lists
		public var arrayListTests:ArrayListTests;
		public var arrayListTestsEquatableObject:ArrayListTestsEquatableObject;
		public var readOnlyArrayListTests:ReadOnlyArrayListTests;
		public var sortedArrayListTests:SortedArrayListTests;
		public var sortedArrayListTestsEquatableObject:SortedArrayListTestsEquatableObject;
		public var typedListTests:TypedListTests;
		public var uniqueListTests:UniqueListTests;
		public var uniqueListTestsEquatableObject:UniqueListTestsEquatableObject;
		
		//org.as3collections.maps
		public var arrayMapTests:ArrayMapTests;
		public var arrayMapTestsEquatableObject:ArrayMapTestsEquatableObject;
		public var hashMapTests:HashMapTests;
		public var hashMapTestsEquatableObject:HashMapTestsEquatableObject;
		public var readOnlyArrayMapTests:ReadOnlyArrayMapTests;
		public var readOnlyHashMapTests:ReadOnlyHashMapTests;
		public var sortedArrayMapTests:SortedArrayMapTests;
		public var typedMapTests:TypedMapTests;
		public var typedMapTestsConstructor:TypedMapTestsConstructor;
		public var typedSortedMapTests:TypedSortedMapTests;
		public var typedSortedMapTestsConstructor:TypedSortedMapTestsConstructor;
		
		//org.as3collections.queues
		public var indexablePriorityQueueTests:IndexablePriorityQueueTests;
		public var linearQueueTests:LinearQueueTests;
		public var linearQueueTestsEquatableObject:LinearQueueTestsEquatableObject;
		public var priorityQueueTests:PriorityQueueTests;
		public var sortedQueueTests:SortedQueueTests;
		public var sortedQueueTestsEquatableObject:SortedQueueTestsEquatableObject;
		public var typedQueueTests:TypedQueueTests;
		public var uniqueQueueTests:UniqueQueueTests;
		public var uniqueQueueTestsEquatableObject:UniqueQueueTestsEquatableObject;
		
		public function TestSuite()
		{
			
		}

	}

}