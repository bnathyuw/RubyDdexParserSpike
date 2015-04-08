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

	def initialize(xmldoc, isrc, territory_code)
		@xmldoc = xmldoc
		@territory_code = territory_code

		@ddex_reader = DdexReader.new(xmldoc)

		@release = @ddex_reader.read_release(isrc)
	end
end