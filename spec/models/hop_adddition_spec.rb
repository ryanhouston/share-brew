require 'spec_helper'

describe HopAddition do
  it { should belong_to :recipe }
  it { should belong_to :hop }
  it { should validate_presence_of :recipe_id }
  it { should validate_presence_of :hop_id }
  it { should validate_presence_of :alpha_acid }
  it { should validate_presence_of :form }
  it { should validate_presence_of :duration }
  it { should validate_presence_of :weight }
  it { should validate_presence_of :use }
  it { should validate_numericality_of :alpha_acid }
  it { should validate_numericality_of :beta_acid }
  it { should validate_numericality_of :duration }
  it { should validate_numericality_of :weight }
end
