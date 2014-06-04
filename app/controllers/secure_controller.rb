class SecureController < ApplicationController
  before_action :validate_session
end