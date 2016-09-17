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

  def get(key)
    if @map.include?(key)
      update_link!(key)
    else
      eject! if count == @max
      calc!(key)
    end
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # insert an (un-cached) key
    val = @prc.call(key)
    @store.insert(key, val)
    @map[key] = @store.last
  end

  def update_link!(key)
    link = @map.get(key)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    lru_key = @store.head.next.key
    @store.remove(lru_key)
    @map.delete(lru_key)
  end

end
