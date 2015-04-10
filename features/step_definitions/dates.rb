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

		when "long before the first deal starts"
			Date.new(2013,1,1)
		when "on the day before the first deal starts"
			Date.new(2013,6,17)
		when "on the day the first deal starts"
			Date.new(2013,6,18)
		when "on the last day of the first deal"
			Date.new(2013,9,1)
		when "on the day the second deal starts"
			Date.new(2013,9,2)
		when "long after the second deal starts"
			Date.new(2013,12,31)
		end
	end
end