class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

# ストロングパラメーターを使用し、user_paramsを定義します。
# user_paramsの中でpermitメソッドを使用し、「name」と「email」の編集を許可します。
# そして、ユーザー情報が格納されているcurrent_userメソッドを使用して、ログインしているユーザーの情報を更新します。