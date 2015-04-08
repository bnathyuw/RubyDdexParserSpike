#!/usr/bin/ruby -w

require 'rexml/document'
require './release'
require './deal'
include REXML

class DdexReader
	def read_release(isrc)
		resource_reference = XPath.first(@xmldoc, 
										 "//SoundRecording[SoundRecordingId/ISRC/.=$isrc]/ResourceReference/text()", 
										 {}, 
										 {"isrc"=>isrc})

		release_node = XPath.first(@xmldoc, 
								   "//Release[not(@IsMainRelease='true') and ReleaseResourceReferenceList/ReleaseResourceReference/.=$resource_reference]", 
								   {}, 
								   {"resource_reference"=>resource_reference})

		Release.new(release_node)
	end

	def read_deals(release_reference, territory_code)
		deals = XPath.match(@xmldoc, 
							"//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]", 
							{}, 
							{"release_reference"=>release_reference, "territory_code"=>territory_code})
		deals.map { |x| Deal.new(x) }
	end

	def initialize(xmldoc)
		@xmldoc = xmldoc
	end
end