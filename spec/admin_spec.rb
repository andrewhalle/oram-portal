require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "collects its user ids" do 
    admin = Admin.create
    user = User.create
    ownership = Ownership.create
    ownership.user_id = user.id
    ownership.admin_id = admin.id
    expect(admin.get_user_ids).not_to be_nil
  end
end