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

When(/^I ask if it is available to purchase in ([A-Z]{2}) before it has been released anywhere$/) do |territory_code|
	date = Date.new(2014,4,10)
	@answer = @ddex.available?(@release_reference, :purchase, territory_code, date)
end

When(/^I ask if it is available to purchase in ([A-Z]{2}) between the release dates$/) do |territory_code|
	date = Date.new(2014,4,12)
	@answer = @ddex.available?(@release_reference, :purchase, territory_code, date)
end

When(/^I ask if it is available to purchase in ([A-Z]{2}) once it has been released everywhere$/) do |territory_code|
	date = Date.new(2014,4,16)
	@answer = @ddex.available?(@release_reference, :purchase, territory_code, date)
end

When(/^I ask for the purchase price in ([A-Z]{2}) before it has been released anywhere$/) do |territory_code|
    date = Date.new(2014,4,10)
	@answer = @ddex.read_price(@release_reference, :purchase, territory_code, date)
end

When(/^I ask for the purchase price in ([A-Z]{2}) once it has been released everywhere$/) do |territory_code|
	date = Date.new(2014,4,16)
	@answer = @ddex.read_price(@release_reference, :purchase, territory_code, date)
end

Then(/^the answer should be (true|false)$/) do |expected_answer|
	expected_value = expected_answer == 'true'
	expect(@answer).to eq(expected_value)
end

Then(/^I should not get a price$/) do
	expect(@answer).to be_nil
end

Then(/^the price should be (.*)$/) do |expected_price|
	expect(@answer).to eq(expected_price)
end
