class Hex
  def initialize(input)
    raise "Hex.new() needs a hexadecimal string" unless input.downcase =~ /\A[0-9a-f]*\z/
    @string = input
  end

  def to_s
    @string
  end

  def binstr
    @binstr ||= [@string].pack('H*')
  end

  def bytes
    @bytes ||= binstr.chars.map { |binchar| binchar.ord }
  end
  
  def to_i
    @string.to_i(16)
  end

  def to_b64
    [binstr].pack('m0')
  end

  def fixed_xor(xorand)
    raise "fixed XOR requires equal-length operands" unless @string.length == xorand.to_s.length
    Hex.new(
      bytes.map.with_index { |byte, i| byte ^ xorand.bytes[i] }
      .reduce("") { |s, byte| s + sprintf("%02x", byte) }
    )
  end

  def repeating_key_xor(key)
    Hex.new(
      bytes.map.with_index { |byte, i| byte ^ key.bytes[i % key.bytes.length] }
      .reduce("") { |s, byte| s + sprintf("%02x", byte) }
    )
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
    Hex.new(chars.reduce("") { |s, char| s + sprintf("%02x", char.ord) })
  end
end

    
