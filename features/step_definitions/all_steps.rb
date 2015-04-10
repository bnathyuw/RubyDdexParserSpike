#!/usr/bin/ruby -w

require './lib/ddex'

Given(/^a release with different release dates for different countries$/) do
	@ddex = Ddex.new("./Ddex/UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml")
	@release_reference = "R1"
end

Given(/^a release with different prices for different countries$/) do
	@ddex = Ddex.new("./Ddex/UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml")
	@release_reference = "R1"
end

When(/^I want to purchase it in ([A-Z]{2}) before it has been released anywhere$/) do |territory_code|
	date = Date.new(2014,4,10)
	@deal = @ddex.read_deal(@release_reference, :purchase, territory_code, date)
end

When(/^I want to purchase it in ([A-Z]{2}) between the release dates$/) do |territory_code|
	date = Date.new(2014,4,12)
	@deal = @ddex.read_deal(@release_reference, :purchase, territory_code, date)
end

When(/^I want to purchase it in ([A-Z]{2}) once it has been released everywhere$/) do |territory_code|
	date = Date.new(2014,4,16)
	@deal = @ddex.read_deal(@release_reference, :purchase, territory_code, date)
end

Then(/^it should be (available|not available)$/) do |expected_input|
	expected_value = expected_input == 'available'
	expect(@deal.available?).to eq(expected_value)
end

Then(/^it should not have a price$/) do
	expect(@deal.price).to be_nil
end

Then(/^its price should be (.*)$/) do |expected_price|
	expect(@deal.price).to eq(expected_price)
end
