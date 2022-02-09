module Api::V1
  class ProfileController < BaseController 

    def image
      profile_link = current_user.user_profile_link
      render json: profile_link, status: :ok
    end
  end
end
