#!/usr/bin/ruby -w

module Dates
	def Dates.find(name)
		case name
		when "before it has been released anywhere"
			Date.new(2014,4,10)
		when "between the release dates"
			Date.new(2014,4,12)
		when "once it has been released everywhere"
			Date.new(2014,4,16)
		end
	end
end