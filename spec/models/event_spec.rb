# coding: utf-8
require 'spec_helper'

describe Event do
  it "should have valid factory." do
    FactoryGirl.build(:event).should be_valid
  end

  # describe "relationship" do
  #   it { should have_many(:user_companies).of_type(Userevent) }
  # end

  describe "methods" do
    before do
      @event = FactoryGirl.build(:event)
    end

    describe "#is_holiday?" do
      subject { @event.is_holiday? }
      before { @event.start_at = mod_start_at }

      context "when it is weekday (Monday)" do
        let(:mod_start_at) { DateTime.new(2014,3,10) }
        it { should be_false }
      end

      context "when it is holiday (Saturday)" do
        let(:mod_start_at) { DateTime.new(2014,3,15) }
        it { should be_true }
      end

      context "when it is holiday (Sunday)" do
        let(:mod_start_at) { DateTime.new(2014,3,16) }
        it { should be_true }
      end

      context "when it is holiday (National Holiday)" do
        let(:mod_start_at) { DateTime.new(2014,3,21) }
        it { should be_true }
      end
    end

    describe "#is_allnight?" do
      subject { @event.is_allnight? }
      before do 
        @event.start_at = mod_start_at 
        @event.end_at = mod_end_at 
      end

      context "when end_at is blank" do
        let(:mod_start_at) { DateTime.new(2014,3,10,15,30,50) }
        let(:mod_end_at) { nil }
        it { should be_false }
      end

      context "when it starts at afternoon and ends at night" do
        let(:mod_start_at) { DateTime.new(2014,3,10,13,30,50) }
        let(:mod_end_at) { DateTime.new(2014,3,10,19,30,50) }
        it { should be_true }
      end

      context "when over a day" do
        let(:mod_start_at) { DateTime.new(2014,3,10,15,30,50) }
        let(:mod_end_at) { DateTime.new(2014,3,11,0,0,0) }
        it { should be_true }
      end

      context "when over a day" do
        let(:mod_start_at) { DateTime.new(2014,3,10,15,30,50) }
        let(:mod_end_at) { DateTime.new(2014,3,11,0,0,0) }
        it { should be_true }
      end

      context "when it starts at midninght" do
        let(:mod_start_at) { DateTime.new(2014,3,10,2,30,50) }
        let(:mod_end_at) { DateTime.new(2014,3,10,7,30,0) }
        it { should be_true }
      end

    end

  end

  describe "properties" do
    before do
      @event = FactoryGirl.build(:event)
    end

    subject { @event }

    describe "url" do
      before { @event.url = mod_url }
      context "when it is empty" do
        let(:mod_url) { "" }
        it { should_not be_valid }
      end
      context "when it is INVALID format" do
        let(:mod_url) { "abc" }
        it { should_not be_valid }
      end
      context "when it is VALID format" do
        let(:mod_url) { "http://hoge.com" }
        it { should be_valid }
      end
    end

    describe "title" do
      before { @event.title = mod_title }
      context "when it is empty" do
        let(:mod_title) { "" }
        it { should_not be_valid }
      end
      context "when its legnth is MAX" do
        let(:mod_title) { "a" * 30 }
        it { should be_valid }
      end
      context "when its length is TOO LONG" do
        let(:mod_title) { "a" * 31 }
        it { should_not be_valid }
      end
    end

    describe "start_at" do
      before { @event.start_at = mod_start_at }
      context "when it is empty" do
        let(:mod_start_at) { nil }
        it { should_not be_valid }
      end
      context "when it is TOO EARLY" do
        let(:mod_start_at) { DateTime.new(1984,7,22) }
        it { should_not be_valid }
      end
      context "when it MIN" do
        let(:mod_start_at) { DateTime.new(1984,7,23) }
        it { should be_valid }
      end
      context "when is VALID value" do
        let(:mod_start_at) { DateTime.now }
        it { should be_valid }
      end
      context "when it is TOO AFTER" do
        let(:mod_start_at) { DateTime.new(2084,7,24) }
        it { should_not be_valid }
      end
      context "when it MAX" do
        let(:mod_start_at) { DateTime.new(2084,7,23) - 1.day }
        it { should be_valid }
      end
    end

    describe "end_at" do
      before do 
        @event.start_at = DateTime.now
        @event.end_at = mod_end_at 
      end
      context "when it is empty" do
        let(:mod_end_at) { nil }
        it { should be_valid }
      end
      context "when it is BEFORE start_at" do
        let(:mod_end_at) { @event.start_at - 1.hour }
        it { should_not be_valid }
      end
      context "when is SAME as start_at" do
        let(:mod_end_at) { @event.start_at }
        it { should be_valid }
      end
      context "when is AFTER start_at" do
        let(:mod_end_at) { @event.start_at + 1.hour }
        it { should be_valid }
      end
    end


    describe "place" do
      before { @event.place = mod_place }
      context "when it is empty" do
        let(:mod_place) { "" }
        it { should_not be_valid }
      end
      context "when its legnth is MAX" do
        let(:mod_place) { "a" * 50 }
        it { should be_valid }
      end
      context "when its length is TOO LONG" do
        let(:mod_place) { "a" * 51 }
        it { should_not be_valid }
      end
    end

    describe "prefecture" do
      before { @event.prefecture = mod_prefecture }
      context "when it is empty" do
        let(:mod_prefecture) { nil }
        it { should_not be_valid }
      end
    end

    describe "address" do
      before { @event.address = mod_address }
      context "when it is empty" do
        let(:mod_address) { "" }
        it { should_not be_valid }
      end
      context "when its legnth is MAX" do
        let(:mod_address) { "a" * 100 }
        it { should be_valid }
      end
      context "when its length is TOO LONG" do
        let(:mod_address) { "a" * 101 }
        it { should_not be_valid }
      end
    end

    describe "price" do
      before { @event.price = mod_price }
      context "when it is empty" do
        let(:mod_price) { nil }
        it { should_not be_valid }
      end
      context "when its value is MAX" do
        let(:mod_price) { 999999 }
        it { should be_valid }
      end
      context "when its value is TOO BIG" do
        let(:mod_price) { 1000000 }
        it { should_not be_valid }
      end
      context "when its value is MIN" do
        let(:mod_price) { 0 }
        it { should be_valid }
      end
      context "when its value is TOO SMALL" do
        let(:mod_price) { -1 }
        it { should_not be_valid }
      end
      context "when its value is NOT integer" do
        let(:mod_price) { 9.99 }
        it { should_not be_valid }
      end
    end

    describe "capacity" do
      before { @event.capacity = mod_capacity }
      context "when it is empty" do
        let(:mod_capacity) { nil }
        it { should_not be_valid }
      end
      context "when its value is MAX" do
        let(:mod_capacity) { 999 }
        it { should be_valid }
      end
      context "when its value is TOO BIG" do
        let(:mod_capacity) { 1000 }
        it { should_not be_valid }
      end
      context "when its value is MIN" do
        let(:mod_capacity) { 1 }
        it { should be_valid }
      end
      context "when its value is TOO SMALL" do
        let(:mod_capacity) { 0 }
        it { should_not be_valid }
      end
      context "when its value is NOT integer" do
        let(:mod_capacity) { 9.99 }
        it { should_not be_valid }
      end
    end

  end

end
