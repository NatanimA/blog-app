class Api::UsersController < Api::ApiController
  def index
    @user = User.includes(posts: [:comments], likes: [:post])
    render json: @user
  end
end
