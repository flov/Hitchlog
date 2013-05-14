class AfterDepartureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.arrival && record.departure && record.arrival < record.departure
      record.errors[attribute] << (options[:message] || "must be after departure")
    end
  end
end
