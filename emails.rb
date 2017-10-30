class Emails

  # Line 69 is optional based on whether or not a hire is going through the
  # engineering curriculum. I think I need to set up a boolean for that value
  # in app.rb which determine how a lot of the variables perform:

  #variables determined by eng non-eng
  # handbook_link
  # pre_arrival_link
  # dev_env


  #variables pulled directly from csv array
  # buddy_name
  # manager_name
  # pre_start_fri
  # pre_start_thurs

  #static variables
  #agenda_link
  #onboarding_guide

  # ?? variables
  # sender_email
  # manager_email

  def self.manager_email(hire_full, hire_first, manager_name, team_name, start_date, manager_deadline, days_until_start, is_eng, takes_uf, takes_sales)

    if is_eng == true
      buddy_type = 'mentor'
    else
      buddy_type = 'spin-up buddy'
    end

    if takes_uf == true && takes_sales != true
       training_type = 'Stripe 101 and Users First curriculum'
       onboarding_length = 'two weeks'
    end

    if takes_uf == true && takes_sales == true
       training_type = 'Stripe 101, Users First, and Sales curriculum'
       onboarding_length = 'three weeks'
    end

    if takes_uf != true && takes_sales != true
       training_type = 'Stripe 101'
       onboarding_length = '10 days'
    end

    ## html is just text put link tag

# <<~HEREDOC
#
# <html><body>Sup!</body></html>
#
# HEREDOC

 <<~HEREDOC
<html>
<body>
    <p>Hi #{manager_name}!</p>

    <p>#{hire_full} joins #{team_name} in #{days_until_start} days. As #{hire_first}'s manager, please
    head to the <a href="https://go/onboarding-hub">Onboarding Hub</a> and complete the following actions in the Class of #{start_date} tab by EOD.</p>

    <p><b>ACTIONS</b>
    <ol>
    <li>Verify #{hire_first}’s team, role, manager information for accuracy (Columns H-I)</li>
    <li>Enter the name of #{hire_first}’s #{buddy_type} (Column J-K)</li>
    <li>Enter seating notes, if any, for John Dura (Column R)</li>
    </ol></p>

    <p>Please complete all tasks by #{manager_deadline}.</p>

    <p><b>CURRICULUM</b>
    <br>As a member of the #{team_name}, Education is anticipating that #{hire_first}
    will attend #{training_type} for a total of #{onboarding_length} in training.
    If you are expecting a different onboarding timeline, please reach out to us!</p>

    <p><b>MANAGER GUIDE</b>
    <br>To gain greater visibility into the onboarding process, trying leafing
    through our <a href="https://hackpad.corp.stripe.com/Onboarding-Guide-for-Managers-zKNB9yFmeos">Manager Guide</a></p>

    <p>Thanks for the help!</p>

    <p>-Education</p>
    </body>
   </html>
HEREDOC
  end
end
