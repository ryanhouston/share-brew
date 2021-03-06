require 'rails_helper'

describe 'Recipe management' do

  before (:each) do
    @user = FactoryGirl.create(:user, confirmed_at: Time.now)
    post new_user_session_path,
      'user[email]' => @user.email, 'user[password]' => @user.password
  end

  it 'creates a new recipe before allowing ingredient additions' do
    get '/recipes/new'
    expect(response).to render_template(:new)
    expect(response.body).to include "Original gravity"
  end
end

