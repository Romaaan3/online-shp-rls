class Cp::UsersController < Cp::AdminController
  load_and_authorize_resource
	before_action :set_user, only: [:show, :update]

	def index
		@users = User.all
    @unactivated_users = User.where(confirmed_at: nil)
	end

	def show
	end

	def update
    if @user.update(user_params)
    	redirect_to cp_user_path(@user), notice: "Пользователь обновлен"
    else
    	render show, notice: "При обновлении пользователя что-то пошло не так."
  	end
	end

  def delete_unactivated_users
    count = User.where(confirmed_at: nil).count
    @users = User.where(confirmed_at: nil)
    @users.each do |user|
      unless user.orders == nil
        user.orders.each do |order|
          order.client_id = nil
          order.save
        end
      end
      user.destroy
    end

    redirect_to :back, notice: "Удалено #{count} пользователей"

  end

  private
    def set_user
			@user = User.find(params[:id])
    end
    def user_params
    	params.require(:user).permit(:role_id)
    end
end
