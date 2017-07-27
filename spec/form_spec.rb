require 'rails_helper'

RSpec.describe Form, type: :model do
  it "gets the form hash" do
    @form = Form.create
    expect(@form.getFormHash).to be_nil
  end
  
  it "knows its name" do
    @form = Form.create
    @form.first_name = "George"
    @form.last_name = "Cloony"
    expect(@form.full_name).to eq("George Cloony")
  end
end