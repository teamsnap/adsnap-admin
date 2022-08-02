# frozen_string_literal: true

require 'adsnap/configs'

module Adsnap
  module ConfigsCli
    module_function

    def dump
      Adsnap::Configs::WriteToFile.write_with_lock

      puts '✅ adsnap.yml configs file has been updated'
    end

    def load
      Adsnap::Configs::SyncFromFile.call(with_exception: true)

      puts '✅ configs have been loaded from adsnap.yml'
    end

    def reload
      ActiveRecord::Base.transaction do
        Adsnap::Configs.clear
        Adsnap::Configs::SyncFromFile.call(with_exception: true)
      end

      puts '✅ configs have been re-loaded from adsnap.yml'
    end

    def sync
      remote_url = ENV['MOTOR_SYNC_REMOTE_URL']
      api_key = ENV['MOTOR_SYNC_API_KEY']

      raise 'Specify target app url using `MOTOR_SYNC_REMOTE_URL` env variable' if remote_url.blank?
      raise 'Specify sync api key using `MOTOR_SYNC_API_KEY` env variable' if api_key.blank?

      Adsnap::Configs::SyncWithRemote.call(remote_url, api_key)
      Adsnap::Configs::WriteToFile.write_with_lock

      puts "✅ Adsnap Admin configurations have been synced with #{remote_url}"
    rescue Adsnap::Configs::SyncWithRemote::ApiNotFound
      puts '⚠️  Synchronization failed: you need to specify `MOTOR_SYNC_API_KEY` ' \
           'env variable in your remote app in order to enable this feature'
    end
  end
end
