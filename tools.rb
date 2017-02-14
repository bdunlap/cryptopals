require 'base64'

def hex_to_base64(hex_string)
    bytes = hex_to_bin(hex_string)
    Base64.strict_encode64(bytes)
end

def hex_to_bin(hex_string)
    bytes = []
    hex_string.scan(/../) do |encoded_byte|
        bytes << encoded_byte.to_i(16).chr
    end
    bytes.join('')
end
