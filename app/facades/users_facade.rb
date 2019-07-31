class UsersFacade
  attr_reader :id

  def initialize(user)
    @user = user
  end

  def email
    @user[:email]
  end

  def api_key
    @user[:api_key]
  end
end
