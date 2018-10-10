require 'spec_helper'
describe 'myapache' do
  context 'with default values for all parameters' do
    it { should contain_class('myapache') }
  end
end
