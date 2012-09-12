class MicroArrayAnalysisFile < ActiveRecord::Base
  belongs_to :experiment

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.MIANE_Standard
  end
end

