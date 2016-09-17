require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! unless @count < num_buckets
    unless self.include?(key)
      bucket(key).insert(key, val)
      @count += 1
    else
      bucket(key).each do |link|
        link.val = val if link.key == key
      end
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key).remove(key)
  end

  def each
    @store.each do |list|
      list.each { |link| yield(link) }
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    lists = @store.dup
    new_array = Array.new(num_buckets * 2) { LinkedList.new }
    lists.each do |list|
      list.each do |link|
        new_array[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_array
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
