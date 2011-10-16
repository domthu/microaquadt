
#Mode 	Description
#r 	Read-only, starts at beginning of file (default mode).
#r+ 	Read-write, starts at beginning of file.
#w 	Write-only, truncates existing file to zero length or creates a new file for writing.
#w+ 	Read-write, truncates existing file to zero length or creates a new file for reading and writing.
#a 	Write-only, starts at end of file if file exists, otherwise creates a new file for writing.
#a+ 	Read-write, starts at end of file if file exists, otherwise creates a new file for reading and writing.

#    ##### MAIN #####
#    xml_data = get_file_as_string 'Pizza.hbm.xml'
#    # print out the string
#    puts xml_data
    def get_file_as_string(filename)
      data = ''
      f = File.open(filename, "r") 
      f.each_line do |line|
        data += line
      end
      return data
    end



    #!/usr/bin/ruby -w
    # Example 1 - Read File and close
    def read_file_and_close(filename)
        counter = 1
        file = File.new(filename, "r")  #"readfile.rb"
        while (line = file.gets)
          puts "#{counter}: #{line}"
          counter = counter + 1
        end
        file.close
    end
      
    # Example 2 - Pass file to block
    def pass_file_to_block(filename)
        File.open(filename, "r") do |infile|
          while (line = infile.gets)
              puts "#{counter}: #{line}"
              counter = counter + 1
          end
        end
    end

    # Example 3 - Read File with Exception Handling
    def read_file_with_exception_handling(filename)
        counter = 1
        begin
          file = File.new(filename, "r")
          while (line = file.gets)
              puts "#{counter}: #{line}"
              counter = counter + 1
          end
          file.close
        rescue => err
          puts "Exception: #{err}"
          err
        end
    end

