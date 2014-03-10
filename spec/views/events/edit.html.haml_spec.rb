require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :url => "MyString",
      :title => "MyString",
      :place => "MyString",
      :address => "MyString",
      :price => 1,
      :capacity => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select "input#event_url[name=?]", "event[url]"
      assert_select "input#event_title[name=?]", "event[title]"
      assert_select "input#event_place[name=?]", "event[place]"
      assert_select "input#event_address[name=?]", "event[address]"
      assert_select "input#event_price[name=?]", "event[price]"
      assert_select "input#event_capacity[name=?]", "event[capacity]"
      assert_select "textarea#event_description[name=?]", "event[description]"
    end
  end
end
