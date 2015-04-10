#!/usr/bin/ruby -w

require 'rexml/document'
require './lib/release'
require './lib/deal'
include REXML

class DdexReader
    def read_resource_reference_by_isrc(isrc)
        query = "//SoundRecording[SoundRecordingId/ISRC/.=$isrc]/ResourceReference/text()"
        variables = {
        	"isrc" => isrc
        }
        XPath.first(@xmldoc, query, {}, variables)
	end

	def read_track_release(isrc, territory_code)
		resource_reference = read_resource_reference_by_isrc(isrc)
		
		query = "//Release[not(@IsMainRelease='true') and ReleaseResourceReferenceList/ReleaseResourceReference/.=$resource_reference]"
		variables = {
			"resource_reference" => resource_reference
		}
		release_node = XPath.first(@xmldoc, query, {}, variables)

		Release.new(release_node, territory_code)
	end

	def read_deals(release_reference, territory_code)
		query = "//ReleaseDeal[DealReleaseReference/.=$release_reference]/Deal[DealTerms/TerritoryCode/.=$territory_code]"
		variables = {
			"release_reference" => release_reference,
			"territory_code" => territory_code
		}
		XPath.match(@xmldoc, query, {}, variables).map { |x| Deal.new(x) }
	end

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
