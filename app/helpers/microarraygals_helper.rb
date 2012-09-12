module MicroarraygalsHelper

  def auth_ma_user(maid)
    @mag = Microarraygal.find(maid)
    return auth_user(@mag.partner_id)
  end

  def extract_row_count
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(Block\d.\s\d+,\s\d+,\s\d+,\s)(\d+)(,\s\d+,\s)(\d+)(,\s\d+)/m 
            return "#{$4}"          
            end
  end

  def extract_column_count
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(Block\d.\s\d+,\s\d+,\s\d+,\s)(\d+)(,\s\d+,\s)(\d+)(,\s\d+)/m 
            return "#{$2}"          
            end
  end


  def extract_block_count
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(BlockCount=)(\d)/m 
            return "#{$2}"          
            end
  end



  def extract_version_info
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(^ATF\s)(\d)/m 
            return "#{$2}"          
            end
  end

  def extract_header_info
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(^ATF.*Supplier.+?\n)/m 
            return "#{$1}"  

                   
            end
  end


  def extract_block_info
      name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       
       str = IO.read(path1)
       line = str.to_str
      #f = File.open(path)
      #f.each do |line|
          if line =~ /(^Block\d.+)?Block\s/m
          return $1
         end
  end



#IO.foreach("testfile") {|x| print "GOT ", x }
  #produces:
  #GOT This is line one
  #GOT This is line two
  #GOT This is line three
  #GOT And so on...

#File.open(local_filename, 'w') {|f| f.write(doc) }

  def extract_id_info
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
 
       f = File.open(path1)
       f.each do |line| 
          if line =~ (/(\d\s\d+\s\d+\s)(\w+\s)(\w+[+\-\s\w]+\s)/)     
          return $2
         end  
     end
  end


  def extract_name_info
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
          if line =~ /(\d\s\d+\s\d+\s)(\w+\s)(\w+[+\-\s\w]+\s)/m     
          return $3
         end  
  end

  def extract_gal_info
       name = Microarraygal.find(params[:id]).gal_title
       directory = "public/microarrays/"  
       path1 = File.join(directory, name)
       str = IO.read(path1)
       line = str.to_str
    
       #f = File.open(path)
       
       #f.each do |line|
            if line =~  /(^ATF.*\s+.+$\n)/m 
            return "#{$1}"  
           end
  end

end
