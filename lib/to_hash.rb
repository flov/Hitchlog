module ToHash
  def self.eval_object(object, attributes)
    if object.kind_of?(Array)
      object.map { |o| eval_attributes(o, attributes) }
    else
      eval_attributes(object, attributes)
    end
  end

  def self.eval_attributes(object, attributes)
    result = {}
    attributes = attributes.first if attributes.first.kind_of?(Hash)
    case attributes
    when Array
      attributes.each do |attribute|
        if attribute.kind_of?(Array)
          result[attribute.first] = eval_object(object.send(attribute.first), attribute[1..-1])
        else
          result[attribute] = object.send(attribute)
        end
      end
    when Hash
      attributes.each do |key, attribute|
        if attribute.kind_of?(Array)
          result[key] = eval_object(object.send(attribute.first), attribute[1..-1])
        else
          result[key] = object.send(attribute)
        end
      end
    end
    result
  end

  def to_hash(*attributes)
    ToHash.eval_attributes(self, attributes)
  end
end