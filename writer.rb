require 'csv'

class Writer
	def self.write(goods, file)
		CSV.open(file, 'w') do |writer|
			goods.each { |good| writer << [good.title + ' - ' + good.size, /^[0-9]*[.,]?[0-9]+/.match(good.price)[0],
                good.image]}
        end
    end
end