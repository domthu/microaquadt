class MicroArray < ActiveRecord::Base
  validates_presence_of :gpr_title, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :gpr_file_title, :message => "Can't be empty, field is mandatory. "
  validates_presence_of :gpr_file, :message => "Can't be empty, field is mandatory. "

  belongs_to :partner
  has_many :micro_array_validations, :dependent => :destroy, :class_name => 'MicroArrayValidation'
  has_many :micro_array_images, :dependent => :destroy, :class_name => 'MicroArrayImage'
  has_many :micro_array_datas, :dependent => :destroy, :class_name => 'MicroArrayData'
  has_many :micro_array_analysis_files, :dependent => :destroy, :class_name => 'MicroArrayAnalysisFile'


  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    return self.gpr_file_title
  end

  attr_reader :path
  def path
    return File.join(self.gpr_file_title, self.gpr_title) 
  end

end

