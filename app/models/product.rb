class Product < ApplicationRecord
  belongs_to :user
  has_many :trans
  has_many :buyers, through: :trans, source: :user
  
  validates :name, presence: true
  validates :quantity, numericality: { greater_than: -1 }
  validates :cost, numericality: { greater_than: -1 }
  validate :user_must_be_seller

  has_one_attached :image

  def product_image
    if image.present?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end

  private

  def user_must_be_seller
    if user.role != "seller"
      errors.add(:user, "Only seller can create products")
    end
  end
end
