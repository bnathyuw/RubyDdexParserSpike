#!/usr/bin/ruby -w

require 'rexml/document'
require 'date'
include REXML

filename = "UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml"
isrc = "NLA508028306"
territory_code = "AU"

xmlfile = File.new(filename)
xmldoc = Document.new(xmlfile)

class Deal
	attr_reader :commercial_model_type
	attr_reader :start_date
	
	def initialize(node)
		@commercial_model_type = XPath.first(node, "DealTerms/CommercialModelType/text()")
		@start_date = XPath.first(node, "DealTerms/ValidityPeriod/StartDate/text()")
	end
end

class Track
	attr_reader :display_title
	attr_reader :release_date
	attr_reader :deals

	def initialize(xmldoc, isrc, territory_code)
		sound_recording = XPath.first(xmldoc, 
									  "//SoundRecording[SoundRecordingId/ISRC/.=$isrc]", 
									  {}, 
									  {"isrc"=>isrc})

		resource_reference = XPath.first(sound_recording, "ResourceReference/text()")

		release = XPath.first(xmldoc, 
							  "//Release[not(@IsMainRelease='true') and ReleaseResourceReferenceList/ReleaseResourceReference/.=$resource_reference]", 
							  {}, 
							  {"resource_reference"=>resource_reference})

		release_reference = XPath.first(release, "ReleaseReference/text()")

		@display_title = XPath.first(release, "ReleaseDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText/text()")

		@release_date = XPath.first(release, 
									"ReleaseDetailsByTerritory[TerritoryCode=$territory_code]/ReleaseDate/text()", 
									{}, 
									{"territory_code"=>territory_code})

		deals = XPath.match(xmldoc, 
							 "//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]", 
							 {}, 
							 {"release_reference"=>release_reference, "territory_code"=>territory_code})

		@deals = deals.map { |x| Deal.new(x) }
	end
end

track = Track.new(xmldoc, isrc, territory_code)

puts "Release #{isrc}: #{track.display_title}"
puts "Released on #{track.release_date} in #{territory_code}"

track.deals.each do |deal|
	puts "Available on #{deal.commercial_model_type} from #{deal.start_date}"
end