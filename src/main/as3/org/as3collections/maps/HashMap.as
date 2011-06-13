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
	import org.as3collections.IIterator;
	import org.as3collections.IMap;
	import org.as3collections.iterators.MapIterator;
	import org.as3coreaddendum.system.IEquatable;

	/**
	 * Hash table based implementation of the <code>IMap</code> interface.
	 * This implementation provides all of the optional map operations, and permits <code>null</code> values and the <code>null</code> key.
	 * <p>This class makes no guarantees as to the order of the map.
	 * In particular, it does not guarantee that the order will remain constant over time.</p>
	 * <p>It's possible to create typed maps.
	 * You just sends the <code>HashMap</code> object to the wrapper <code>TypedMap</code> or uses the <code>MapUtil.getTypedMap</code>.</p>
	 * 
	 * @example
	 * 
	 * <listing version="3.0">
	 * import org.as3collections.IMap;
	 * import org.as3collections.IList;
	 * import org.as3collections.maps.HashMap;
	 * import org.as3collections.maps.MapEntry;
	 * 
	 * var map1:IMap = new HashMap();
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
	 * map1                            // {b=2,a=1}
	 * map1.isEmpty()                  // false
	 * map1.size()                     // 2
	 * map1.containsKey("a")           // true
	 * map1.containsKey("b")           // true
	 * map1.containsKey(tf2)           // false
	 * map1.containsValue(2)           // true
	 * 
	 * map1.put("c", 3)                // null
	 * map1                            // {b=2,a=1,c=3}
	 * map1.size()                     // 3
	 * 
	 * map1.put("tf1", tf1)            // null
	 * map1                            // {b=2,a=1,c=3,tf1=[object TextField]}
	 * map1.size()                     // 4
	 * map1.containsValue(tf1)         // true
	 * 
	 * map1.put(tf2, "tf2")            // null
	 * map1                            // {b=2,[object TextField]=tf2,a=1,c=3,tf1=[object TextField]}
	 * map1.size()                     // 5
	 * map1.containsKey(tf2)           // true
	 * 
	 * map1.put("a", 1.1)              // 1
	 * map1                            // {b=2,[object TextField]=tf2,a=1.1,c=3,tf1=[object TextField]}
	 * map1.size()                     // 5
	 * 
	 * map1.put("tf1", String)         // [object TextField]
	 * map1                            // {b=2,[object TextField]=tf2,a=1.1,c=3,tf1=[class String]}
	 * map1.size()                     // 5
	 * 
	 * map1.put(tf2, "tf2.1")          // tf2
	 * map1                            // {b=2,[object TextField]=tf2.1,a=1.1,c=3,tf1=[class String]}
	 * map1.size()                     // 5
	 * 
	 * map1.put(Number, 999)           // null
	 * map1                            // {b=2,[object TextField]=tf2.1,[class Number]=999,a=1.1,c=3,tf1=[class String]}
	 * map1.size(): 6
	 * 
	 * map1.getValue("b")              // 2
	 * 
	 * map1.getValue(tf2)              // tf2.1
	 * 
	 * map1.putAllByObject({fa:"fb",ga:"gb",ha:"hb"});
	 * 
	 * map1                            // {b=2,[object TextField]=tf2.1,fa=fb,[class Number]=999,c=3,ha=hb,a=1.1,tf1=[class String],ga=gb}
	 * 
	 * map1.size()                     // 9
	 * 
	 * map1.getValue("fa")             // fb
	 * 
	 * map1.remove("ga")               // gb
	 * map1                            // {b=2,[object TextField]=tf2.1,fa=fb,[class Number]=999,c=3,ha=hb,a=1.1,tf1=[class String]}
	 * map1.size()                     // 8
	 * 
	 * map1.remove("fa")               // fb
	 * map1                            // {b=2,[object TextField]=tf2.1,[class Number]=999,c=3,ha=hb,a=1.1,tf1=[class String]}
	 * map1.size()                     // 7
	 * 
	 * map1.remove(tf2)                // tf2.1
	 * map1                            // {b=2,[class Number]=999,c=3,ha=hb,a=1.1,tf1=[class String]}
	 * map1.size()                     // 6
	 * 
	 * map1.getValue("fa")             // null
	 * map1.getValue(tf2)              // null
	 * 
	 * var map2:IMap = map1.clone();
	 * 
	 * map2                            // {b=2,a=1.1,[class Number]=999,c=3,tf1=[class String],ha=hb}
	 * map2.size()                     // 6
	 * map2.isEmpty()                  // false
	 * 
	 * map1.equals(map2)               // true
	 * map2.equals(map1)               // true
	 * map2.equals(map2)               // true
	 * 
	 * map2.remove("b")                // 2
	 * map2                            // {a=1.1,[class Number]=999,c=3,tf1=[class String],ha=hb}
	 * map2.equals(map2)               // true
	 * map2.size()                     // 5
	 * 
	 * map1.equals(map2)               // false
	 * map2.equals(map1)               // false
	 * 
	 * map2.getValues()                // [1.1,999,3,[class String],hb]
	 * 
	 * var keysMap2:IList = map2.getKeys();
	 * 
	 * keysMap2                        // [a,[class Number],c,tf1,ha]
	 * 
	 * keysMap2.remove("c")            // true
	 * keysMap2                        // [a,[class Number],tf1,ha]
	 * map2                            // {a=1.1,[class Number]=999,c=3,tf1=[class String],ha=hb}
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
	 * map1                            // {b=2,[class Number]=999,c=3,ha=hb,a=1.1,tf1=[class String]}
	 * map1.retainAll(map2)            // true
	 * map1                            // {c=3}
	 * map1.size()                     // 1
	 * map1.isEmpty()                  // false
	 * 
	 * map1.put("d", 4)                // null
	 * map1.put("e", 5)                // null
	 * map1.put("f", 6)                // null
	 * 
	 * map1                            // {c=3,d=4,f=6,e=5}
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
	 *     trace(it.pointer() + "=" + e)    // f=6
	 * 
	 *     e = it.next();
	 *     trace(it.pointer() + "=" + e)    // e=5
	 * }
	 * 
	 * map1                            // {c=3,f=6,e=5}
	 * map1.size()                     // 3
	 * </listing>
	 * 
	 * @see org.as3collections.utils.MapUtil#getTypedMap() MapUtil.getTypedMap()
	 * @author Flávio Silva
	 */
	public class HashMap extends AbstractHashMap
	{
		/**
		 * Constructor, creates a new <code>HashMap</code> object.
		 * 
		 * @param 	source 		a map with wich fill this map.
		 * @param 	weakKeys 	instructs the backed <code>Dictionary</code> object to use "weak" references on object keys. If the only reference to an object is in the specified <code>Dictionary</code> object, the key is eligible for garbage collection and is removed from the table when the object is collected.
		 */
		public function HashMap(source:IMap = null, weakKeys:Boolean = false)
		{
			super(source, weakKeys);
		}

		/**
		 * Removes all of the mappings from this map.
		 * The map will be empty after this call returns.
		 */
		override public function clear(): void
		{
			_init();
		}

		/**
		 * Creates and return a new <code>HashMap</code> object containing all mappings in this map.
		 * 
		 * @return 	a new <code>HashMap</code> object containing all mappings in this map.
 		 */
		override public function clone(): *
		{
			return new HashMap(this);
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
		 * Associates the specified value with the specified key in this map.
		 * If the map previously contained a mapping for the key, the old value is replaced by the specified value. (A map <code>m</code> is said to contain a mapping for a key <code>k</code> if and only if <code>m.containsKey(k)</code> would return <code>true</code>.) 
		 * 
		 * @param  	key 	key with which the specified value is to be associated.
		 * @param  	value 	value to be associated with the specified key.
		 * @return 	the previous value associated with key, or <code>null</code> if there was no mapping for key. (A <code>null</code> return can also indicate that the map previously associated <code>null</code> with key, because this implementation supports <code>null</code> values.)
		 */
		override public function put(key:*, value:*): *
		{
			var old:* = null;
			
			containsKey(key) ? old = map[key] : _size++;
			
			map[key] 		= value;
			values[value] 	= true;
			
			checkKeyEquatable(key);
			checkValueEquatable(value);
			
			return old;
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
			
			var old:*;
			
			if (allKeysEquatable)
			{
				var it:IIterator = iterator();
				var e:*;
				
				while (it.hasNext())
				{
					e = it.next();
					
					if ((key as IEquatable).equals(it.pointer()))
					{
						old = e;
						
						delete map[it.pointer()];
						delete values[old];
						
						break;
					}
					
					/*
					if (containsKey(it.pointer()))
					{
						it.remove();
						old = e;
						
						break;
					}*/
				}
			}
			else
			{
				old = map[key];
				
				delete map[key];
				delete values[old];
			}
			
			checkAllKeysEquatable();
			checkAllValuesEquatable();
			
			_size--;
			
			return old;
		}
	}

}