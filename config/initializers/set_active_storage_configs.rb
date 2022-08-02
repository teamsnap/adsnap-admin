# frozen_string_literal: true

module SetActiveStorageConfigs
  extend ActiveSupport::Concern

  included do
    prepend_before_action :set_active_storage_configs
  end

  # rubocop:disable Metrics/AbcSize
  def set_active_storage_configs
    configs = Adsnap::EncryptedConfig.find_by(key: Adsnap::EncryptedConfig::FILES_STORAGE_KEY)

    return unless configs

    active_storage = Rails.application.config.active_storage

    active_storage.service = configs.value[:service].to_sym
    active_storage.service_configurations[configs.value[:service]].merge!(configs.value[:configs])

    if configs.value[:configs][:endpoint].present?
      active_storage.service_configurations[configs.value[:service]][:force_path_style] = true
    end

    if configs.value[:service] == 'google'
      active_storage.service_configurations[configs.value[:service]][:credentials] =
        JSON.parse(configs.value[:configs].fetch(:credentials, '{}'))
    end

    ActiveStorage::Blob.services =
      ActiveStorage::Service::Registry.new(active_storage.service_configurations)

    ActiveStorage::Blob.service = ActiveStorage::Blob.services.fetch(active_storage.service)
  end
  # rubocop:enable Metrics/AbcSize
end

Rails.configuration.to_prepare do
  Adsnap::ApplicationController.include(SetActiveStorageConfigs)
  ApplicationController.include(SetActiveStorageConfigs)
end
