require_relative 'miner'
require_relative 'db'

module Shabang
  def self.mine_and_insert
    DB.insert(Miner.n_days_old_news(4))
  end
end

Shabang.mine_and_insert
