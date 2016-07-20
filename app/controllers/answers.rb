get '/answers/new' do
  @errors = ["You will need to login in order to answer this question."] unless login?
  erb :'answers/new'
end

post '/answers/:q_id/new' do
  halt(401, "Please login to answer questions.") unless login?
  answer = Answer.new(params[:answer].merge(user: current_user, question_id: params[:q_id]))
  if answer.save
    redirect "questions/#{@question.id}"
  else
    @errors = answer.errors.full_messages
    erb :'answers/new'
  end
end

get '/answers/:id/edit' do
  @answer = Answer.find(params[:id])
  @question = @answer.question
  @user = @answer.user
  halt(401, "You do not have permission to complete this action.") unless login? && current_user == @user
  erb :'answers/edit'
end

put '/answers/:id' do
  @answer = Answer.find(params[:id])
  @question = @answer.question
  @user = @answer.user
  halt(401, "You do not have permission to complete this action.") unless login? && current_user == @user
  @answer.update_attributes(params[:question])
  if @answer.save
    redirect "questions/#{@question.id}"
  else
    @errors = answer.errors.full_messages
    erb :'answers/edit'
  end
end

delete '/answers/:id' do
  @answer = Answer.find(params[:id])
  @question = @answer.question
  @user = @answer.user
  halt(401, "You do not have permission to complete this action.") unless login? && current_user == @user
  @answer.destroy
  redirect "questions/#{@question.id}"
end
