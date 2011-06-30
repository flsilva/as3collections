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
	import org.as3collections.AbstractListMap;
	import org.as3collections.ICollection;
	import org.as3collections.IIterator;
	import org.as3collections.IList;
	import org.as3collections.IListMap;
	import org.as3collections.IListMapIterator;
	import org.as3collections.IMap;
	import org.as3collections.IMapEntry;
	import org.as3collections.MapEntry;
	import org.as3collections.errors.IndexOutOfBoundsError;
	import org.as3collections.iterators.ListMapIterator;
	import org.as3collections.iterators.MapIterator;
	import org.as3utils.EquatableUtil;

	import flash.errors.IllegalOperationError;

	/**
	 * Array based implementation of the <code>IMap</code> interface.
	 * This implementation provides all of the optional map operations, and permits <code>null</code> values and the <code>null</code> key.
	 * <p>This class makes guarantees as to the order of the map.
	 * The order in which elements are stored is the order in which they were inserted.</p>
	 * <p>This class has great similarity to <code>ArrayList</code> class.
	 * In a way this class can be thought of as an <code>ArrayList</code> of mappings.</p>
	 * <p>It's possible to create typed list maps.
	 * You just sends the <code>ArrayListMap</code> object to the wrapper <code>TypedListMap</code> or uses the <code>MapUtil.getTypedListMap</code>.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IMap;
	 * import org.as3collections.IList;
	 * import org.as3collections.maps.ArrayListMap;
	 * import org.as3collections.maps.MapEntry;
	 * 
	 * var map1:IMap = new ArrayListMap();
	 * var tf1:TextField = new TextField();
	 * var tf2:TextField = new TextField();
	 * 
	 * map1                            // {}
	 * map1.containsKey("a")           // false
	 * map1.containsKey(tf2)           // false
	 * map1.containsValue(2)           // false
	 * map1.containsValue(tf1)         // false
	 * map1.isEmpty()                  // true
	 * map1.size()                     // 0
	 * 
	 * map1.put("a", 1)                // null
	 * map1                            // {a=1}
	 * map1.isEmpty()                  // false
	 * map1.size()                     // 1
	 * map1.containsKey("a")           // true
	 * map1.containsKey(tf2)           // false
	 * map1.containsValue(2)           // false
	 * map1.containsValue(tf1)         // false
	 * 
	 * map1.put("b", 2)                // null
	 * map1                            // {a=1,b=2}
	 * map1.isEmpty()                  // false
	 * map1.size()                     // 2
	 * map1.containsKey("a")           // true
	 * map1.containsKey("b")           // true
	 * map1.containsKey(tf2)           // false
	 * map1.containsValue(2)           // true
	 * 
	 * map1.put("c", 3)                // null
	 * map1                            // {a=1,b=2,c=3}
	 * map1.size()                     // 3
	 * 
	 * map1.put("tf1", tf1)            // null
	 * map1                            // {a=1,b=2,c=3,tf1=[object TextField]}
	 * map1.size()                     // 4
	 * map1.containsValue(tf1)         // true
	 * 
	 * map1.put(tf2, "tf2")            // null
	 * map1                            // {a=1,b=2,c=3,tf1=[object TextField],[object TextField]=tf2}
	 * map1.size()                     // 5
	 * map1.containsKey(tf2)           // true
	 * 
	 * map1.put("a", 1.1)              // 1
	 * map1                            // {a=1.1,b=2,c=3,tf1=[object TextField],[object TextField]=tf2}
	 * map1.size()                     // 5
	 * 
	 * map1.put("tf1", String)         // [object TextField]
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2}
	 * map1.size()                     // 5
	 * 
	 * map1.put(tf2, "tf2.1")          // tf2
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2.1}
	 * map1.size()                     // 5
	 * 
	 * map1.put(Number, 999)           // null
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2.1,[class Number]=999}
	 * map1.size()                     // 6
	 * 
	 * map1.getValue("b")              // 2
	 * 
	 * map1.getValue(tf2)              // tf2.1
	 * 
	 * map1.putAllByObject({fa:"fb",ga:"gb",ha:"hb"});
	 * 
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2.1,[class Number]=999,ha=hb,ga=gb,fa=fb}
	 * 
	 * map1.size()                     // 9
	 * 
	 * map1.getValue("fa")             // fb
	 * 
	 * map1.remove("ga")               // gb
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2.1,[class Number]=999,ha=hb,fa=fb}
	 * map1.size()                     // 8
	 * 
	 * map1.remove("fa")               // fb
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[object TextField]=tf2.1,[class Number]=999,ha=hb}
	 * map1.size()                     // 7
	 * 
	 * map1.remove(tf2)                // tf2.1
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[class Number]=999,ha=hb}
	 * map1.size()                     // 6
	 * 
	 * map1.getValue("fa")             // null
	 * map1.getValue(tf2)              // null
	 * 
	 * var map2:IMap = map1.clone();
	 * 
	 * map2                            // {a=1.1,b=2,c=3,tf1=[class String],[class Number]=999,ha=hb}
	 * map2.size()                     // 6
	 * map2.isEmpty()                  // false
	 * 
	 * map1.equals(map2)               // true
	 * map2.equals(map1)               // true
	 * map2.equals(map2)               // true
	 * 
	 * map2.remove("b")                // 2
	 * map2                            // {a=1.1,c=3,tf1=[class String],[class Number]=999,ha=hb}
	 * map2.equals(map2)               // true
	 * map2.size()                     // 5
	 * 
	 * map1.equals(map2)               // false
	 * map2.equals(map1)               // false
	 * 
	 * map2.getValues()                // [1.1,3,[class String],999,hb]
	 * 
	 * var keysMap2:IList = map2.getKeys();
	 * 
	 * keysMap2                        // [a,c,tf1,[class Number],ha]
	 * 
	 * keysMap2.remove("c")            // true
	 * keysMap2                        // [a,tf1,[class Number],ha]
	 * map2                            // {a=1.1,c=3,tf1=[class String],[class Number]=999,ha=hb}
	 * map2.size()                     // 5
	 * 
	 * map2.removeAll(keysMap2)        // true
	 * map2                            // {c=3}
	 * map2.size()                     // 1
	 * map2.isEmpty()                  // false
	 * 
	 * map2.clear();
	 * 
	 * map2                            // {}
	 * map2.size()                     // 0
	 * map2.isEmpty()                  // true
	 * 
	 * var entry:IMapEntry = new MapEntry("c", 3);
	 * 
	 * entry                           // c=3
	 * map2.putEntry(entry)            // null
	 * map2                            // {c=3}
	 * map2.size()                     // 1
	 * 
	 * map1                            // {a=1.1,b=2,c=3,tf1=[class String],[class Number]=999,ha=hb}
	 * map1.retainAll(map2)            // true
	 * map1                            // {c=3}
	 * map1.size()                     // 1
	 * map1.isEmpty()                  // false
	 * 
	 * map1.put("d", 4)                // null
	 * map1.put("e", 5)                // null
	 * map1.put("f", 6)                // null
	 * map1                            // {c=3,d=4,e=5,f=6}
	 * map1.size()                     // 4
	 * 
	 * var it:IIterator = map1.iterator();
	 * 
	 * var e:&#42;;
	 * 
	 * while (it.hasNext())
	 * {
	 * 
	 *     e = it.next();
	 *     trace(it.pointer() + "=" + e)    // c=3
	 * 
	 *     e = it.next();
	 *     trace(it.pointer() + "=" + e)    // d=4
	 * 
	 *     if (e == 4)
	 *     {
	 *         it.remove();
	 *     }
	 * 
	 *     e = it.next();
	 *     trace(it.pointer() + "=" + e)    // e=5
	 * 
	 *     e = it.next();
	 *     trace(it.pointer() + "=" + e)    // f=6
	 * }
	 * 
	 * map1                            // {c=3,e=5,f=6}
	 * map1.size()                     // 3
	 * </listing>
	 * 
	 * @see org.as3collections.AbstractListMap AbstractListMap
	 * @see org.as3collections.maps.TypedListMap TypedListMap
	 * @see org.as3collections.maps.SortedArrayListMap SortedArrayListMap
	 * @see org.as3collections.utils.MapUtil#getTypedListMap() MapUtil.getTypedListMap()
	 * @author Flávio Silva
	 */
	public class ArrayListMap extends AbstractListMap
	{
		/**
		 * Constructor, creates a new <code>ArrayListMap</code> object.
		 * 
		 * @param 	source 		a map with wich fill this map.
		 */
		public function ArrayListMap(source:IMap = null)
		{
			super(source);
		}

		/**
		 * Removes all of the mappings from this map.
		 * The map will be empty after this call returns.
		 */
		override public function clear(): void
		{
			if (isEmpty()) return;
			
			keys.clear();
			values.clear();
			_modCount++;
		}

		/**
		 * Creates and return a new <code>ArrayListMap</code> object containing all mappings in this map (in the same order).
		 * 
		 * @return 	a new <code>ArrayListMap</code> object containing all mappings in this map.
 		 */
		override public function clone(): *
		{
			return new ArrayListMap(this);
		}

		/**
		 * Returns an iterator over a set of mappings.
		 * <p>This implementation returns a <code>MapIterator</code> object.</p>
		 * 
		 * @return 	an iterator over a set of values.
		 * @see 	org.as3collections.iterators.MapIterator MapIterator
 		 */
		override public function iterator(): IIterator
		{
			return new MapIterator(this);
		}
		
		/**
		 * Returns a <code>IListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 * <p>This implementation returns a <code>ListMapIterator</code> object.</p>
		 * 
		 * @param  	index 	index of first value to be returned from the iterator (by a call to the <code>next</code> method) 
		 * @return 	a <code>ListMapIterator</code> object to iterate over the mappings in this map (in proper sequence), starting at the specified position in this map.
		 */
		override public function listMapIterator(index:int = 0): IListMapIterator
		{
			return new ListMapIterator(this, index);
		}
		
		/**
		 * Associates the specified value with the specified key in this map.
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value, and the order of the key is not affected.
		 * (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for key. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with key, because this implementation supports <code>null</code> values.)
		 */
		override public function put(key:*, value:*): *
		{
			var old:* = null;
			
			if (containsKey(key))
			{
				old = getValue(key);
				values.setAt(indexOfKey(key), value);
				
				valueRemoved(old);
				valueAdded(value);
				
				return old;
			}
			else
			{
				keys.add(key);
				values.add(value);
				
				keyAdded(key);
				valueAdded(value);
				
				return null;
			}
		}
		
		/**
		 * Associates the specified value with the specified key at the specified position in this map.
		 * Shifts the entry currently at that position (if any) and any subsequent entries to the right (adds one to their indices).
		 * 
		 * @param  	index 	index at which the specified entry is to be inserted.
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @throws 	ArgumentError  											if this map already contains the specified key.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt; size())</code>. 
		 */
		override public function putAt(index:int, key:*, value:*): void
		{
			if (containsKey(key))
			{
				var message:String = "Argument <key> is already inside this map (at index: <" + indexOfKey(key) + ">.\n";//TODO:review this message
				message += "Provided <index> argument: " + index + "\n";
				message += "Provided <key> argument: " + key + "\n";
				
				throw new ArgumentError();
			}
			
			checkIndex(index, size());
			keys.addAt(index, key);
			values.addAt(index, value);
			
			keyAdded(key);
			valueAdded(value);
		}

		/**
		 * Removes the mapping for a key from this map if it is present.
		 * <p>Returns the value to which this map previously associated the key, or <code>null</code> if the map contained no mapping for the key.
		 * A return value of <code>null</code> does not <em>necessarily</em> indicate that the map contained no mapping for the key.
		 * It's possible that the map explicitly mapped the key to <code>null</code>.</p>
		 * <p>The map will not contain a mapping for the specified key once the call returns.</p>
		 * 
		 * @param  	key 	the key whose mapping is to be removed from the map.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for <code>key</code>.
		 */
		override public function remove(key:*): *
		{
			if (!containsKey(key)) return null;
			
			var old:* = getValue(key);
			var index:int = indexOfKey(key);
			
			keys.removeAt(index);
			values.removeAt(index);
			
			keyRemoved(key);
			valueRemoved(old);
			
			return old;
		}
		
		/**
		 * Removes the mapping at the specified position in this map (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts one from their indices).
		 * Returns an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map.
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p> 
		 * 
		 * @param  	index 	the index of the mapping to be removed.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeAt</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	an <code>IMapEntry</code> object containing the mapping (key/value) that was removed from the map.
		 */
		override public function removeAt(index:int): IMapEntry
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: <" + index + ">. This map is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			
			checkIndex(index, size() - 1);
			
			var key:* = getKeyAt(index);
			var value:* = getValueAt(index);
			var entry:IMapEntry = new MapEntry(key, value);
			
			keys.removeAt(index);
			values.removeAt(index);
			
			keyRemoved(key);
			valueRemoved(value);
			
			return entry;
		}
		
		/**
		 * Removes all of the mappings whose index is between <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive (optional operation).
		 * Shifts any subsequent mappings to the left (subtracts their indices).
		 * <p>If <code>toIndex == fromIndex</code>, this operation has no effect.</p>
		 * 
		 * @param  	fromIndex 	the index to start removing mappings (inclusive).
		 * @param  	toIndex 	the index to stop removing mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>removeRange</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new map containing all the removed mappings.
		 */
		override public function removeRange(fromIndex:int, toIndex:int): IListMap
		{
			if (isEmpty()) throw new IllegalOperationError("This map is empty.");
			
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			
			var removedKeys:ICollection = keys.removeRange(fromIndex, toIndex);
			var removedValues:ICollection = values.removeRange(fromIndex, toIndex);
			
			var removedMap:IListMap = createEmptyMap();
			var itKeys:IIterator = removedKeys.iterator();
			var itValues:IIterator = removedValues.iterator();
			var removedKey:*;
			var removedValue:*;
			
			while(itKeys.hasNext())
			{
				removedKey = itKeys.next();
				removedValue = itValues.next();
				
				keyRemoved(removedKey);
				valueRemoved(removedValue);
				
				removedMap.put(removedKey, removedValue);
			}
			
			return removedMap;
		}
		
		/**
		 * Replaces the key at the specified position in this map with the specified key (optional operation).
		 * 
		 * @param  	index 	index of the key to replace.
		 * @param  	key 	key to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setKeyAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified key prevents it from being added to this map.
		 * @throws 	ArgumentError  	 										if the specified key is <code>null</code> and this map does not permit <code>null</code> keys.
		 * @throws 	ArgumentError  											if this map already contains the specified key.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the key previously at the specified position.
		 */
		override public function setKeyAt(index:int, key:*): *
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: <" + index + ">. This map is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			checkIndex(index, size() - 1);
			
			var old:* = keys.getAt(index);
			
			if (!EquatableUtil.areEqual(old, key) && containsKey(key))
			{
				var message:String = "Argument <key> is already inside this map (at index: <" + indexOfKey(key) + ">.\n";//TODO:review this message
				message += "Provided <index> argument: " + index + "\n";
				message += "Provided <key> argument: " + key + "\n";
				
				throw new ArgumentError();
			}
			
			keys.setAt(index, key);
			
			keyRemoved(old);
			keyAdded(key);
			_modCount -= 2;// keyRemoved() and keyAdded() will undesirably increase modCount.
			
			return old;
		}
		
		/**
		 * Replaces the value at the specified position in this map with the specified value (optional operation).
		 * <p>This implementation always throws an <code>UnsupportedOperationError</code>.</p>
		 * 
		 * @param  	index 	index of the value to replace.
		 * @param  	value 	value to be stored at the specified position.
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>setValueAt</code> operation is not supported by this map.
		 * @throws 	org.as3coreaddendum.errors.ClassCastError  				if the class of the specified value prevents it from being added to this map.
		 * @throws 	ArgumentError  	 										if the specified value is <code>null</code> and this map does not permit <code>null</code> values.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if the index is out of range <code>(index &lt; 0 || index &gt;= size())</code>.
		 * @return 	the value previously at the specified position.
		 */
		override public function setValueAt(index:int, value:*): *
		{
			if (isEmpty()) throw new IndexOutOfBoundsError("The 'index' argument is out of bounds: <" + index + ">. This map is empty.");//TODO:pensar em mudar para outro erro, por ex IllegalOperationError
			checkIndex(index, size() - 1);
			
			var old:* = values.getAt(index);
			values.setAt(index, value);
			
			valueRemoved(old);
			valueAdded(value);
			
			return old;
		}
		
		/**
		 * Returns a new map that is a view of the portion of this map between the specified <code>fromIndex</code>, inclusive, and <code>toIndex</code>, exclusive.
		 * <p>The returned map supports all of the optional map operations supported by this map.</p>
		 * 
		 * @param  	fromIndex 	the index to start retrieving mappings (inclusive).
		 * @param  	toIndex 	the index to stop retrieving mappings (exclusive).
		 * @throws 	org.as3coreaddendum.errors.UnsupportedOperationError  	if the <code>subMap</code> operation is not supported by this map.
		 * @throws 	org.as3collections.errors.IndexOutOfBoundsError 		if <code>fromIndex</code> or <code>toIndex</code> is out of range <code>(index &lt; 0 || index &gt; size())</code>.
		 * @return 	a new list that is a view of the specified range within this list.
		 */
		override public function subMap(fromIndex:int, toIndex:int): IListMap
		{
			if (isEmpty()) throw new IllegalOperationError("This ArrayListMap instance is empty.");
			
			checkIndex(fromIndex, size());
			checkIndex(toIndex, size());
			
			if (fromIndex > toIndex) throw new ArgumentError("Argument <fromIndex> cannot be greater than argument <toIndex>. fromIndex: " + fromIndex + " | toIndex" + toIndex);
			
			var entryList:IList = (entryCollection() as IList).subList(fromIndex, toIndex);
			var map:IListMap = createEmptyMap();
			
			var it:IIterator = entryList.iterator();
			
			while (it.hasNext())
			{
				map.putEntry(it.next());
			}
			
			return map;
		}
		
		/**
		 * @private
		 */
		protected function createEmptyMap(): IListMap
		{
			return new ArrayListMap();
		}

	}

}