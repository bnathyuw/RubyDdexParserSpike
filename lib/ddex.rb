#!/usr/bin/ruby -w

require 'rexml/document'
require './lib/track'
include REXML

class Ddex
	def initialize(filename)
		xmlfile = File.new(filename)
		xmldoc = Document.new(xmlfile)
		@ddex_reader = DdexReader.new(xmldoc)
	end

	def read_track(isrc, territory_code)
		Track.new(@ddex_reader, isrc, territory_code)
	end

	def available?(release_reference, territory_code, date)
		@ddex_reader.has_deal?(release_reference, territory_code, date)
	end
end

