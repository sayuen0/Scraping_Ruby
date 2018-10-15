###scrape_from_naver.rb###
##naverまとめの注目まとめからCSVファイルを作成##

require "nokogiri"
require "open-uri"
require "csv"

url = "https://matome.naver.jp"

charset = nil

html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = (Nokogiri::HTML.parse(html,nil,charset))

arr = Array.new

#2次元配列を作成
doc.css("div.mdTopMTMList01Txt").each do |row|
  arr << [row.css("h3.mdTopMTMList01ItemTtl").css("a").text,  row.css("div.mdTopMTMList01Option").css("p.mdTopMTMList01PVCount").css("span.mdTopMTMList01PVCountNum").text]
end


# #↓これをCSVファイルに書き込むために改変する
string_csv_format = CSV.generate do |data|
  arr.each do |line|
    data << line
  end
end

CSV.open("naver-matome.csv","w") do |csv| #|csv|（変数）に所定の動作を行う
  arr.each do |line|
    csv << line
  end
end

puts string_csv_format


#cookpadの話題のレシピから
