class Asset < ActiveRecord::Base

   belongs_to :batch_oligo

   has_attached_file :fiolse,
                     :url => "/:attachment/:basename.:extension",
                     :path => ":rails_root/public/:attachment/:basename.:extension"
	

end
