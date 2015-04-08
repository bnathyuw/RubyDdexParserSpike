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
	def commercial_model_type
		XPath.first(@node, "DealTerms/CommercialModelType/text()")
	end

	def start_date
		XPath.first(@node, "DealTerms/ValidityPeriod/StartDate/text()")
	end
	
	def initialize(node)
		@node = node
	end
end

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

track = Track.new(xmldoc, isrc, territory_code)

puts "Release #{isrc}: #{track.display_title}"
puts "Released on #{track.release_date} in #{territory_code}"

track.deals.each do |deal|
	puts "Available on #{deal.commercial_model_type} from #{deal.start_date}"
end