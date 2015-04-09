#!/usr/bin/ruby -w

require 'rexml/document'
include REXML

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