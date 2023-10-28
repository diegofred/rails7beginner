class Product < ApplicationRecord
  has_one_attached :photo
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
