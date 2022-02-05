# frozen_string_literal: true

class ProductPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.seller?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def user_products?
    create?
  end

  def buy?
    user.buyer?
  end
end
