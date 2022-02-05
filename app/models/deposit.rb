class Deposit < ApplicationRecord
  COINS = [5, 10, 20, 50, 100]

  belongs_to :user

  validate :coin_deposit

  private
    def coin_deposit
      if amount =! 0
        unless COINS.include?(amount - amount_in_database)
          errors.add(:amount, "invalid coin deposit")
        end
      end
    end
end