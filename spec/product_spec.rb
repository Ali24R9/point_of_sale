require 'spec_helper'

describe Product do
  it {should have_many :items}
  it {should have_many :quantities}
end
