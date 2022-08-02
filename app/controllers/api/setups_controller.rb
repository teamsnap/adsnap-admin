# frozen_string_literal: true

module Api
  class SetupsController < ApiBaseController
    AlreadySetupError = Class.new(StandardError)

    skip_authorization_check

    def create
      raise AlreadySetupError if Adsnap::AdminUser.count.positive?

      user = Adsnap::AdminUser.new(admin_user_params.merge(roles: [Adsnap::Role.superadmin]))

      if user.save
        sign_in(user)

        render json: { data: user.as_json }
      else
        render json: { errors: user.errors.as_json }, status: :unprocessable_entity
      end
    end

    private

    def admin_user_params
      params.require(:admin_user).permit(:first_name, :last_name, :email, :password)
    end
  end
end
