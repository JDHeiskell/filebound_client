# Extends Hash with additional helper methods
class Hash
  # Allows for conversion of string keys to symbols
  # @return [Hash] hash with symbols for keys
  def symbolize_keys
    each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v }
  end
end
