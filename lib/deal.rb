#!/usr/bin/ruby -w

require 'rexml/document'
include REXML

class Deal
	def Deal.from(node)
		if node == nil then NilDeal.new else Deal.new(node) end
	end

	def available?
		true
	end

	def price
		XPath.first(@node, "DealTerms/PriceInformation/PriceType/text()")
	end

	def initialize(node)
		@node = node
	end
end

class NilDeal
	def available?
		false
	end

	def price
	end
end