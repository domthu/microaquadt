# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_microaqua_session',
  :secret      => 'c716bb54504d4e3995375d6356b54a5dafb47f69dae09cdb1a4e18a6f20cb9a02d2f581e5859e54a95fdac1bfea236a61ca45fb2418a7175ecc4e5f75d399c99'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
