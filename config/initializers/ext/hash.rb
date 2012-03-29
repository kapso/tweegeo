# via http://grosser.it/2009/04/14/recursive-symbolize_keys/
class Hash
  
  def recursively_symbolize_keys!
    symbolize_keys!

    # symbolize each hash in .values
    values.each { |h| h.recursively_symbolize_keys! if h.is_a?(Hash) }

    # symbolize each hash inside an array in .values
    values.select { |v| v.is_a?(Array) }
          .flatten.each { |h| h.recursively_symbolize_keys! if h.is_a?(Hash) }

    self
  end

end