class NucleicAcid < ActiveRecord::Base

    validates_presence_of :code => "Can't be empty, field is mandatory. "
    validates_length_of :code,
        :maximum => 30,
        :too_long => "{{count}} characters is the maximum allowed"


    belongs_to :filter_sample
    belongs_to :nucleic_acid_type
    belongs_to :partner

    has_many :samplings, :through => :filter_samples

    # This is what I would like to do, but this does not work!
    # has_many :partners, :through => :samplings

    def refpartners
    # Use a 3 table sql join to load the partners for all users in this group.
    Partner.find_by_sql("
             SELECT c.* FROM partners p
               INNER JOIN samplings u ON s.partner_id = p.id
                 INNER JOIN filter_samples fs ON fs.sampling_id = s.id
             WHERE fs.id = #{filter_sample_id}")
    end

  attr_reader :verbose_me
  def verbose_me
    return self.code  + ' ' + self.nucleic_acid_type.verbose_me
  end

    attr_reader :sampling_name
    def sampling_name
        self.filter_sample.sampling.verbose_me
    end

    attr_reader :filter_sample_name
    def filter_sample_name
        self.filter_sample.verbose_me
    end

    attr_reader :partner_name
    def partner_name
        self.partner.verbose_me
    end

    attr_reader :nucleic_acid_type_name
    def nucleic_acid_type_name
        self.nucleic_acid_type.verbose_me
    end

include ActionController::UrlWriter
    def edit
        "<a href='" + edit_nucleic_acid_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
    end

    def act
        "<a href='" + nucleic_acid_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end

end
