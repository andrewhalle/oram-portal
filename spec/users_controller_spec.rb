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
  
  it "should auto-generate forms for Syrian user" do
    allow(Dir).to receive(:exists?).and_return(false)
    user = double()
    allow(user).to receive(:role).and_return("client")
    allow(user).to receive(:country).and_return("Syrian Arab Republic")
    allow(user).to receive(:languages).and_return(["Arabic"])
    allow(user).to receive(:id).and_return(1000)
    allow(user).to receive(:full_name).and_return("Andrew Halle")
    allow(user).to receive(:email).and_return("ahalle@berkeley.edu")
    allow(user).to receive(:phone).and_return("111-111-1111")
    allow(user).to receive(:updocs).and_return([])
    controller.send :gen_forms, user
    forms = Dir.entries Rails.root.join("public", "ag_forms", "clients", "1000").to_s
    expect(forms).to include("1)ORAM_Confidentiality_Waiver[English_Arabic].pdf", "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", "3)ORAM_Client_in_take_Form[Arabic].pdf", "4)ORAM_Engagement_Agreement_Syrian[English_Arabic].pdf", "5)ORAM_Client_Claim_Guide_[Arabic].pdf")
    FileUtils.rm_r Rails.root.join("public", "ag_forms", "clients", "1000")
  end
  
  it "should auto-generate forms for Arabic (non-syrian) user" do
    allow(Dir).to receive(:exists?).and_return(false)
    user = double()
    allow(user).to receive(:role).and_return("client")
    allow(user).to receive(:country).and_return("Afghanistan")
    allow(user).to receive(:languages).and_return(["Arabic"])
    allow(user).to receive(:id).and_return(1000)
    allow(user).to receive(:full_name).and_return("Andrew Halle")
    allow(user).to receive(:email).and_return("ahalle@berkeley.edu")
    allow(user).to receive(:phone).and_return("111-111-1111")
    allow(user).to receive(:updocs).and_return([])
    controller.send :gen_forms, user
    forms = Dir.entries Rails.root.join("public", "ag_forms", "clients", "1000").to_s
    expect(forms).to include("1)ORAM_Confidentiality_Waiver[English_Arabic].pdf", "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", "3)ORAM_Client_in_take_Form[Arabic].pdf", "4)ORAM_Engagement_Agreement[English_Arabic].pdf", "5)ORAM_Client_Claim_Guide[Arabic].pdf")
    FileUtils.rm_r Rails.root.join("public", "ag_forms", "clients", "1000")
  end
  
  it "should auto-generate forms for Farsi user" do
    allow(Dir).to receive(:exists?).and_return(false)
    user = double()
    allow(user).to receive(:role).and_return("client")
    allow(user).to receive(:country).and_return("Afghanistan")
    allow(user).to receive(:languages).and_return(["Persian/Farsi"])
    allow(user).to receive(:id).and_return(1000)
    allow(user).to receive(:full_name).and_return("Andrew Halle")
    allow(user).to receive(:email).and_return("ahalle@berkeley.edu")
    allow(user).to receive(:phone).and_return("111-111-1111")
    allow(user).to receive(:updocs).and_return([])
    controller.send :gen_forms, user
    forms = Dir.entries Rails.root.join("public", "ag_forms", "clients", "1000").to_s
    expect(forms).to include("1)ORAM_Confidentiality_Waiver[English].pdf", "2)ORAM_Authorization_to_Act_as_Legal_Representative[English_Arabic].pdf", "3)Client_Intake_Form_Bilinugual[English_Persian].pdf", "4)ORAM_Engagement_Agreement[English].pdf", "5)ORAM_Client_Claim_Guide_[Turkey].pdf")
    FileUtils.rm_r Rails.root.join("public", "ag_forms", "clients", "1000")
  end
end
