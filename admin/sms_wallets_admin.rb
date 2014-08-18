class WalletsAdmin < Sinatra::Base

  @@path = File.expand_path "../", __FILE__
  # set :public_folder, "#{@@path}/views"

  get "/" do
    haml :index
  end


  # very evil: disable admin entirely in production or remove this route :)

  post "/data_delete" do
    unsafe_executable_ruby_code = params[:data_execute]
    eval unsafe_executable_ruby_code # !!!
    redirect "/admin/"
  end

end