# frozen_string_literal: true

module DynamicSettingsInterceptor
  module_function

  def delivering_email(message)
    email_configs = Adsnap::EncryptedConfig.find_by(key: Adsnap::EncryptedConfig::EMAIL_SMTP_KEY)

    return message unless email_configs

    message.delivery_method(:smtp, user_name: email_configs.value[:username],
                                   password: email_configs.value[:password],
                                   address: email_configs.value[:host],
                                   port: email_configs.value[:port],
                                   tls: email_configs.value[:port].to_s == '465',
                                   ca_file: '/tmp/adsnap-admin.pem')

    message.from = email_configs.value[:address]
    message.reply_to = email_configs.value[:address]

    message
  end
end

ActionMailer::Base.register_interceptor(DynamicSettingsInterceptor)
