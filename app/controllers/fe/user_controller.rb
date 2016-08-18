class Fe::UserController < ApplicationController

  def profile
    if current_user == nil
      redirect_to new_user_session_path
    end
    if current_user && current_user.root?
      redirect_to cp_root_url
    end
    @title = "Странциа пользователя"
  end

end
