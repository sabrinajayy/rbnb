
class SessionCheck

  def initialize(user)
    @user
  end

  def call
    resolve_user
  end

  private

  def resolve_user

    if @user != nil
      @page_user = current_user
    end
    @page_user
  end

end
