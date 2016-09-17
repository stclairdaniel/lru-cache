class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0
      if (@count + i).between?(0, @store.length - 1)
        return @store[@count + i]
      else
        return nil
      end
    end
    @store[i]
  end

  def []=(i, val)
    if i < 0 && (@count + i).between?(0, @store.length - 1)
      @store[@count + i] = val
      return
    end
    resize! while capacity <= i

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    self[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    temp = StaticArray.new(capacity)
    (0...@store.length).each do |idx|
      next if self[idx].nil?
      temp[idx + 1] = self[idx]
    end
    temp[0] = val
    @count += 1
    @store = temp
  end

  def pop
    val = nil
    (0...@store.length).each do |i|
      if self[i] == last
        val = last
        self[i] = nil
        @count -= 1
        return val
      end
    end
  end

  def shift
    val = self[0]
    temp = StaticArray.new(capacity)
    (1...@store.length).each do |idx|
      temp[idx - 1] = self[idx]
    end
    @count -= 1
    @store = temp
    val
  end

  def first
    self[0]
  end

  def last
    prev = nil
    each do |el|
      return prev if el.nil?
      prev = el
    end
    prev
  end

  def each
    (0...@store.length).each do |idx|
      yield(self[idx])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    self_dup = []
    each do |el|
      self_dup << el unless el.nil?
    end
    other_dup = []
    other.each do |el|
      other_dup << el unless el.nil?
    end

    self_dup == other_dup
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    temp = StaticArray.new(capacity * 2)
    (0...@store.length).each do |idx|
      temp[idx] = self[idx]
    end
    @store = temp
  end
end
