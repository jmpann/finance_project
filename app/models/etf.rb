class Etf < ApplicationRecord
  has_many :top_holdings
  has_many :sector_allocations
  has_many :country_weights
end
