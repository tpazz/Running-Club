Rails.application.config.session_store :active_record_store, key: (Rails.env.production? ? '_runningclubmanagement_session_id' : (Rails.env.demo? ? '_runningclubmanagement_demo_session_id' : '_runningclubmanagement_dev_session_id')),
                                                             secure: (Rails.env.demo? || Rails.env.production?),
                                                             httponly: true
