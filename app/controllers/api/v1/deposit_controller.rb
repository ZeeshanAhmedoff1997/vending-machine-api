module Api::V1
  class DepositController < BaseController
    before_action :authorization
    
    def show
      deposit = current_user.deposit

      render json: deposit, status: :ok
    end

    def update
      deposit = current_user.deposit
      current_amount = deposit.amount
      if deposit.update(amount: current_amount + deposit_param[:deposit].to_i)
        render json: deposit, status: :ok
      else
        render json: deposit.errors, status: :unprocessable_entity
      end
    end

    def destroy
      render json: { change: current_user.deposit.change }, status: :ok
    end

    private

    def deposit_param
      params.permit(:deposit)
    end

    def authorization
      authorize Deposit  
    end
  end
end