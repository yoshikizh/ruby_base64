#encoding:utf-8

require "ruby_base64/version"

module RubyBase64
  
  module_function
  
  # 码表
  
 CharBase64 = {
  0 => "A", 17 => "R", 34 => "i", 51 => "z", 
  1 => "B", 18 => "S", 35 => "j", 52 => "0", 
  2 => "C", 19 => "T", 36 => "k", 53 => "1", 
  3 => "D", 20 => "U", 37 => "l", 54 => "2", 
  4 => "E", 21 => "V", 38 => "m", 55 => "3", 
  5 => "F", 22 => "W", 39 => "n", 56 => "4", 
  6 => "G", 23 => "X", 40 => "o", 57 => "5", 
  7 => "H", 24 => "Y", 41 => "p", 58 => "6", 
  8 => "I", 25 => "Z", 42 => "q", 59 => "7", 
  9 => "J", 26 => "a", 43 => "r", 60 => "8", 
  10 => "K", 27 => "b", 44 => "s", 61 => "9", 
  11 => "L", 28 => "c", 45 => "t", 62 => "+", 
  12 => "M", 29 => "d", 46 => "u", 63 => "/",
  13 => "N", 30 => "e", 47 => "v", 64 => "=",
  14 => "O", 31 => "f", 48 => "w", 
  15 => "P", 32 => "g", 49 => "x",
  16 => "Q", 33 => "h", 50 => "y"
  }


  
  
  # 加密
  def encode64(str)
    
    raise "参数不是一个字符串" unless str.kind_of?(String)
    
    tstr = str.unpack("B*")

    size = tstr[0].size/6
    ysize = tstr[0].size%6

    tstr2 = []
    for i in 0...size
      tstr2 << tstr[0][i*6,6]
    end  
    
    # 割断码
    if tstr[0].size%6 != 0
      tstr2 << tstr[0][size*6,ysize] + ("0"*(6-ysize)) 
      ym = (6- ysize)/2
    end
    
    # 补足码
    tstr2.collect!{|n|CharBase64[eval("0b"+"00"+n)]}

    # 特殊码
    if ysize != 0
      case ym
      when 1
        tstr2 << CharBase64[64]
      when 2
        tstr2 << CharBase64[64]
        tstr2 << CharBase64[64]
      end  
    end  
    return tstr2.join
  end
  
  # 解密
  def decode64(str)
    stra = str.split(//)
    
    t = 0
    stra.each{|n|
    t += 1 if n == CharBase64[64]
    }
    
    t.times{stra.pop}
    
    strb = []
    strc = ""
    
    dbase64 = CharBase64.invert

    stra.each {|n|strb << dbase64[n]}
    
    strb.collect! do |n|    
     n.to_s(2).length != 6 ? "0"*(6 - n.to_s(2).length) + n.to_s(2) : n.to_s(2)
    end  
   
    if t > 0
      tt = strb[strb.size-1]
      t*2.times{tt.slice!(tt.size-1,1)}
      strb[strb.size-1] = tt
    end

    strb.each{|n|strc+=n}

    return [strc].pack("B*").delete("\000")
  end

end  
   
    
=begin    
    stra.each do |n|
      for i in CharBase64.soft
        if i[1] == n
          strb << i[0]
          break
        end
      end  
    end
=end



=begin
    strb.each do |n|
      if n.to_s(2).length != 6
        l = 6 - n.to_s(2).length
        strc += "0"*l + n.to_s(2)
      else
        strc += n.to_s(2)
      end  
    end 
=end

    #p strd
    

#    for i in 0...strc.size/6
#    strd << strc[6*i,6]
#    end

   


class Hash < Object
  def soft
    @temp = []
    self.each_pair{|key, value| @temp << [key,value] } 
    return @temp
  end  
end  


    
a = RubyBase64.encode64("张三里斯1234abcd"*5)
p RubyBase64.decode64(a)

#p [a].pack("m")

 # a = Zlib::Deflate.deflate("张三李四abcd1234"*1024,9)

 # p Zlib::Inflate.inflate(a)

# p [a].pack("m")

