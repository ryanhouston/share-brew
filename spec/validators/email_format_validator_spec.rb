require 'rails_helper'
require 'validators/email_format_validator'
require 'active_model'

class EmailValidatable
  include ActiveModel::Validations

  attr_accessor :email
  validates :email, email_format: true
end

describe EmailFormatValidator do
  subject { EmailValidatable.new }

  context "object with a valid email address" do
    before(:each) { subject.email = 'valid@email.com' }
    it { is_expected.to be_valid }
  end

  context "object with an invalid email address" do
    before(:each) { subject.email = 'not_valid_email' }
    it { is_expected.not_to be_valid }
  end
end

