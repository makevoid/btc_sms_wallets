class BtcSmsWallets < Sinatra::Base
  get "/" do
    haml :index
  end

  def number_filtered
    params[:number]
  end

  post "/login" do
    number = number_filtered
    return( haml :index ) unless number

    user = User.login_or_create number
    session[:user_id] = user.id
    redirect "/account"
  end


  get "/account" do
    user = User.get session[:user_id]

    haml :account
  end
end