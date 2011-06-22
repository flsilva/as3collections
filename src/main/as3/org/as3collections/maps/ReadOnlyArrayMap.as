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

package org.as3collections.maps 
{
	import org.as3collections.AbstractArrayMap;
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3collections.iterators.ReadOnlyMapIterator;
	import org.as3coreaddendum.errors.NullPointerError;
	import org.as3coreaddendum.errors.UnsupportedOperationError;
	import org.as3utils.ReflectionUtil;

	/**
	 * An <code>ArrayMap</code> that doesn't allow modifications.
	 * It receives all the mappings by its constructor and can no longer be changed.
	 * All methods that change the map will throw an <code>UnsupportedOperationError</code>.
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IMap;
	 * import org.as3collections.maps.ArrayMap;
	 * import org.as3collections.maps.ReadOnlyArrayMap;
	 * 
	 * var map1:IMap = new ArrayMap();
	 * 
	 * map1.put("fa", "fb"):     // null
	 * map1.put("ga", "gb"):     // null
	 * map1.put("ha", "hb"):     // null
	 * 
	 * map1                      // {fa=fb,ga=gb,ha=hb}
	 * map1.size()               // 3
	 * 
	 * var map2:IMap = new ReadOnlyArrayMap(map1);
	 * 
	 * map2                      // {fa=fb,ga=gb,ha=hb}
	 * map2.size()               // 3
	 * 
	 * map2.put(1, 2)            // UnsupportedOperationError: ReadOnlyArrayMap is a read-only map and doesn't allow modifications.
	 * 
	 * map2.remove(1)            // UnsupportedOperationError: ReadOnlyArrayMap is a read-only map and doesn't allow modifications.
	 * </listing>
	 * 
	 * @author Flávio Silva
	 */
	public class ReadOnlyArrayMap extends AbstractArrayMap
	{
		/**
		 * Constructor, creates a new <code>ReadOnlyArrayMap</code> object.
		 * 
		 * @param 	source 	an map to fill the list.
		 * @throws 	org.as3coreaddendum.errors.NullPointerError  	if the <code>source</code> argument is <code>null</code>.
		 */
		public function ReadOnlyArrayMap(source:IMap)
		{
			if (!source) throw new NullPointerError("The 'source' argument must not be 'null'.");
			
			var it:IIterator = source.iterator();
			var value:*;
			
			while (it.hasNext())
			{
				value = it.next();
				
				keys.push(it.pointer());
				values.push(value);
				
				checkKeyEquatable(it.pointer());
				checkValueEquatable(value);
			}
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 */
		override public function clear(): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * Creates and return a new <code>ReadOnlyArrayMap</code> object containing all mappings in this map (in the same order).
		 * 
		 * @return 	a new <code>ReadOnlyArrayMap</code> object containing all mappings in this map (in the same order).
 		 */
		override public function clone(): *
		{
			return new ReadOnlyArrayMap(this);
		}
		
		/**
		 * Returns an iterator over a set of mappings.
		 * <p>This implementation returns a <code>ReadOnlyMapIterator</code> object.</p>
		 * 
		 * @return 	an iterator over a set of values.
		 * @see 	org.as3collections.iterators.ReadOnlyMapIterator ReadOnlyMapIterator
		 */
		override public function iterator(): IIterator
		{
			return new ReadOnlyMapIterator(this);
		}
		
		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param key
		 * @param value
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 * @return 
		 */
		override public function put(key:*, value:*): *
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param map
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 */
		override public function putAll(map:IMap): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param o
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 */
		override public function putAllByObject(o:Object): void
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param entry
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 * @return
		 */
		override public function putEntry(entry:IMapEntry): *
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param key
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 * @return
		 */
		override public function remove(key:*): *
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param keys
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 * @return
		 */
		override public function removeAll(keys:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

		/**
		 * This implementation always throws an <code>UnsupportedOperationError</code>.
		 * 
		 * @param keys
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	<code>ReadOnlyArrayMap</code> is a read-only map and doesn't allow modifications.
		 * @return
		 */
		override public function retainAll(keys:ICollection): Boolean
		{
			throw new UnsupportedOperationError(ReflectionUtil.getClassName(this) + " is a read-only map and doesn't allow modifications.");
		}

	}

}