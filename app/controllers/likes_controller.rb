class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, except: [:create, :index]

  def create
    like = Like.create(post_id: params[:post_id], user_id: current_user.id)
    if like.save
      redirect_back fallback_location: root_path, notice: "Post #{params[:post_id]} liked by #{current_user.id}!"
    else
      redirect_back fallback_location: root_path, alert: "Sorry, your request could not be completed. (#{likes.errors.full_messages.join(', ')}.)"
    end
  end

  def delete
    if @like.user_id == current_user.id
      @like.destroy
      redirect_back fallback_location: root_path, notice: 'Like was successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this like.'
      redirect_to root_url
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end
end
