Rails.application.config.i18n.default_locale = :ja
Rails.application.config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]