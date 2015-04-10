#!/usr/bin/ruby -w

require 'rexml/document'
require './lib/ddex_reader'
require './lib/deal'
include REXML

class Ddex
	def initialize(filename)
		xmlfile = File.new(filename)
		xmldoc = Document.new(xmlfile)
		@ddex_reader = DdexReader.new(xmldoc)
	end

	def read_deal(release_reference, deal_type, territory_code, date)
		commercial_model_types = {
			:purchase => "PayAsYouGoModel"
		}
		use_types = {
			:purchase => "PermanentDownload"
		}
		match = @ddex_reader.read_deal(release_reference, commercial_model_types[deal_type], use_types[deal_type], territory_code, date)
		Deal.from(match)
	end
end

