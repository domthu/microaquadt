class Name < ActiveRecord::Base

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.tax_id.to_s + ' ' + self.name_txt
  end

end

