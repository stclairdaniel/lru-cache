require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    check_link = @head.next
    check_key = check_link.key
    until check_key == key
      break if check_link == @tail
      check_link = check_link.next
      check_key = check_link.key
    end
    check_link.val
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def insert(key, val)
    unless self.include?(key)
      new_link = Link.new(key, val)
      @tail.prev.next = new_link
      new_link.prev = @tail.prev
      new_link.next = @tail
      @tail.prev= new_link
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        return true
      end
    end
    false
  end

  def each
    current_link = @head
    until current_link == @tail.prev
      current_link = current_link.next
      yield(current_link)
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
