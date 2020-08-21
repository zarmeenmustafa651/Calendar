require 'date'
require 'active_support/core_ext/hash/indifferent_access'
module Event
  def add_event(date, name, description)
  	@event_list||=HashWithIndifferentAccess.new {|d,event| d[event]=HashWithIndifferentAccess.new()}
		if @event_list[date.to_s].length==999
			puts "Events reached max limit".red 
		elsif @event_list[date.to_s].key?(name)
      puts "Events with name \"#{name}\" already exixts" .red
    else
  		@event_list[date.to_s].merge!({name.to_s => description })
  		puts %Q(Added Event: #{name}=>  #{@event_list[date.to_s][name]}).blue
  	end
  end

  def delete_event(date, name)
 		if @event_list != nil && !@event_list[date.to_s].empty? && !@event_list[date.to_s].nil?
	  	puts %Q(Deleted Event: #{name}=>  #{@event_list[date.to_s][name]}).blue 
	  	@event_list[date.to_s].except!(name)
	  else
	  	puts "No Such Event Exists!".red
	  end
  end

  def display_event(date)
    if @event_list !=nil  && !@event_list[date.to_s].empty? && @event_list[date.to_s] !=nil 
    	puts %Q(Events on #{date.to_s}: ).blue
    	puts( @event_list[date.to_s].map{ |n,d| "#{n}=> #{d}" })
    else
      puts "No Event Exist on #{date.to_s}!".red
    end

  end

  def edit_event(date,name,discription)
  	if @event_list !=nil  && !@event_list[date.to_s].empty? && @event_list[date.to_s] !=nil && @event_list[date.to_s].key?(name)
	  	@event_list[date.to_s][name]=discription
	  	puts %Q(Edited Event: #{name}=>  #{@event_list[date.to_s][name]}).blue
  	else
	  	puts "No Such Event Exists!".red
	  end
  end

  def display_month_event(month)
  	
  	if @event_list!=nil 
  		puts %Q(Events in #{Date::MONTHNAMES[month]}: ).blue
	  	@event_list.each do |date,event|  
	  		if date.split("-").values_at(1).join.to_i == month && !@event_list[date.to_s].empty?
	  			puts( %Q(#{date.yellow}:\n#{@event_list[date].map{ |n,d| "#{n} => #{d}\n" }.join}) )
	  		end
	  	end
	  else puts "No Event Exist!".red
	  end
  end

  def event_count(date)
  	if @event_list!=nil && !@event_list[date.to_s].empty?
    	return @event_list[date.to_s].length 
    else 
    	return 0
    end
  end
end