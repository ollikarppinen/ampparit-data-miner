require 'nokogiri'
require 'open-uri'

module Miner
  def self.news_items(n)
    n.css('.news-item-wrapper')
  end

  def self.news_item_to_hash(n)
    {
      title: n.css('a').text,
      source: n.css('.news-item-source').text,
      date: n.css('.news-item-date').text,
      votes: n.css('.news-item-votes').text,
      clicks: n.css('.news-item-clicks').text,
      url: n.css('.news-item-headline').first.attributes['href'].text
    }
  end

  def self.parse_page(page_number)
    doc = Nokogiri::HTML(open("http://www.ampparit.com/?pg=#{page_number}"))
    news_items(doc).map { |i| news_item_to_hash(i) }
  end

  def self.parse_entire_site
    [*1..99].flat_map { |page_number| parse_page(page_number) }
  end

  def self.n_days_old_news(days)
    parse_entire_site.select { |n| days_old?(days, n) }
  end

  def self.parse_date(date_string)
    DateTime.strptime(date_string + '+0200', '%H:%M, %e.%m.%z')
  end

  def self.days_old?(days, news)
    parsed_date = parse_date(news[:date])
    days_ago?(days, parsed_date)
  end

  def self.days_ago?(days, date)
    ((DateTime.now - date) * 24.0).floor == 24 * days
  end
end
