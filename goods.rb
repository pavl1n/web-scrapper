require 'curb'
require 'nokogiri'


class Goods
	def initialize(url)
		@url = url
		@good = []
	end

	def get_http(page)
		http = Curl.get(@url + "?p=#{page}")
	end

 	def parsing_goods
 		xpath_link = '//div[@class="product-container"]/div/div/a/@href'
 		page = 2
 		begin
      		html = Nokogiri::HTML(get_http(page).body_str)
 			links = html.xpath(xpath_link)
			links.each {|link| @good << link}
			output(page, links.size)
			page += 1
		end while links.size > 0
	end

	def output(page, links)
		puts links.size > 0 ? "Links from page #{page - 1} has been parsed" : "Something go wrong!"
	end

	def get_goods
		return @good
	end

end