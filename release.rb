#!/usr/bin/ruby -w

require 'rexml/document'
require './deal'
include REXML

class Release
	def display_title
		XPath.first(@node, "ReleaseDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText/text()")
	end

	def release_date
		XPath.first(@node, 
					"ReleaseDetailsByTerritory[TerritoryCode=$territory_code]/ReleaseDate/text()", 
					{}, 
					{"territory_code"=>@territory_code})
	end

	def reference
		XPath.first(@node, "ReleaseReference/text()")
	end

	def initialize(node)
		@node = node
	end
end