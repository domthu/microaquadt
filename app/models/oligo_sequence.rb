class OligoSequence < ActiveRecord::Base

include ActionController::UrlWriter
include OligoSequencesHelper
#include CodeTypesHelper
#include SessionsHelper

  validates_presence_of :name, :message => "Can't be empty, field is mandatory. "
  validates_length_of :name, :maximum=>100
  validates_length_of :code, :maximum=>30
  validates_uniqueness_of :code, :case_sensitive => false
  validates_presence_of :dna_sequence, :message => "Can't be empty, field is mandatory. "
  #validates_uniqueness_of :dna_sequence, :case_sensitive => false
  validates_length_of :dna_sequence, :maximum=>100

  #C A T and G
  #validates_format_of :dna_sequence, :with => /^([^\d\W]|[-])*$/
  #IUPAC code table  for nucleotid
  validates_format_of :dna_sequence, :with => /^[ACGTURYMKWSBDHVNacgturymkwsbdhvn]+$/, :message => "DNA is invalid, only IUPAC alfabet is possible -%{value}-" # "#{self.name}"
#validation dna seq --> IUPAC code table Nucleotid:  
#A (Adenine) 
#C (Cytosine)    
#G (Guanine) 
#T (Thymine) 
#U (Uracil)  
#R (Purine A or G)   
#Y (Pyrimidine C, T, or U)   
#M (C or A)  
#K (T, U, or G)  
#W (T, U, or A)  
#S (C or G)  
#B (C, T, U, or G not A) 
#D (A, T, U, or G not C)    
#H (A, T, U, or C not G)    
#V (A, C, or G not T, not U) 
#N (Any base A, C, G, T, or U)   


  validates_numericality_of :taxonomy_id, :allow_nil => true #, :less_than => 100

  belongs_to :microarraygals

  has_many :oligos, :dependent => :destroy

  belongs_to :sampling

  belongs_to :partner
  #validates_presence_of :partner
  belongs_to :person
  #has_many :partner_people
  belongs_to :partner_person

  #In order for form_for to work,
  attr_reader :verbose_me
  def verbose_me
    if self.name.length < 30
        return self.name 
    else
        return self.name[0..30] + '...'
    end
  end

  attr_reader :dna_ellipsis
  def dna_ellipsis
      if self.dna_sequence.length < 30
        return self.dna_sequence.upcase
      else
        return self.dna_sequence[0..30].upcase + '...'
      end
  end

  attr_reader :taxo_name_id
  def taxo_name_id
      if !self.taxonomy_name.nil? and !self.taxonomy_id.nil? 
          if self.taxonomy_name.length < 20
            return self.taxonomy_name + ' --> ' + self.taxonomy_id.to_s
          else
            return self.taxonomy_name[0..20] + '... --> ' + self.taxonomy_id.to_s
          end
      else
        return ""
      end
  end

    def partner_name
        Partner.find(partner_id).verbose_me
    end

    def people_name
        Person.find(people_id).verbose_me
    end

    def edit

        #if auth_user(self.partner_id) or signed_in_and_master?
        #if auth_oligo_user(self.id) or signed_in_and_master?
        #FIXME: undefined local variable or method `current_user' for #<OligoSequence:0xb6c0e444>
            "<a href='" + edit_oligo_sequence_path(self) + "' title='Edit selected row'><div class='ui-pg-div' title='Edit selected row'><span class='ui-icon ui-icon-pencil' title='Edit selected row'></span></div></a>"
#        else
#            ""
#        end
    end

    def tax_id_link
        if !self.taxonomy_name.nil? and !self.taxonomy_id.nil? 
            "<a href='http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?mode=Info&id=" + self.taxonomy_id.to_s + "&lvl=3&lin=f&keep=1&srchmode=1&unlock' title='Show selected row' title='Show taxonomy definition into the NCBI web site'  target='_blank'>" + self.taxonomy_name + "</a>"
        else
            ""
        end
    end

    def act
        "<a href='" + oligo_sequence_path(self) + "' title='Show selected row'><div class='ui-pg-div' title='Show selected row'><span class='ui-icon ui-icon-info' title='Show selected row'></span></div></a>"
    end
  


end

