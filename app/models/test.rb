class Test < ActiveRecord::Base

belongs_to :microarraygal



  def extract_company
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
            if line =~  /(Supplier=)(\w+.*)/m 
            return "#{$2}"          
            end
  end





end
