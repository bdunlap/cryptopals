load 'lib/cctools.rb'
load 'test/challenges.rb'

#puts hex_to_base64('49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d')
#
#puts fixed_xor('1c0111001f010100061a024b53535009181c','686974207468652062756c6c277320657965')
#
#puts ['1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736'].pack('H*')
#
p find_single_byte_key('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736')
#
#p IO.foreach('data/set-1-c-4.txt')
#.map { |line| find_single_byte_key(line.strip) }
#.sort! { |a,b| b['score'] <=> a['score'] }
#.first
#
#puts rk_xor("Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal", "ICE")
#.split("\n") 
#.each { |line| puts rk_xor(line, "ICE") }
