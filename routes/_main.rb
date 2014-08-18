class BtcSmsWallets < Sinatra::Base
  get "/" do
    haml :index
  end

  def number_filtered
    num = params[:number]
    raise "NumberMalformed" if num == '' || num.nil? || num.size < 7
    num
  end

  post "/login" do
    number = number_filtered
    return( haml :index ) unless number

    user = User.login_or_create number
    session[:user_id] = user.id
    redirect "/account"
  end

  get "/account" do
    uid = session[:user_id]
    return "haml :error_page | user session not found" unless uid # or use halt
    # return(redirect "/")
    @user = User.get uid
    return "haml :error_page | user not found" unless @user

    haml :account
  end
end