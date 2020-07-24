class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end


# authenticate_user!
# deviseに実装されているメソッドです。コントローラーに設定することで、ログイン済ユーザーのみにアクセスを許可し、ログインをしていないユーザーはログイン画面に遷移させます。

# before_actionを使用すると、コントローラで定義されたアクションが実行される前に、共通の処理を行うことができます
# class コントローラ名 < ApplicationController
#   before_action :処理させたいメソッド名

# 今回は、sign_upアクションに対して、nickname というキーのパラメーターを追加で許可します。

# ストロングパラメーターとは、指定したキーを持つパラメーターのみを受け取るように制限するものです。
# 以下のように記述することで、特定のキーしか受け取れないような仕組みを構築できます。
# def post_params
#   params.permit(:キー名, :キー名)  # 受け取りたいキーを指定する
# end

# if: :devise_controller?
# はdeviseコントローラーを使用していたらtrueを値とし、ifの左に記載しているコードを実行する

# devise_parameter_sanitizer.permit(:sign_up, keys: [:name])は
# devise_parameter_sanitizer.permit(:sign_up, :keys => [:name])と置き換えることができる。
# keysはもともとdeviseが用意しているキーで、新しく開発者が追加したカラムを入れる箱として振る舞う。
# 逆に言えば、keysにはもともとテーブルに用意されているメールアドレスやパスワードなどのカラムは入っていない。

# つまり，privateは自分からしか見えないメソッドであるのに対して，protectedは一般の人からは見られたくないが，仲間(クラスが同じオブジェクト)からは見えるメソッドです．
# protectedは例えば2項演算子の実装にもう一方のオブジェクトの状態を知る必要があるか調べる必要があるが，そのメソッドをpublicにして，広く公開するのは避けたいというような時に使います．
