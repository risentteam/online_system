# Be sure to restart your server when you modify this file.

#App::Application.config.session_store :cookie_store, key: '_app_session'
App::Application.config.session_store :cookie_store, key: '_some_key', domain: :all, tld_length: 2
