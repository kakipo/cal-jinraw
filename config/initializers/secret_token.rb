# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

if Rails.env.production?
  ComJinrawCal::Application.config.secret_key_base = ENV['SECRET_KEY']
else
  ComJinrawCal::Application.config.secret_key_base = '1a5d503bb2ee5400ae8e8cfc0e302ee164ebd860650a7e61311f752b0dff3978dc3b99cdd20ab525d65e9a70691e92ae65a118ea488b453f845151c2ed212771'
end
