#!/usr/bin/ruby -w

require 'rexml/document'
require './lib/ddex_reader'
include REXML

class Ddex
	def initialize(filename)
		xmlfile = File.new(filename)
		xmldoc = Document.new(xmlfile)
		@ddex_reader = DdexReader.new(xmldoc)
	end

	def available?(release_reference, deal_type, territory_code, date)
		commercial_model_types = {
			:purchase => "PayAsYouGoModel"
		}
		use_types = {
			:purchase => "PermanentDownload"
		}
		deal = @ddex_reader.read_deal(release_reference, commercial_model_types[deal_type], use_types[deal_type], territory_code, date)
		return deal != nil
	end

	def read_price(release_reference, deal_type, territory_code, date)
		commercial_model_types = {
			:purchase => "PayAsYouGoModel"
		}
		use_types = {
			:purchase => "PermanentDownload"
		}
		@ddex_reader.read_price(release_reference, commercial_model_types[deal_type], use_types[deal_type], territory_code, date)
	end
end

