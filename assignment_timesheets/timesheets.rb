
# Employee and his timesheet
# Hourly development rate = $5 per hour
# Hourly interview rate = $3 per hour
# Bonus on work over weekends = (regular weekdays rate + $2) per hour

require 'date'

hash_arr = [
{"name": "Nawab", "logged_hours": 2, "date": "18-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 4, "date": "19-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 3, "date": "20-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 6, "date": "22-07-2021", "type": "interviews"},
{"name": "Nawab", "logged_hours": 1, "date": "24-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 2, "date": "26-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 2, "date": "27-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 3, "date": "28-07-2021", "type": "deveopment"},
{"name": "Nawab", "logged_hours": 4, "date": "29-07-2021", "type": "interviews"},
{"name": "Nawab", "logged_hours": 2, "date": "30-07-2021", "type": "interviews"},
{"name": "Nawab", "logged_hours": 2, "date": "31-07-2021", "type": "interviews"},
{"name": "Nawab", "logged_hours": 5, "date": "31-07-2021", "type": "deveopment"}
]


billing_hours = 0
bonus = 0
int_hours = 0
devp_hours = 0
total_hours = 0

def weekday(date_string)
  Date.parse(date_string).strftime("%A")
end


hash_arr.each do |hash|
  day = weekday (hash[:date])
  total_hours = total_hours + hash[:logged_hours]
  if day == "Saturday" || day == "Sunday"
    if hash[:type] == "deveopment"
  	  billing_hours = billing_hours + hash[:logged_hours] * 5 + 2
  	  bonus = bonus + hash[:logged_hours] * 5 + 2
  	  devp_hours = devp_hours + hash[:logged_hours]
    end

    if hash[:type] == "interviews"
  	  billing_hours = billing_hours + hash[:logged_hours] * 3 + 2
  	  bonus = bonus + hash[:logged_hours] * 3 + 2
  	  int_hours = int_hours + hash[:logged_hours]
    end
  else
    if hash[:type] == "deveopment"
  	  billing_hours = billing_hours + hash[:logged_hours] * 5
  	  devp_hours = devp_hours + hash[:logged_hours]
    end

    if hash[:type] == "interviews"
  	  billing_hours = billing_hours + hash[:logged_hours] * 3
  	  int_hours = int_hours + hash[:logged_hours]
    end
  end
end

puts "Total Billing Hours : #{billing_hours}"

puts "Development Percent in hour : #{((int_hours.to_f/total_hours.to_f)*100).round(2)}"

puts "Interview Percent in hour : #{((devp_hours.to_f/total_hours.to_f)*100).round(2)}"

puts "Total Bonus : #{bonus}"