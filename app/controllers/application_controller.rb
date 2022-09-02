class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    redirect_to current_user.posts.index
  end
end
