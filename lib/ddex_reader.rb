#!/usr/bin/ruby -w

require 'rexml/document'
include REXML

class DdexReader
    def has_deal?(release_reference, commercial_model_type, use_type, territory_code, date)
		query = "//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal/DealTerms[CommercialModelType/.=$commercial_model_type and Usage/UseType/.=$use_type and TerritoryCode/.=$territory_code and translate(ValidityPeriod/StartDate/., '-', '') <= translate($date, '-', '')]"
		variables = {
			"commercial_model_type" => commercial_model_type,
			"use_type" => use_type,
			"release_reference" => release_reference,
			"territory_code" => territory_code,
			"date" => date.to_s
		}
		matches = XPath.match(@xmldoc, query, {}, variables)
		matches.any?
	end

	def read_price(release_reference, commercial_model_type, use_type, territory_code, date)
		query = "//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal/DealTerms[CommercialModelType/.=$commercial_model_type and Usage/UseType/.=$use_type and TerritoryCode/.=$territory_code and translate(ValidityPeriod/StartDate/., '-', '') <= translate($date, '-', '')]/PriceInformation/PriceType/text()"
		variables = {
			"commercial_model_type" => commercial_model_type,
			"use_type" => use_type,
			"release_reference" => release_reference,
			"territory_code" => territory_code,
			"date" => date.to_s
		}
		XPath.first(@xmldoc, query, {}, variables)
	end

	def initialize(xmldoc)
		@xmldoc = xmldoc
	end
end
