class NotInPastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.blank? and value < Date.today
      record.errors[attribute] << I18n.t('validators.cannot_be_in_past')
    end
  end
end

