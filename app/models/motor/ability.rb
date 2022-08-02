# frozen_string_literal: true

module Adsnap
  class Ability
    include CanCan::Ability

    def initialize(admin_user, _request = nil)
      return unless admin_user

      Adsnap::AdminUsers.load_permissions_from_cache(admin_user).each do |rule|
        can rule['actions'].map(&:to_sym), rule['subjects'].map(&:to_sym)
      end
    end
  end
end
