require 'spec_helper'

describe Social do
  subject { Social }

  it { should respond_to :tweet }

  it 'delegates to the twitter library' do
    Twitter.should_receive :update
    Social.tweet 'message!'
  end
end