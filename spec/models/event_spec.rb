# coding: utf-8
require 'spec_helper'

describe Event do
  it "should have valid factory." do
    FactoryGirl.build(:event).should be_valid
  end

  # describe "relationship" do
  #   it { should have_many(:user_companies).of_type(Userevent) }
  # end

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

    describe "event_date" do
      before { @event.event_date = mod_event_date }
      context "when it is empty" do
        let(:mod_event_date) { nil }
        it { should_not be_valid }
      end
      context "when is is yesterday" do
        let(:mod_event_date) { Date.yesterday }
        it { should_not be_valid }
      end
      context "when is today" do
        let(:mod_event_date) { Date.today }
        it { should be_valid }
      end
      context "when is tomorrow" do
        let(:mod_event_date) { Date.tomorrow }
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
