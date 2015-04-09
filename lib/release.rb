#!/usr/bin/ruby -w

require 'rexml/document'
require './lib/deal'
include REXML

class Release
	def display_title
		XPath.first(@node, "ReleaseDetailsByTerritory/Title[@TitleType='DisplayTitle']/TitleText/text()")
	end

	def release_date
		query = "ReleaseDetailsByTerritory[TerritoryCode=$territory_code]/ReleaseDate/text()"
		variables = {
			"territory_code" => @territory_code
		}
		XPath.first(@node, query, {}, variables)
	end

	def reference
		XPath.first(@node, "ReleaseReference/text()")
	end

	def initialize(node, territory_code)
		@node = node
		@territory_code = territory_code
	end
end
