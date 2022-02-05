# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  enum role: { buyer: 0, seller: 1 }.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :products
  has_one :deposit
  has_many :trans
  has_many :bought_products, through: :trans, source: :product
  
  after_create :create_default_deposit

  validates :role, presence: true,
                   inclusion: { in: %w(buyer seller) }

  private
    def create_default_deposit
      Deposit.create(user: self)
    end
end
