#!/usr/bin/ruby -w

require 'rexml/document'
require './track'
include REXML

filename = "UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml"
isrc = "NLA508028306"
territory_code = "AU"

xmlfile = File.new(filename)
xmldoc = Document.new(xmlfile)

track = Track.new(xmldoc, isrc, territory_code)

puts "Release #{isrc}: #{track.display_title}"
puts "Released on #{track.release_date} in #{territory_code}"

track.deals.each do |deal|
	puts "Available on #{deal.commercial_model_type} from #{deal.start_date}"
end