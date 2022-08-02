# frozen_string_literal: true

module Adsnap
  class AdminUserRole < ::Adsnap::ApplicationRecord
    belongs_to :admin_user, touch: true
    belongs_to :role
  end
end
