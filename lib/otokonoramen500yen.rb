# -*- coding: utf-8 -*-
require 'hpricot'
require 'open-uri'
require 'kconv'

module Otokonoramen500yen
  VERSION = '0.0.1'

  def Otokonoramen500yen.get
    page = open('http://bn.merumo.ne.jp/backno/latestView.do?magId=00589575').read.toutf8
    doc = Hpricot(page)
    body = doc.search('//div[@class="bn_content_text"]').inner_text
    date = doc.search('//div[@class="bn_head"]').inner_text
    date = Time.utc(date.scan(/(\d+)年/).first.first,
                   date.scan(/(\d+)月/).first.first,
                   date.scan(/(\d+)日/).first.first,
                   date.scan(/(\d+)時/).first.first,
                   date.scan(/(\d+)分/).first.first)
    Response.new(body,date)
  end

  class Otokonoramen500yen::Response
    attr_reader :body, :date
    def initialize(body,date)
      @body = body
      @date = date
    end
  end
end
