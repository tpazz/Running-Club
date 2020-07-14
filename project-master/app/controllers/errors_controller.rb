# Errors Controller
class ErrorsController < ApplicationController

  skip_before_action :ie_warning
  skip_before_action :verify_authenticity_token, only: [:error_422]
  skip_authorization_check

  # Error 403
  def error_403
  end

  # Error 404
  def error_404
  end

  # Error 422
  def error_422
  end

  # Error 500
  def error_500
    begin
      render
    rescue
      # Display content plain_error
      render layout: 'plain_error'
    end
  end

  # Warning
  def ie_warning
  end

  # Warning for no javascript
  def javascript_warning
  end

end
