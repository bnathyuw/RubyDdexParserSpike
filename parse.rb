#!/usr/bin/ruby -w

require 'rexml/document'
require 'date'
include REXML

filename = "UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml"
isrc = "NLA508028306"
territory_code = "AU"

xmlfile = File.new(filename)
xmldoc = Document.new(xmlfile)


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

release_display_title = XPath.first(release, "ReleaseDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText/text()")

release_date = XPath.first(release, 
						   "ReleaseDetailsByTerritory[TerritoryCode=$territory_code]/ReleaseDate/text()", 
						   {}, 
						   {"territory_code"=>territory_code})

puts "Release #{isrc}: #{release_display_title}"
puts "Released on #{release_date} in #{territory_code}"

deals = XPath.match(xmldoc, 
					"//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]", 
					{}, 
					{"release_reference"=>release_reference, "territory_code"=>territory_code})

deals.each do |deal|
	commercial_model_type = XPath.first(deal, "DealTerms/CommercialModelType/text()")
	deal_start_date = XPath.first(deal, "DealTerms/ValidityPeriod/StartDate/text()")
	puts "Available on #{commercial_model_type} from #{deal_start_date}"
end