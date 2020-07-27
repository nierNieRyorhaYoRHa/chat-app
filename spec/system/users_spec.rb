require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない場合、サインページに移動する' do
    # トップページに遷移する
    visit root_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、ルートパスに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    visit  new_user_session_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path

    # すでに保存されているユーザーのnameとemailを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password

    # ログインボタンをクリックする
    click_on("Log in")

    # ルートページに遷移することを期待する
    expect(current_path).to eq root_path
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # トップページに遷移させる
    visit  root_path

    # ログインしていない場合、サインインページに遷移することを期待する
    expect(current_path).to eq new_user_session_path

    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "example@test.com"

    # ログインボタンをクリックする
    click_on("Log in")

    # サインインページに遷移していることを期待する
    expect(current_path).to eq  new_user_session_path
  end
end




# ログインしていない状態のユーザーがトップページにアクセスした場合は、サインインページに遷移されます。
# 「current_path」は、今アクセスしているページの情報が含まれています。
# expect(X).to eq Yメソッドを用いて、「X」を「current_path」、「Y」を「new_user_session_path」とします。
# つまり、「current_path（現在のページ）」は「new_user_session_path（サインインページ）」となることを期待しています。
# こちらが期待した通りの結果になれば、テストは成功となります。

# この、テストではログインに失敗する挙動を、確認することが目的です。したがって、データベースに保存されている、「メールアドレス」「パスワード」とは異なる値を入力します。
# この際に、確実に失敗する必要があるので、「メールアドレス」には「＠」がないアドレスを入力しています。
# 「パスワード」も同様に、確実に失敗するように、メールアドレスのような値を入力しています。

