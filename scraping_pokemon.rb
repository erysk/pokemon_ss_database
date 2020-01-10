require 'nokogiri'
require 'open-uri'
require 'kconv'

url = 'https://yakkun.com/swsh/stats_list.htm'
charset = URI.parse(url).read.charset
html = URI.open(url) { |f| f.read }
doc = Nokogiri::HTML.parse(html.toutf8, nil, charset)

csv_header = %w[No Name H A B C D S All]
csv = doc.css('table tbody tr').map { |tr| tr.css('td').map(&:text) }

require "csv"

CSV.open('pokemon_db.csv','w') do |file|
  file << csv_header
  csv.each(&file.method(:<<))
end
