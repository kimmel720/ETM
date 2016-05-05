# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( nike.jpg )

Rails.application.config.assets.precompile += %w( etm.css )

Rails.application.config.assets.precompile += %w( panorama.js )

Rails.application.config.assets.precompile += %w( Three.js )

Rails.application.config.assets.precompile += %w( three.min.js )

Rails.application.config.assets.precompile += %w( displayfloorplan.js )

Rails.application.config.assets.precompile += %w( editfloorplan.js )

Rails.application.config.assets.precompile += %w( dat.gui.js )

Rails.application.config.assets.precompile += %w( resizefloorplan.js )
