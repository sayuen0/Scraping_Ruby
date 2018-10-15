#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

#webに接続するためのライブラリ
require "open-uri"
#クレイピングに使用するライブラリ
require "nokogiri"

#クレイピング対象のURL
url = "http://dic.nicovideo.jp/a/%E3%82%AF%E3%83%81%E3%83%BC%E3%83%88/"
#ニコニコ大百科「クチートとは」
#取得するhtml用charset
charset = nil

html = open(url) do |page|
  #charsetを自動で読み込み、取得
  charset = page.charset
  #中身を読む
  page.read
end

# Nokogiri で切り分け
contents = Nokogiri::HTML.parse(html,nil,charset)

puts contents.title
puts contents.document



#content.titleで記事タイトルを取得
#content.documentで記事内容を取得
