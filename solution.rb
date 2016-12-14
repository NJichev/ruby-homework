require_relative 'version'
require 'rspec'

RSpec.describe Version do
  it 'creates valid versions' do
    expect(Version.new('1.2.3.4.5.6.7.8')).not_to raise_error(ArgumentError)
  end
end
