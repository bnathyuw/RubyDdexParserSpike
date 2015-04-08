#!/usr/bin/ruby -w

require 'rexml/document'
require './track'
include REXML

class Ddex
	def initialize(filename)
		xmlfile = File.new(filename)
		@xmldoc = Document.new(xmlfile)
	end

	def read_track(isrc, territory_code)
		Track.new(@xmldoc, isrc, territory_code)
	end
end

