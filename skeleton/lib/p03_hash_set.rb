require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! unless @count < num_buckets
    unless self.include?(key)
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].any? { |el| el == key }
  end

  def remove(key)
    @count -= 1 if self[key.hash].delete(key)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    elements.each { |el| self.insert(el) }
  end

end
