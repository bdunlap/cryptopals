class Set1Test < Test::Unit::TestCase
#  setup { }

  def test_s1c1
    assert_equal(
      'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t',
      Hex.new('49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d').to_b64
    )
  end

  def test_s1c2
    a = Hex.new('1c0111001f010100061a024b53535009181c')
    b = Hex.new('686974207468652062756c6c277320657965')

    assert_equal(
      '746865206b696420646f6e277420706c6179',
      a.fixed_xor(b).to_s
    )
  end

  def test_s1c3
    ciphertext = Hex.new('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736')

    assert_equal(
      "Cooking MC's like a pound of bacon",
      ciphertext.decrypt_single_char_xor
    )
  end

  def test_s1c4
    assert_equal(
      "Now that the party is jumping\n",
      IO.foreach('data/set-1-c-4.txt')
      .map do |line|
        plaintext = Hex.new(line.strip).decrypt_single_char_xor
        { 'plaintext' => plaintext, 'score' => plaintext.english_score }
      end
      .sort { |a,b| b['score'] <=> a['score'] }
      .first['plaintext']
    )
  end

  def test_s1c5
    plaintext = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal".to_hex

    assert_equal(
      '0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f',
      plaintext.repeating_key_xor("ICE").to_s
    )
  end

  def test_hamming
    assert_equal(
      37,
      'this is a test'.to_hex.hamming_distance('wokka wokka!!!'.to_hex)
    )
  end

end

