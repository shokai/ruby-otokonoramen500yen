# -*- coding: utf-8 -*-
require 'hpricot'
require 'open-uri'
require 'kconv'

module Otokonoramen500yen
  VERSION = '0.0.3'

  def Otokonoramen500yen.url
    'http://bn.merumo.ne.jp/backno/latestView.do?magId=00589575'
  end

  def Otokonoramen500yen.get
    page = open(url).read.toutf8
    doc = Hpricot(page)
    body = doc.search('//div[@class="bn_content_text"]').inner_text
    date = doc.search('//div[@class="bn_head"]').inner_text
    date = Time.utc(date.scan(/(\d+)年/).first.first,
                   date.scan(/(\d+)月/).first.first,
                   date.scan(/(\d+)日/).first.first,
                   date.scan(/(\d+)時/).first.first,
                   date.scan(/(\d+)分/).first.first)
    Response.new(body,date,url)
  end

  class Otokonoramen500yen::Response
    attr_reader :body, :date, :url
    def initialize(body,date,url)
      @body = body
      @date = date
      @url = url
    end
  end
end
