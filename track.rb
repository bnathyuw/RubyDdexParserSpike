#!/usr/bin/ruby -w

require 'rexml/document'
require './deal'
include REXML

class Track
	def display_title
		XPath.first(@release, "ReleaseDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText/text()")
	end

	def release_date
		XPath.first(@release, 
					"ReleaseDetailsByTerritory[TerritoryCode=$territory_code]/ReleaseDate/text()", 
					{}, 
					{"territory_code"=>@territory_code})
	end

	def deals
		deals = XPath.match(@xmldoc, 
							"//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]", 
							{}, 
							{"release_reference"=>@release_reference, "territory_code"=>@territory_code})
		deals.map { |x| Deal.new(x) }
	end

	def initialize(xmldoc, isrc, territory_code)
		@xmldoc = xmldoc
		@territory_code = territory_code

		resource_reference = XPath.first(xmldoc, 
										 "//SoundRecording[SoundRecordingId/ISRC/.=$isrc]/ResourceReference/text()", 
										 {}, 
										 {"isrc"=>isrc})

		@release = XPath.first(xmldoc, 
							  "//Release[not(@IsMainRelease='true') and ReleaseResourceReferenceList/ReleaseResourceReference/.=$resource_reference]", 
							  {}, 
							  {"resource_reference"=>resource_reference})

		@release_reference = XPath.first(@release, "ReleaseReference/text()")
	end
end