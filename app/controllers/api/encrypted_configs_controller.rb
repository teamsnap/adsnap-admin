# frozen_string_literal: true

module Api
  class EncryptedConfigsController < ApiBaseController
    load_and_authorize_resource class: 'Adsnap::EncryptedConfig', id_param: :key, find_by: :key

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    def index
      render json: { data: @encrypted_configs }
    end

    def show
      render json: { data: @encrypted_config }
    end

    def create
      @encrypted_config =
        Adsnap::EncryptedConfig.find_or_initialize_by(key: @encrypted_config.key).tap do |config|
          config.value = @encrypted_config.value
        end

      @encrypted_config.save!

      render json: { data: @encrypted_config }
    rescue ActiveRecord::RecordNotUnique
      retry
    end

    private

    def encrypted_config_params
      params[:data].to_unsafe_h.slice(:key, :value)
    end
  end
end
