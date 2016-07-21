get '/users/new' do 
	erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
        binding.pry
    redirect '/'
    end
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end


get '/users/:id' do
	@user = User.find(params[:user_id])
		erb :'/users/show'
end




