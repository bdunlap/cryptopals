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
