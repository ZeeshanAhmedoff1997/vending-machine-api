class Deposit < ApplicationRecord
  COINS = [100, 50, 20, 10, 5]

  belongs_to :user

  validate :coin_deposit

  def change
    amount_to_return = amount
    change_coins = {}

    COINS.each do |coin|
      change_coins[coin] = amount_to_return/coin

      amount_to_return = amount_to_return - change_coins[coin] * coin
    end

    update(amount: 0)
    change_coins
  end

  private
    def coin_deposit
      if amount =! 0
        unless COINS.include?(amount - amount_in_database)
          errors.add(:amount, "invalid coin deposit")
        end
      end
    end
end