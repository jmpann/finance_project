class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  require 'csv'
  require 'nokogiri'
end
