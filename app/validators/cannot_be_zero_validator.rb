class CannotBeZeroValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value == 0
      record.errors[attribute] << 'cannot be 0'
    end
  end
end
