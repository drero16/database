# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.configure do

  config.assets.precompile += %w[print.js jquerySelectBoxes.js index.scss serviceworker-companion.js.erb photoswipe.scss default-skin.scss photoswipe.js photoswipe-ui-default.js ram.scss serviceworker.js manifest.json form-elements.css style.scss styleLogin.css jquery.backstretch.js main.scss centered-columns.scss  ejemploPerdido.scss gmaps.js jquery.backstretch.json auth.scss info.scss]

end

%w( adoptions risks animals comments devices events images information notifications pets races roles users welcome  ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js.coffee", "#{controller}.scss"]
end