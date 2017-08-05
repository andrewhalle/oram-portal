require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # login_user
  # before(:each) do
  #   @user1 = User.create(email: "u1@email.com", first_name: "user", last_name: "one", role: "client", password: "123456")
  #   @user1.save!
  #   @user1.add_role :client
  # end
  # it "should have a current_user" do
  #   # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
  #   expect(subject.current_user).to_not eq(nil)
  # end

  it "should not allow users to see other user profiles" do
    get :edit_referrer_profile, {:id => 4}
    expect(response).to redirect_to(root_path)
  end

  it "should have document buffer when created" do
    # expect(@user1.case_document).to_not be_nil
  end

  it "should show client documents correctly" do
    # get :client_documents, {:id => @user1.id}
    # expect(response).to redirect_to(documents_path)
  end

  it "should receive document uploads of pdf type correctly" do
    # get :upload_document, {:id => @user1.id}
    # expect(response).to redirect_to(upload_path(@user1))
  end
  
  it "should delete users" do
    get :user_destroy, {:id => 1}
    expect(response).to redirect_to(:root)
  end
end
