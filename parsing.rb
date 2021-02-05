require 'curb'
require 'nokogiri'
require_relative 'feed'

$title = '//h1[contains(@class ,"product_main_name")]'
$size = '//span[contains(@class, "radio_label")]'
$prices = '//span[contains(@class, "price_comb")]'
$image = '//img[@id="bigpic"]/@src'

class Parsing
	def self.loading(link)
    	@goods = []
    	begin
    		http = Curl.get(link)
    	rescue 
      		puts 'Problem with link'
    	end
    	begin
      		html = Nokogiri::HTML(http.body_str)
      		title = html.xpath($title).first.content.strip.capitalize
      		size = html.xpath($size).to_a
      		prices = html.xpath($prices).to_a
      		image = html.xpath($image).first.content.strip
      		zipping(title, size, prices, image)
      		puts "Product from [#{link}] loaded"
    	rescue
      		puts "Can't load information from [#{link}]"  
    	end
    	return @goods
  	end

  	def self.zipping(title, size, prices, image)
    	size.zip(prices).each do |s, p|
        @goods << Dog_feed.new(title, s.text, p.text, image)
      end
    end

end