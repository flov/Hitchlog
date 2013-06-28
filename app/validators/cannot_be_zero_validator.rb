class CannotBeZeroValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value == 0
      record.errors[attribute] << I18n.t('validators.cannot_be_0')
    end
  end
end
