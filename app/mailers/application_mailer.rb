# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'reports@teamsnap.com'
  layout 'mailer'
end
