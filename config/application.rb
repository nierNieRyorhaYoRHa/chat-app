require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end

# rails gコマンドでコントローラーを作成すると、以下のようなファイルが自動生成されます。
# 生成したファイルに対応したスタイルシート
# 生成したファイルに対応したヘルパー
# 生成したファイルに対応したJavaScriptファイル
# アプリケーションをテストするためのファイル
# 今回作成するChatAppでは、必要のないファイルですので、設定を変更して生成しないようにします。config/application.rbを開き、次のように編集しましょう。