require 'date'

class Timesheet
  
  DEVELOPMENT_HOUR_RATE = 5
  INTERVIEW_HOUR_RATE = 3
  BONUS_HOUR_RATE = 2

  TIMESHEETS = [
    {"name": "Nawab", "logged_hours": 2, "date": "18-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 4, "date": "19-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 3, "date": "20-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 6, "date": "22-07-2021", "type": "interviews"},
    {"name": "Nawab", "logged_hours": 1, "date": "24-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 2, "date": "26-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 2, "date": "27-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 3, "date": "28-07-2021", "type": "development"},
    {"name": "Nawab", "logged_hours": 4, "date": "29-07-2021", "type": "interviews"},
    {"name": "Nawab", "logged_hours": 2, "date": "30-07-2021", "type": "interviews"},
    {"name": "Nawab", "logged_hours": 2, "date": "31-07-2021", "type": "interviews"},
    {"name": "Nawab", "logged_hours": 5, "date": "31-07-2021", "type": "development"}
  ]
  
  def total_billing_hours
    total_billing_hours = calculate('total_billing_hours')
    puts "Total Billing Hours : #{total_billing_hours}"
  end

  def total_bonus
    total_bonus = calculate('total_bonus')
    puts "Total Bonus : #{total_bonus}"   
  end

  def percent_of_devlopment
    hours = calculate('percent_of_devlopment')
    percent_of_devlopment = ((hours[1].to_f / hours[0].to_f)*100).round(2)
    puts "Development Percent in hour : #{percent_of_devlopment}"
  end

  def percent_of_interview
    hours = calculate('percent_of_interview')
    percent_of_interview = ((hours[1].to_f / hours[0].to_f)*100).round(2)
    puts "Interview Percent in hour : #{percent_of_interview}"
  end
  
  private

  def timesheets_group_by
    TIMESHEETS.group_by {|hash| hash[:type]}
  end

  def weekday(date_string)
    Date.parse(date_string).strftime("%A")
  end

  def calculate(type)

    billing_hours = 0
    bonus = 0
    interview_hours = 0
    development_hours = 0
    total_hours = 0

    result = timesheets_group_by

    result['interviews'].each do |hash|
      day = weekday(hash[:date])
      total_hours += hash[:logged_hours]
      interview_hours += hash[:logged_hours]
      if day == "Saturday" || day == "Sunday"
        billing_hours += hash[:logged_hours] * (INTERVIEW_HOUR_RATE + BONUS_HOUR_RATE)
        bonus += hash[:logged_hours] * (INTERVIEW_HOUR_RATE + BONUS_HOUR_RATE)
      else
        billing_hours += hash[:logged_hours] * INTERVIEW_HOUR_RATE
      end
    end

    result['development'].each do |hash|
      day = weekday (hash[:date])
      total_hours += hash[:logged_hours]
      development_hours += hash[:logged_hours]
      if day == "Saturday" || day == "Sunday"
        billing_hours += hash[:logged_hours] * (DEVELOPMENT_HOUR_RATE + BONUS_HOUR_RATE)
        bonus += hash[:logged_hours] * (DEVELOPMENT_HOUR_RATE + BONUS_HOUR_RATE)
      else
        billing_hours += hash[:logged_hours] * DEVELOPMENT_HOUR_RATE
      end
    end

    if type == 'total_billing_hours'
      return billing_hours
    elsif type == 'total_bonus'
      return bonus
    elsif type == 'percent_of_devlopment'
      return total_hours, development_hours
    elsif type == 'percent_of_interview'
      return total_hours, interview_hours
    end 
    
  end

end

obj = Timesheet.new
obj.total_billing_hours
obj.percent_of_devlopment
obj.percent_of_interview
obj.total_bonus