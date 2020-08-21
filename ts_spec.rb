require_relative 'Calendar'
require 'rspec'
require 'date'
RSpec.describe Calendar do 
	context "when testing Calendar class" do

		it "should display month view when we call display_calendar" do
			check=Calendar.display_calender
			expect(check).to eq true
		end

		it "should raise a error msg when we call delete_event on not existent event" do
			expect { Calendar.delete_event(Date.today+3, "Meeting") }.to output("No Such Event Exists!".red+"\n").to_stdout
		end

		it "should raise a error msg when we call edit_event on not existent event" do
			expect {Calendar.edit_event(Date.today+3, "Meeting", "Monthly family meeting") }.to output("No Such Event Exists!".red+"\n").to_stdout
		end

		it "should raise error msg when we try to display a date with no events" do
			expect { Calendar.display_event(Date.today+3) }.to output("No Event Exist on 2020-08-24!".red+"\n").to_stdout
		end

		it "should raise error msg when we try to display a month with no events" do
			expect { Calendar.display_month_event(8) }.to output("No Event Exist!".red+"\n").to_stdout
		end

		it "should add event on a specific date when we call add_event" do
			expect {Calendar.add_event(Date.today+3, "Meeting", "Monthly family meeting") }.to output("Added Event: Meeting=>  Monthly family meeting".blue+"\n").to_stdout
		end
		
		it "should raise a error msg when we try to create duplicate" do
			expect {Calendar.add_event(Date.today+3, "Meeting", "Monthly family meeting") }.to output("Events with name \"Meeting\" already exixts".red+"\n").to_stdout
		end

		it "should add event on a specific date which already have a different event" do
			expect {Calendar.add_event(Date.today+3, "Birthday", "Aleena Birthday") }.to output("Added Event: Birthday=>  Aleena Birthday".blue+"\n").to_stdout
		end

		it "should display all events of a specific date when we call display_event" do
			expect { Calendar.display_event(Date.today+3) }.to output("Events on 2020-08-24: ".blue+"\n"+"Meeting=> Monthly family meeting"+"\n"+"Birthday=> Aleena Birthday"+"\n").to_stdout
		end

		it "should display all events of a month when we call display_month_event" do
			expect { Calendar.display_month_event(8) }.to output("Events in August: ".blue+"\n"+"2020-08-24".yellow+":\n"+"Meeting => Monthly family meeting"+"\n"+"Birthday => Aleena Birthday"+"\n").to_stdout
		end

		it "should edit event on a specific date when we call edit_event" do
			expect {Calendar.edit_event(Date.today+3, "Meeting", "Monthly family meeting") }.to output("Edited Event: Meeting=>  Monthly family meeting".blue+"\n").to_stdout
		
		end

		it "should delete event on a specific date when we call delete_event" do
			expect { Calendar.delete_event(Date.today+3, "Meeting") }.to output("Deleted Event: Meeting=>  Monthly family meeting".blue+"\n").to_stdout
		end
				
	end
	
end
