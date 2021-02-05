require 'curb'
require 'nokogiri'
require_relative 'parsing'


class Loader
  def self.thread(links)
    result = []
    thread_arr = []
    begin
      links.each do |link|
        thread_arr << Thread.new do 
          goods = Parsing.loading(link)
          result += goods
        end
      end
      thread_arr.each(&:join)
      return result
    end
  end
end