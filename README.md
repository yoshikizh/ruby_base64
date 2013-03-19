# RubyBase64

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_base64'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_base64

## Usage

Base64加密算法

1.加密
Base64.encode64(string) 
string必须是字符串

2.解密
Base64.decode64(string) 
string必须是Base64加密过的字符串

例子：
a = Base64.encode64("张三李四abcd1234")
p Base64.decode64(a)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
