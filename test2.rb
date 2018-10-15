require "open-uri"
require "nokogiri"
require "csv"

CSV.open("qiita-keywords.csv", "w") do |csv|
    for path in 1..4 do
        url = "https://qiita.com/tags?page=#{path}/"
        # 1ページ目のみの場合は以下
        # url = "https://qiita.com/tags"

        charset = nil
        html = open(url) do |f|
            charset = f.charset
            f.read
        end

        doc = Nokogiri::HTML.parse(html,nil,charset)
        doc.css(".TagList__item a").each do |kw| # cssセレクタで、出力したいHTMLタグを選択
            kws = kw.inner_text
            # テキストがマークアップされておらず、普通にスクレイピングすると不要な記号の正規表現等が入り込んでしまう場合は、以下のように.gsubで取り除く
            # kws = kw.inner_text.gsub("\n","")
            # 他の要素情報の取得については、https://www.qoosky.io/techs/24752f45e3 を参照

            p kws # コマンドラインにも出力して分かりやすく
            csv << [kws] # csvに書き込み
            sleep(0.5) #サーバ攻撃とみなされないためにsleep処理。1秒休む。
        end
    end
end
