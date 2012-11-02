class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :shib_auth_url

  private
  def redirect_back_or_default
    redirect_to(request.referer || course_path)
  end

  def root_url
    "#{request.env['SCRIPT_NAME']}/"
  end

  def shib_auth_url
    "#{request.env['SCRIPT_NAME']}/auth/shibboleth"
  end

  def authenticate!
    if session[:user].nil?
      session[:return_url] = request.url
      redirect_to shib_auth_url and return
    end
    session[:return_url] = nil
  end

end
