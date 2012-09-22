class FileReader

 def extract_header_info(filename)
    str = IO.read(filename)
    line = str.to_str
    
    if line =~  /(^ATF.*Supplier.+?\n)/m
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

 def test_blocks 
      str = IO.read(path)
       line = str.to_str
       
       if line =~ /Block(\d).\s(\d+),\s(\d+),\s(\d+),\s(\d+)(,\s\d+,\s)(\d+)(,\s\d+)/m 
          @gal_header.gal_row_count = $4.to_s
       end
       if line =~ /(Block\d.\s\d+,\s\d+,\s\d+,\s)(\d+)(,\s\d+,\s)(\d+)(,\s\d+)/m 
          @gal_header.gal_column_count = $2.to_s
       end 
 end

 def extract_block_info(filename)    
    str = IO.read(filename)
    line = str.to_str
    if line =~ /(^Block\d.+)?Block\s/m
     puts $1
     $1.each do |line|
        if line =~ /Block(\d).\s(\d+),\s(\d+),\s(\d+),\s(\d+),\s(\d+),\s(\d+),\s(\d+)/

		@data[:block_number] = $1 
		  puts @data[:block_number]
		 
                @data[:block_number][:xOrigin] = $2
                  puts @data[:block_number][:xOrigin]                    
		  
                @data[:block_number][:yOrigin] = $3 
		  puts @data[:block_number][:yOrigin]

                @data[:block_number][:feature_diameter] = $4 
		  puts @data[:block_number][:feature_diameter]   

                @data[:block_number][:xFeatures] = $5 
		  puts @data[:block_number][:xFeatures]     

                @data[:block_number][:xSpacing] = $6
		  puts @data[:block_number][:xSpacing]	 

                @data[:block_number][:yFeatures] = $7
		  puts @data[:block_number][:yFeatures]	   

                @data[:block_number][:ySpacing] = $8
                 puts @data[:block_number][:ySpacing]
          end
     end
   end 
 end




end  

reader = FileReader.new()

#puts "#{reader.extract_block_info("MIDTAL_V3.3.gal")}"

#puts "#{reader.extract_header_info("MIDTAL_V3.3.gal")}"
reader.extract_block_info("MIDTAL_V3.3.gal")

#reader.extract_data_info1("MIDTAL_V3.3.gal")


 
