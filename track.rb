#!/usr/bin/ruby -w

require 'rexml/document'
require './release'
require './deal'
include REXML

class Track
	def display_title
		@release.display_title
	end

	def release_date
		@release.release_date
	end

	def deals
		deals = XPath.match(@xmldoc, 
							"//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]", 
							{}, 
							{"release_reference"=>@release.reference, "territory_code"=>@territory_code})
		deals.map { |x| Deal.new(x) }
	end

	def initialize(xmldoc, isrc, territory_code)
		@xmldoc = xmldoc
		@territory_code = territory_code

		resource_reference = XPath.first(xmldoc, 
										 "//SoundRecording[SoundRecordingId/ISRC/.=$isrc]/ResourceReference/text()", 
										 {}, 
										 {"isrc"=>isrc})

		release_node = XPath.first(xmldoc, 
							  "//Release[not(@IsMainRelease='true') and ReleaseResourceReferenceList/ReleaseResourceReference/.=$resource_reference]", 
							  {}, 
							  {"resource_reference"=>resource_reference})

		@release = Release.new(release_node)
	end
end