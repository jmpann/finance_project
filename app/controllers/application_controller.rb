class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #authenticate_user! part of devise library
  before_action :authenticate_user!
end
