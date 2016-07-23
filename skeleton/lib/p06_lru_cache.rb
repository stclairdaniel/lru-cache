require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key, &prc)
    unless @store.include?(key)
      calc!(key, &prc)
    else
      update_link!(@store[key])
    end
    eject! unless count < @max
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key, &prc)
    # suggested helper method; insert an (un-cached) key
    unless @store.include?(key)
      # block_given?  ? yielded = prc.call(key) : @store.get(key)
      @store.insert(key, yield(key))
      @map[key] = yield(key)
    end
  end

  def update_link!(key)
    @store.remove(key)
    @store.insert(key, @store.get(key))
  end

  def eject!
    lru_key = @store.head.next.key
    @store.remove(lru_key)
    @map.delete(lru_key)
  end
end
