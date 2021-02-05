require_relative 'goods'
require_relative 'Loader'
require_relative 'writer'


class Parser
	def self.start
		puts 'Program has started.'
		@url = ARGV[0]
		@file = ARGV[1]
		parsing_links
	end

	def self.parsing_links
		puts 'Parsing links'
		goods = Goods.new(@url)
		goods.parsing_goods
		loading_products(goods)
	end

	def self.loading_products(goods)
		puts "#{goods.get_goods.size} products loading started..."
		result = Loader.thread(goods.get_goods)
		puts 'Products loading finished'
		writing_to_csv(result)
	end

	def self.writing_to_csv(result)
		puts "Writing in #{@file}"
		Writer.write(result, @file)
		puts 'Program finished'
	end
end

Parser.start