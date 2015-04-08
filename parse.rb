#!/usr/bin/ruby -w

require 'rexml/document'
include REXML

xmlfile = File.new("UMG_DDEX_metadata_7digital_(MP3)_new_00028947871477_2014-03-31_10-33-54.xml")
xmldoc = Document.new(xmlfile)

isrc = "NLA508028306"

XPath.each(xmldoc, "//SoundRecording[SoundRecordingId/ISRC/.='#{isrc}']/SoundRecordingDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText"){ |e| puts e.text }

territory_code = "GB"