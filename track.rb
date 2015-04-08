#!/usr/bin/ruby -w

require 'rexml/document'
require './ddex_reader'
include REXML

class Track
	def display_title
		@release.display_title
	end

	def release_date
		@release.release_date
	end

	def deals
		@ddex_reader.read_deals(@release.reference, @territory_code)
	end

	def initialize(ddex_reader, isrc, territory_code)
		@territory_code = territory_code

		@ddex_reader = ddex_reader

		@release = @ddex_reader.read_release(isrc, territory_code)
	end
end