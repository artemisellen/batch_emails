require 'CSV'
require 'pry'
require_relative 'email_config.rb'
require 'date'
require 'mail'


# What are we doing here?

# 1. Calling method 'read' on CSV class
# 2. Passing file name an arg as a string with an additional parameter arg
# 3. Return array which is assigned to variable class1


class1 = CSV.read('PracticeCSV.csv', headers:true)
class1.each do |row|

#names
  hire_full = row.fetch('Name')
  hire_first = hire_full.split()[0]
  manager_name = row.fetch('Manager').split()[0]
  team_name = row.fetch('Team')

#times
  start_raw = Date.parse(row.fetch('Start Date')).to_date
  start_date = start_raw.strftime("%m/%d")
  deadline_raw = (start_raw - 10)
  manager_deadline = deadline_raw.strftime("%A, %m/%d")
  now = Date.today
  days_until_start = (start_raw - now).to_i

#curriculum rules
  if row.fetch('Eng 101') == 'Yes'
    is_eng = true
  else
    is_eng = false
  end

  if row.fetch('Users First') == 'Yes'
    takes_uf = true
  else
    takes_uf = false
  end

  if row.fetch('Sales') == 'Yes'
    takes_sales = true
  else
    takes_sales = false
  end

#create mail object and send
mail = Mail.new
mail.subject = "[action needed] Onboarding #{hire_full}"
mail.to = row.fetch('Manager Email')
mail.from = '"Artemis Jenkins" <$SENDER_ADDRESS>'
mail.body = Emails.manager_email(hire_full, hire_first, manager_name, team_name, start_date, manager_deadline, days_until_start, takes_uf, takes_sales, is_eng)
mail.charset = "UTF-8"
mail.header['Content-Type'] = 'text/html'
mail.deliver!

end

  # mail = Mail.new
  # mail.subject = "Your Foundations Computer IP"
  # mail.from = "foundations.autodelivery@gmail.com"
  # mail.to = "artemis@stripe.com"
  # mail.body = "hi!"
  # mail.deliver!

# mail = Mail.new do
# ## from '"Artemis" <whateveritis@gmail.com>'
# from '"Artemis Jenkins" <stripefoundations@stripe.com>'
#
# ## add row.fetch('manager email')
# to      row.fetch('Manager Email')
#
# ## variable within the subjects
# subject '#{hire_name} joining your team (#{start_date.strftime("%m/%d")})'
#
# ## want to send return value from line 52
# body    Emails.manager_email(hire_name, manager_name, team_name, start_date, manager_deadline, days_until_start, takes_uf, takes_sales, is_eng)
# end

#binding.pry

# end

## must occur within for each loop



##mail.to_s #=> "From: mikel@test.lindsaar.net\r\nTo: you@...


# #Instantiated the email class and assigned that
# #instantiation to a variable
# #Why instantiations and objects
# #Instance methods
# #Class method (self.manager_email in emails.rb)
#
#
# # #versus: instance method
# #
# # june_email =  Emails.new
# # class1.each do |row|
# #   hire_name = row.fetch('Name')
# # p june_email.manager_email(hire_name)
# # end
