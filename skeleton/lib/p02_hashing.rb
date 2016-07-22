class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_string = ''
    hash_concat = ''
    count = 1
    self.each do |el|
      if el.is_a?(Numeric)
        hash_concat.concat(el.hash.to_s)
        count += 1
      elsif el.is_a?(Array)
        hash_concat.concat(el.hash)
        count += 1
      else
        el.is_a?(Symbol) ? el.to_s : el
        hash_concat.concat(el.hash.to_s)
        count += 1
      end
    end
    hash_arr = hash_concat.chars
    hash_arr.select.with_index { |char, idx| idx % count == 0 }.join.to_i
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.sort.concat(self.values.sort).hash
  end
end
