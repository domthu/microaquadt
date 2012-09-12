class FileReader

 def extract_header_info(filename)
    str = IO.read(filename)
    line = str.to_str
    
    if line =~  /(^ATF.*Supplier.+?\n)/m
      return "#{$1}"
   end 
 end


 def extract_block_info(filename)
    str = IO.read(filename)
    line = str.to_str
    
    if line =~ /(^Block\d.+)?Block\s/m
       return "#{$1}"
    end
 end	


 def extract_data_info(filename)
    f = File.open(filename)
 
      f.each do |line|
  
      if line =~ /(^\d\s\d\s\d\s)(\w+\s)(.+?\n)/m
         puts "#{$2}#{$3}"
      end
     end
   f.close
 end

def extract_data_info1(filename)
    f = File.open(filename)
    f.each do |line|
      puts line
    end  
 end


reader = FileReader.new()

#puts "#{reader.extract_block_info("MIDTAL_V3.3.gal")}"

#puts "#{reader.extract_header_info("MIDTAL_V3.3.gal")}"
reader.extract_data_info("MIDTAL_V3.3.gal")

#reader.extract_data_info1("MIDTAL_V3.3.gal")
 
 
end   
