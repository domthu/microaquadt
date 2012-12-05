module MicroarraygprsHelper

  def auth_ma_user(maid)
	    @mag = Microarraygpr.find(maid)
	    return auth_user(@mag.partner_id)
  end  


  def extract_gpr_info
       name = Microarraygpr.find(params[:id]).gpr_title
       directory = "public/Microarraygprs/"  
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
