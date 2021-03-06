# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )


Rails.application.config.assets.precompile += %w( order.js )
Rails.application.config.assets.precompile += %w( recommend.js )
# ワイルドカードでうまくいかなかったため仮に

# administrators
Rails.application.config.assets.precompile += %w( administrators/registrations/new.scss )
Rails.application.config.assets.precompile += %w( administrators/sessions/new.scss )

#greeds
Rails.application.config.assets.precompile += %w( greeds/new.scss )
Rails.application.config.assets.precompile += %w( greeds/index.scss )

# users
Rails.application.config.assets.precompile += %w( users/registrations/new.scss )
Rails.application.config.assets.precompile += %w( users/sessions/new.scss )
Rails.application.config.assets.precompile += %w( users/password_edit.scss )
Rails.application.config.assets.precompile += %w( users/show.scss )
Rails.application.config.assets.precompile += %w( users/edit.scss )
Rails.application.config.assets.precompile += %w( users/admin_index.scss )
Rails.application.config.assets.precompile += %w( users/admin_show.scss )
Rails.application.config.assets.precompile += %w( users/admin_edit.scss )
Rails.application.config.assets.precompile += %w( users/service.scss )
Rails.application.config.assets.precompile += %w( users/privacy.scss )
Rails.application.config.assets.precompile += %w( users/contact.scss )
Rails.application.config.assets.precompile += %w( users/payment.scss )



#products
Rails.application.config.assets.precompile += %w( products/index.scss )
Rails.application.config.assets.precompile += %w( products/show.scss )
Rails.application.config.assets.precompile += %w( products/recommend.scss )
Rails.application.config.assets.precompile += %w( products/admin_index.scss )
Rails.application.config.assets.precompile += %w( products/admin_new.scss )
Rails.application.config.assets.precompile += %w( products/admin_show.scss )
Rails.application.config.assets.precompile += %w( products/search.scss )
Rails.application.config.assets.precompile += %w( products/admin_edit.scss )



#cart-items
Rails.application.config.assets.precompile += %w( cart_items/index.scss )

#orders
Rails.application.config.assets.precompile += %w( orders/admin_index.scss )
Rails.application.config.assets.precompile += %w( orders/new.scss )
Rails.application.config.assets.precompile += %w( orders/admin_show.scss )
Rails.application.config.assets.precompile += %w( orders/show.scss )
Rails.application.config.assets.precompile += %w( orders/thanks.scss )
Rails.application.config.assets.precompile += %w( thanks.js )

