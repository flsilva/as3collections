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

package org.as3collections.utils 
{
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.lists.ArrayList;
	import org.as3coreaddendum.system.IEquatable;
	import org.as3coreaddendum.system.comparators.AlphabeticalComparison;
	import org.as3utils.ArrayUtil;
	import org.as3utils.ReflectionUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * A utility class to work with implementations of the <code>ICollection</code> interface.
	 * <p><code>CollectionUtil</code> handles <code>null</code> input collections quietly in almost all methods. When not, it's documented in the method.
	 * That is to say that a <code>null</code> input will not thrown an error in almost all methods.</p>
	 * 
	 * @author Flávio Silva
	 */
	public class CollectionUtil
	{
		/**
		 * <code>CollectionUtil</code> is a static class and shouldn't be instantiated.
		 * 
		 * @throws 	IllegalOperationError 	<code>CollectionUtil</code> is a static class and shouldn't be instantiated.
		 */
		public function CollectionUtil()
		{
			throw new IllegalOperationError("CollectionUtil is a static class and shouldn't be instantiated.");
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between the two arguments.
		 * If one of the collections or both collections are <code>null</code> it will be returned <code>false</code>.
		 * <p>Two different objects are considered equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * <li>elements have exactly the same order</li>
		 * </ul></p>
		 * <p>This implementation <b>takes care</b> of the order of the elements in the collections.
		 * So, for two collections are equal the order of elements returned by the iterator object must be equal.</p>
		 * 
		 * @param  	collection1 	the first collection.
		 * @param  	collection2 	the second collection.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public static function equalConsideringOrder(collection1:ICollection, collection2:ICollection): Boolean
		{
			if (!collection1 || !collection2) return false;
			if (collection1 == collection2) return true;
			
			if (!ReflectionUtil.classPathEquals(collection1, collection2)) return false;
			if (collection1.size() != collection2.size()) return false;
			
			var itC1:IIterator = collection1.iterator();
			var itC2:IIterator = collection2.iterator();
			var o1:*;
			var o2:*;
			
			//two loops for better performance
			if (collection1.allEquatable && collection2.allEquatable)
			{
				while (itC1.hasNext())
				{
					o1 = itC1.next();
					o2 = itC2.next();
					
					if (!(o1 as IEquatable).equals(o2)) return false;
				}
			}
			else
			{
				while (itC1.hasNext())
				{
					o1 = itC1.next();
					o2 = itC2.next();
					
					if (o1 != o2) return false;
				}
			}
			
			return true;
		}
		
		/**
		 * Performs an arbitrary, specific evaluation of equality between this object and the <code>other</code> object.
		 * If one of the collections or both collections are <code>null</code> it will be returned <code>false</code>.
		 * <p>Two different objects are considered equal if:</p>
		 * <p>
		 * <ul><li>object A and object B are instances of the same class (i.e. if they have <b>exactly</b> the same type)</li>
		 * <li>object A contains all elements of object B</li>
		 * <li>object B contains all elements of object A</li>
		 * </ul></p>
		 * <p>This implementation <b>does not takes care</b> of the order of the elements in the collections.
		 * 
		 * @param  	collection1 	the first collection.
		 * @param  	collection2 	the second collection.
		 * @return 	<code>true</code> if the arbitrary evaluation considers the objects equal.
		 */
		public static function equalNotConsideringOrder(collection1:ICollection, collection2:ICollection): Boolean
		{
			if (!collection1 || !collection2) return false;
			if (collection1 == collection2) return true;
			
			if (!ReflectionUtil.classPathEquals(collection1, collection2)) return false;
			if (collection1.size() != collection2.size()) return false;
			
			return collection1.containsAll(collection2) && collection2.containsAll(collection1);
		}
		
		/**
		 * Returns the collection object containing only objects of the type of the <code>type</code> argument.
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection for filtering. May be <code>null</code>.
		 * @param  	type 		the type of the objects that should remain in the collection.
		 * @return 	the collection object containing only objects of the type of the <code>type</code> argument.
		 */
		public static function filterByType(collection:ICollection, type:Class): ICollection
		{
			if (!collection || collection.isEmpty()) return collection;
			
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (!ReflectionUtil.classPathEquals(it.next(), type)) it.remove();
			}
			
			return collection;
		}

		/**
		 * Returns the largest number in the specified collection.
		 * 
		 * @param  	collection 	the collection object to check. May be <code>null</code>.
		 * @return 	the largest number in the collection object. If the collection argument is <code>null</code> or empty then the return is <code>NaN</code>.
		 */
		public static function maxValue(collection:ICollection): Number
		{
			if (!collection || collection.isEmpty()) return NaN;
			
			var arr:Array = collection.toArray();
			return ArrayUtil.maxValue(arr);
		}

		/**
		 * Returns the index position of the largest number in the specified collection.
		 * 
		 * @param  	collection 	the collection object to check. May be <code>null</code>.
		 * @return 	the index position of the largest number in the collection object. If the collection argument is <code>null</code> or empty then the return is -1.
		 */
		public static function maxValueIndex(collection:ICollection): int
		{
			if (!collection || collection.isEmpty()) return -1;
			
			var arr:Array = collection.toArray();
			return ArrayUtil.maxValueIndex(arr);
		}

		/**
		 * Removes all occurances of a the given <code>element</code> argument from the given collection argument.
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param collection
		 * @param element
		 * @return
		 */
		public static function removeAllOccurances(collection:ICollection, element:*): ICollection
		{
			if (!collection || collection.isEmpty()) return null;
			
			var it:IIterator = collection.iterator();
			
			while (it.hasNext())
			{
				if (it.next() == element) it.remove();
			}
			
			return collection;
		}

		/**
		 * Removes duplicated objects.
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to remove duplicated objects.
		 * @return 	the collection object without duplicated objects.
		 */
		public static function removeDuplicate(collection:ICollection): ICollection
		{
			if (!collection || collection.isEmpty()) return collection;
			
			var it:IIterator = collection.iterator();
			var e:*;
			
			if (collection.allEquatable)
			{
				var list:ArrayList = new ArrayList();
				
				while (it.hasNext())
				{
					e = it.next();
					
					if (list.contains(e)) it.remove();
					
					list.add(e);
				}
			}
			else
			{
				var arr:Array = [];
				
				while (it.hasNext())
				{
					e = it.next();
					
					if (arr.indexOf(e) != -1) it.remove();
					
					arr.push(e);
				}
			}
			
			return collection;
		}

		/**
		 * Shuffles the position of the elements of the given <code>collection</code>.
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to shuffle. May be <code>null</code>.
		 * @return 	the modified collection.
		 */
		public static function shuffle(collection:ICollection): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.shuffle(arr);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the collection of <code>String</code> objects alphabetically.
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortAlphabetically</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 		the collection to sort.
		 * @param  	comparison		indicates which type of comparison will be used.
		 * @return 	the sorted collection.
		 */
		public static function sortAlphabetically(collection:ICollection, comparison:AlphabeticalComparison): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortAlphabetically(arr, comparison);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the collection of objects alphabetically through the object's <code>property</code>.
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortAlphabeticallyByObjectProperty</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 		the collection to sort.
		 * @param  	property 		the name of the property to be recovered and compared between the objects.
		 * @param  	comparison		indicates which type of comparison will be used.
		 * @return 	the sorted collection.
		 */
		public static function sortAlphabeticallyByObjectProperty(collection:ICollection, property:String, comparison:AlphabeticalComparison): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortAlphabeticallyByObjectProperty(arr, property, comparison);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the collection of <code>Number</code> objects ascending.
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortAscending</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to sort.
		 * @return 	the sorted collection.
		 */
		public static function sortAscending(collection:ICollection): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortAscending(arr);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the collection of objects ascending through the object's property (must be a numeric value).
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortAscendingByObjectProperty</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to sort.
		 * @param  	property 	the name of the property to be recovered and compared between the objects.
		 * @return 	the sorted collection.
		 */
		public static function sortAscendingByObjectProperty(collection:ICollection, property:String): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortAscendingByObjectProperty(arr, property);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the array of <code>Number</code> objects descending.
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortDescending</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to sort.
		 * @return 	the sorted collection.
		 */
		public static function sortDescending(collection:ICollection): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortDescending(arr);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

		/**
		 * Sorts the array of objects descending through the object's property (must be a numeric value).
		 * <p>This method uses the <code>org.as3coreaddendum.utils.ArrayUtil.sortDescendingByObjectProperty</code> method.</p>
		 * <p>This method modifies the original collection. Be sure that it's not a ready-only collection.</p>
		 * 
		 * @param  	collection 	the collection to sort. 	
		 * @param  	property 	the name of the property to be recovered and compared between the objects. 	
		 * @return 	the sorted collection.
		 */
		public static function sortDescendingByObjectProperty(collection:ICollection, property:String): ICollection
		{
			var arr:Array = collection.toArray();
			
			ArrayUtil.sortDescendingByObjectProperty(arr, property);
			
			collection.clear();
			collection.addAll(new ArrayList(arr));
			return collection;
		}

	}

}