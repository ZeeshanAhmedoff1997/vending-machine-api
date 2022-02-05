# frozen_string_literal: true

class DepositPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    user.buyer?
  end

  def update?
    user.buyer?
  end

  def destroy?
    user.buyer?
  end
end
