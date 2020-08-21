require_relative 'Calendar'

def add
	puts "Date of event:"
	puts "year(YYYY) =>".yellow
	y=gets.chomp
	puts "month(MM)=>".yellow
	m=gets.chomp
	puts "day(DD)=>".yellow
	d=gets.chomp
	str= %Q(#{y}-#{m}-#{d})
	puts "Name :".yellow
	name=gets.chomp.downcase
	puts "Description (optional) :".yellow
	description=gets.chomp
	if (!name.empty? && str=~/^\d{4}\-\d{1,2}\-\d{1,2}$/)
		Calendar.add_event(Date.strptime(str,"%Y-%m-%d") ,name,description) 
	else
		puts "Invalid Input!".red
	end
end

def edit
	puts "Date of event:"
	puts "year(YYYY) =>".yellow
	y=gets.chomp
	puts "month(MM)=>".yellow
	m=gets.chomp
	puts "day(DD)=>".yellow
	d=gets.chomp
	str= %Q(#{y}-#{m}-#{d})
	puts "Name :".yellow
	name=gets.chomp.downcase
	puts "Description (optional) :".yellow
	description=gets.chomp
	if (!name.empty? && str=~/^\d{4}\-\d{1,2}\-\d{1,2}$/)
		Calendar.edit_event(Date.strptime(str,"%Y-%m-%d") ,name,description) 
	else
		puts "Invalid Input!".red
	end
end

def delete
	puts "Date of event:"
	puts "year(YYYY) =>".yellow
	y=gets.chomp
	puts "month(MM)=>".yellow
	m=gets.chomp
	puts "day(DD)=>".yellow
	d=gets.chomp
	str= %Q(#{y}-#{m}-#{d})
	puts "Name :".yellow
	name=gets.chomp.downcase
	if (!name.empty? && str=~/^\d{4}\-\d{1,2}\-\d{1,2}$/)
			Calendar.delete_event(Date.strptime(str,"%Y-%m-%d") ,name)
	else
		puts "Invalid Input!".red
	end
end

def month_event
	puts "Enter Month Number (MM):"
	y=gets.chomp
	if y.to_i.between?(1,12) 
		Calendar.display_month_event(y.to_i)
	else
		puts "Invalid Month number!".red
	end
end

def day_event
	puts "Date of event:"
	puts "year(YYYY) =>".yellow
	y=gets.chomp
	puts "month(MM)=>".yellow
	m=gets.chomp
	puts "day(DD)=>".yellow
	d=gets.chomp
	str= %Q(#{y}-#{m}-#{d})
	if str=~/^\d{4}\-\d{1,2}\-\d{1,2}$/
		Calendar.display_event(Date.strptime(str,"%Y-%m-%d")) 
	else
		puts "Invalid Input!".red
	end
end

def display_driver
	puts "Choose Actions:".yellow
	puts "A=> Add Event\tD=> Delete Event\nE=> Edit Event\tM=> All events of month\nS=> Events on a specific date\nX=> Exit\n ".yellow
	print "Input: "
	gets.chomp.capitalize 
end

def driver
	while true
		Calendar.display_calender
		input=display_driver
		case input
		when "A" 
			add
		when "D"
			delete
		when "E" 
			edit
		when "M" 
			month_event
		when "S" 
			day_event
		when "X" 
			break
		else 
			puts "INVALID INPUT! \"#{input}\"".red
		end
	end
end
driver
