require 'sqlite3'

module DB
  def self.fetch_db
    SQLite3::Database.new 'ampparit.db'
  end

  def self.insert(news_items)
    db = DB.fetch_db
    DB.create_news_item_table(db)
    news_items.each do |news_item|
      DB.insert_news_item(db, news_item)
    end
  end

  def self.create_news_item_table(db)
    return unless table_exist?(db, 'news_items')
    db.execute <<-SQL
      create table news_items (
        title text,
        url text,
        date text,
        votes text,
        clicks text,
        timestamp text
      );
    SQL
  end

  def self.table_exist?(db, name)
    db.execute(
      "SELECT name FROM sqlite_master WHERE name='#{name}'"
    ).empty?
  end

  def self.insert_news_item(db, news_item)
    db.execute('INSERT INTO news_items (title, url, date, votes, clicks, timestamp)
                VALUES (?, ?, ?, ?, ?, ?)',
               [
                 news_item[:title],
                 news_item[:url],
                 news_item[:date],
                 news_item[:votes],
                 news_item[:clicks],
                 Time.now.to_s
               ])
  end
end
