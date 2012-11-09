require 'spec_helper'

describe FermentableAddition do
  it { should belong_to :recipe }
  it { should belong_to :fermentable }

  it { should validate_presence_of :recipe_id }
  it { should validate_presence_of :fermentable_id }
  it { should validate_presence_of :weight }
end

