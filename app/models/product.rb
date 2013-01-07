class Product < ActiveRecord::Base
  attr_accessible :description, :details, :external_id, :external_provider, :external_url, :price, :title, :brand
end
