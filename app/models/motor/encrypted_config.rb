# frozen_string_literal: true

module Adsnap
  class EncryptedConfig < ::Adsnap::ApplicationRecord
    encrypts :value

    serialize :value, Adsnap::HashSerializer

    DATABASE_CREDENTIALS_KEY = 'database.credentials'
    EMAIL_SMTP_KEY = 'email.smtp'
    FILES_STORAGE_KEY = 'files.storage'
  end
end
