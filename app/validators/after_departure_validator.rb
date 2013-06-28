class AfterDepartureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.arrival && record.departure && record.arrival < record.departure
      record.errors[attribute] << (options[:message] || I18n.t('validators.arrival_after_departure'))
    end
  end
end
