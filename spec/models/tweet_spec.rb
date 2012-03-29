require 'spec_helper'

describe Tweet do

  it 'can be instantiated' do
    Tweet.new.should be_an_instance_of(Tweet)
  end

  it 'can be saved successfully' do
    FactoryGirl.create(:tweet).should be_persisted
  end

  context 'when validating tweet' do

    context 'text presence' do
      let(:tweet) do
        FactoryGirl.build(:tweet, text: nil)
      end

      before { tweet.valid? }

      it 'must be provided' do
        tweet.errors[:text].should == [ "can't be blank" ]
      end
    end

    context 'user handle presence' do
      let(:tweet) do
        FactoryGirl.build(:tweet, user_handle: nil)
      end

      before { tweet.valid? }

      it 'must be provided' do
        tweet.errors[:user_handle].should == [ "can't be blank" ]
      end
    end

    context 'location presence' do
      let(:tweet) do
        FactoryGirl.build(:tweet, location: nil)
      end

      before { tweet.valid? }

      it 'must be provided' do
        tweet.errors[:location].should == [ "can't be blank" ]
      end
    end

    context 'user avatar Url' do
      let(:tweet) do
        FactoryGirl.build(:tweet, user_avatar_url: 'htt://abc')
      end

      before { tweet.valid? }

      it 'must be provided' do
        tweet.errors[:user_avatar_url].should_not == [ "can't be blank" ]
      end

      it 'must be a valid URL' do
        tweet.errors[:user_avatar_url].should == [ "is invalid" ]
      end
    end

  end

  describe '#latest_by_location' do

    it 'returns tweets based on geo-cordinates' do
      Tweet.latest_by_location(-77.423456, 42.989259).first.should be_an_instance_of Tweet
    end

  end

end