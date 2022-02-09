# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  enum role: { buyer: 0, seller: 1 }.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :products, dependent: :destroy
  has_one :deposit, dependent: :destroy
  has_many :trans, dependent: :destroy
  has_many :bought_products, through: :trans, source: :product
  
  has_one_attached :profile_pic
  after_create :create_default_deposit

  validates :role, presence: true,
                   inclusion: { in: %w(buyer seller) }

  

  def user_profile_link
    if profile_pic.present?
      Rails.application.routes.url_helpers.rails_blob_path(profile_pic, only_path: true)
    end
  end

  private
    def create_default_deposit
      Deposit.create(user: self)
    end
end
