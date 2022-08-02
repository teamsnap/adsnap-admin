# frozen_string_literal: true

Rails.configuration.to_prepare do
  Adsnap::ApplicationController.include(Module.new do
    extend ActiveSupport::Concern

    included do
      prepend_before_action :set_db_connection_and_define_ar_models
    end

    def set_db_connection_and_define_ar_models
      Adsnap::SetDbConnection.call
      Adsnap::DefineArModels.call
    end
  end)

  Adsnap::DataController.include(Module.new do
    extend ActiveSupport::Concern

    included do
      prepend_before_action :maybe_set_db_connection_and_define_ar_models
    end

    def maybe_set_db_connection_and_define_ar_models
      return if Adsnap::SetDbConnection.already_set?

      Adsnap::SetDbConnection.call
      Adsnap::DefineArModels.call
    end
  end)
end
