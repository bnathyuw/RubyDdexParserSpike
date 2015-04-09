#!/usr/bin/ruby -w

require './lib/ddex'

Given(/^a release with different international release dates$/) do
	@ddex = Ddex.new("./Ddex/UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml")
	@release_reference = "R1"
end

When(/^I ask if it is available in ([A-Z]{2}) (before any release date|after any release date)$/) do |territory_code, date_name|
	date_names = { 
		"before any release date" => Date.new(2014,1,1), 
		"after any release date" => Date.new(2020,1,1) 
	}
	@answer = @ddex.available?(@release_reference, territory_code, date_names[date_name])
end

Then(/^the answer should be (true|false)$/) do |expected_answer|
	expected_value = expected_answer == 'true'
	expect(@answer).to eq(expected_value)
end