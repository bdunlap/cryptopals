def find_single_byte_key(ciphertext)
    cipherlength = [ciphertext].pack('H*').bytes.length
    scored = []
    (0..255).each do |x|
        key = sprintf('%02x', x) * cipherlength
        plaintext = [fixed_xor('1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736', key)].pack('H*')
        score = score_plaintext(plaintext)
        next if score == 0

        scored << { 'score' => score, 'plaintext' => plaintext, 'key_value' => x, 'key_char' => x.chr }
    end

    scored.sort! { |a, b| b['score'] <=> a['score']}

    scored[0..2].each do |candidate|
        p candidate
    end
end
