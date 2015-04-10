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

	def available?(release_reference, deal_type, territory_code, date)
		commercial_model_types = {
			:purchase => "PayAsYouGoModel"
		}
		use_types = {
			:purchase => "PermanentDownload"
		}
		@ddex_reader.has_deal?(release_reference, commercial_model_types[deal_type], use_types[deal_type], territory_code, date)
	end
end

