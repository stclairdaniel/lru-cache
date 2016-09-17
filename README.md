# LRU Cache

This project incrementally implements an LRU cache in Ruby in 7 phases.

## Phase 1

This phase begins with a MaxIntSet. This is an array of length equal to the maximum element. It stores values of true/false, and lookup is as simple as indexing into the element. Its major flaws are that it wastes space - if my set is [1, 1000] it has length 1000. It can also not store anything except integers.

IntSet improves upon this by storing elements in one of 20 buckets using modulo arithmetic. Now, length is fixed at 20 but lookup time can be quite long if any particular bucket contains many elements.

ResizingIntSet improved upon this again by doubling the number of buckets when the element count is equal to the current number. This way, inserting is done in constant time and each bucket is likely to contain only one element. This can still be further improved as it's possible for certain data sets to bunch, possibly increasing indexing time to O(N).

## Phase 2

This phase implements a custom hashing method (note - extremely not secure, only for practice) to allow any data type (arrays, strings, fixnums) to be stored in a resizing set.

## Phase 3

Phase 3 used the ResizingIntSet logic in conjunction with the custom hash function to create a HashSet.

## Phase 4

Phase 4 implements a Linked List, which has constant removal/insertion time.

## Phase 5

Phase 5 uses the Linked List implementation in place of arrays for the buckets in the HashSet to create a HashMap with constant removal/insertion/lookup time.

## Phase 6

Finally, the HashMap is used to implement an LRU cache. The hash map points to a link in the linked list, so its constant lookup time is used to find the link, which contains the key and value. When a new link it inserted, its value is computed by calling the passed in proc. When a link is queried, it moved to the front position of the list, and the oldest item is ejected from the list if the cache size is at its maximum.  

## Phase 7

This phase implements dynamic arrays from a basic static array. Common array methods, such as push, pop, shift, unshift, and each were all implemented from scratch.
