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
	import org.as3collections.lists.ArrayListTests;
	import org.as3collections.lists.ArrayListTestsEquatableObject;
	import org.as3collections.lists.ReadOnlyArrayListTests;
	import org.as3collections.lists.SortedArrayListTests;
	import org.as3collections.lists.SortedArrayListTestsEquatableObject;
	import org.as3collections.lists.TypedListTests;
	import org.as3collections.lists.UniqueListTests;
	import org.as3collections.lists.UniqueListTestsEquatableObject;
	import org.as3collections.queues.LinearQueueTests;
	import org.as3collections.queues.LinearQueueTestsEquatableObject;

	/**
	 * @author Flávio Silva
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite
	{
		
		//org.as3collections.lists
		public var arrayListTests:ArrayListTests;
		public var arrayListTestsEquatableObject:ArrayListTestsEquatableObject;
		public var readOnlyArrayListTests:ReadOnlyArrayListTests;
		public var sortedArrayListTests:SortedArrayListTests;
		public var sortedArrayListTestsEquatableObject:SortedArrayListTestsEquatableObject;
		public var typedListTests:TypedListTests;
		public var uniqueListTests:UniqueListTests;
		public var uniqueListTestsEquatableObject:UniqueListTestsEquatableObject;
		
		//org.as3collections.queues
		public var linearQueueTests:LinearQueueTests;
		public var linearQueueTestsEquatableObject:LinearQueueTestsEquatableObject;
		
		public function TestSuite()
		{
			
		}

	}

}