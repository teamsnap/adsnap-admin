# frozen_string_literal: true

module Api
  class RolesController < ApiBaseController
    load_and_authorize_resource class: 'Adsnap::Role'

    def index
      render json: { data: @roles }
    end
  end
end
