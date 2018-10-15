require 'nokogiri'
require 'open-uri'
require 'csv'

url = "https://cookpad.com/recipe/hot"

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = (Nokogiri::HTML.parse(html,nil,charset))


arr = Array.new


doc.css("div.recipe_list_wrapper").each do |row|
  puts row.css("div.recipe_list_inner").css("div.wadai_recipe_wrapper").css("div.text").css("a.recipe-title").text
  arr << row.css("div.recipe_list_inner").css("div.wadai_recipe_wrapper").css("div.text").css("a.recipe-title").text
end

#書き込みできない。多分、ソースに表示されていない動的なコンテンツは獲得できない。静的なもので試そう
CSV.open("cookpad-wadai.csv","w") do |csv|
  arr.each do |line|
    csv << line
  end
end

string_csv_format = CSV.generate do |data|
  arr.each do |line|
    data << line
  end
end

puts string_csv_format


#div.recipe_list_wrapper > div.recipe_list_inner > div.wadai_recipe_wrapper > div.text >a.recipe-title.text
