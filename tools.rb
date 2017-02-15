require 'base64'

def hex_to_base64(hex_string)
    Base64.strict_encode64([hex_string].pack('H*'))
end

def fixed_xor(a_hex, b_hex)
    if (a_hex.length != b_hex.length)
        raise 'need equal-length inputs'
    end

    (a_hex.to_i(16) ^ b_hex.to_i(16)).to_s(16)
end


def score_plaintext(candidate)
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

    score = 0
    candidate.split(//).each do |char|
        if scores.has_key?(char.downcase)
            score += scores[char.downcase]
		end
    end
    return score
end

    
