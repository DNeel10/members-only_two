class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])

    @post.delete
    redirect_to root_path
    
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
