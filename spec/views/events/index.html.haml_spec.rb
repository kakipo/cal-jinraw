require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :url => "Url",
        :title => "Title",
        :place => "Place",
        :address => "Address",
        :price => 1,
        :capacity => 2,
        :description => "MyText"
      ),
      stub_model(Event,
        :url => "Url",
        :title => "Title",
        :place => "Place",
        :address => "Address",
        :price => 1,
        :capacity => 2,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
