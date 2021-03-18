class Hex
  def initialize(input)
    raise "Hex.new() needs a hexadecimal string" unless input.downcase =~ /\A[0-9a-f]*\z/
    @string = input
  end

  def to_s
    @string
  end

  def to_b64
    [binstr].pack('m0')
  end

  def binstr
    @binstr ||= [@string].pack('H*')
  end

  def bytes
    @bytes ||= binstr.bytes
  end

  def bits
    @bits ||= binstr.unpack('B*')[0].chars
  end
  
  def fixed_xor(xorand)
    raise "fixed XOR requires equal-length operands" unless @string.length == xorand.to_s.length
    xor(xorand).to_hex
  end

  def repeating_key_xor(key)
    xor(key).to_hex
  end

  def decrypt_single_char_xor
    (0..255).map do |x|
      key = Hex.new(sprintf('%02x', x) * binstr.length)
      plaintext = fixed_xor(key).binstr
      {
        'score' => plaintext.english_score,
        'plaintext' => plaintext,
      }
    end
    .sort { |a, b| b['score'] <=> a['score'] }
    .first['plaintext']
  end
  
  def hamming_distance(other)
    raise "hamming distance requires equal-length operands" unless bits.length == other.bits.length
    bits.map.with_index { |bit, i| bit == other.bits[i] ? 0 : 1 }
    .reduce(:+)
  end

  private

  def xor(xorand)
    bytes.map.with_index { |byte, i| byte ^ xorand.bytes[i % xorand.bytes.length] }
  end

end

class String
  def english_score
    scores = {
        'e' => 13,
        't' => 12,
        'a' => 11,
        'o' => 10,
        'i' => 9,
        'n' => 8,
        ' ' => 7,
        's' => 6,
        'h' => 5,
        'r' => 4,
        'd' => 3,
        'l' => 2,
        'u' => 1
    }

    chars.reduce(0) { |sum, char| sum + (scores[char.downcase] || 0) }
  end

  def to_hex
    chars.map { |c| c.ord }
    .to_hex
  end
end

class Array
  def to_hex
    Hex.new(reduce("") { |str, e| str + sprintf("%02x", e) })
  end
end

    
