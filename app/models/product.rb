class Product < ApplicationRecord
  include PgSearch::Model
  has_one_attached :photo
  belongs_to :category

  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }, using: {
    tsearch: { prefix: true } # Use the trigram index method
  }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true


end
