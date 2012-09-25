require 'spec_helper'

describe Recipe do
  it { should belong_to(:beer_style) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:batch_size) }
  it { should validate_presence_of(:description) }
  it { should ensure_inclusion_of(:mash_type).in_array(%w(extract grain partial)) }
end

