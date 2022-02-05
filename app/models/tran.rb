class Tran < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true
  validates :user, presence: true
  validates :product, presence: true
  validates :spent, presence: true
  validate :buyer_deposit
  validate :product_availability

  before_validation :calculate_spent
  after_create :update_user_deposit

  private
    def buyer_deposit
      if user.deposit.amount < spent
        errors.add(:user, "Your deposit is insufficient")
      end
    end

    def product_availability
      if quantity > product.quantity
        errors.add(:product, "Product is out of stock")
      end
    end

    def calculate_spent
      self.spent = quantity * product.cost
    end

    def update_user_deposit
      user.deposit.update(amount: 0)
    end
end
