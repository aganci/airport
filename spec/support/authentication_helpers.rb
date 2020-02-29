module AuthenticationHelpers
  def api_sign_in
    user = create(:user)
    command = AuthenticateUser.new(user.email, user.password).call
    request.headers.merge!({'Authorization': "Bearer #{command.result}"})
  end
end