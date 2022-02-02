class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :quantity, comparison: { greater_than: -1 }
  validates :cost, comparison: { greater_than: -1 }
end
