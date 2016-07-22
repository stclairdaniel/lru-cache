class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].any? {|n| n == num }
  end

  # private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! unless @count < num_buckets
    self[num] << num unless self.include?(num)
    @count += 1
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
  end

  def include?(num)
    self[num].any? {|n| n == num }
  end

  protected
  attr_reader :store

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(num_buckets * 2)
    (0...num_buckets).each do |bucket_idx|
      self[bucket_idx].each do |el|
        new_set.insert(el)
      end
    end
    @store = new_set.store
  end

end
