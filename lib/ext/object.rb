# Extends Object with additional helper methods
class Object
  # Adds blank? method to any object
  # Lifted from: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/object/blank.rb
  # @return [true, false]
  def blank?
    # rubocop:disable Style/DoubleNegation
    respond_to?(:empty?) ? !!empty? : !self
    # rubocop:enable Style/DoubleNegation
  end

  # Checks where object is greater than zero
  # Returns false of object is nil
  # @return [true, false]
  def greater_than_zero?
    return false if nil?
    to_i.positive?
  end
end
