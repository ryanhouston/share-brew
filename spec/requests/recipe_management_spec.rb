require 'spec_helper'

describe 'Recipe management' do

  before (:each) do
    @user = FactoryGirl.create(:user)
    post new_user_session_path,
      'user[email]' => @user.email, 'user[password]' => @user.password
  end

  it 'creates a new recipe before allowing ingredient additions' do
    get '/recipes/new'
    response.should render_template(:new)
    response.body.should include "Original gravity"
  end
end

