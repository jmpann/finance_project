class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #authenticate_user! part of devise library
  before_action :authenticate_user!

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  
end
