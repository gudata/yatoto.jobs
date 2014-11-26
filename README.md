1. Make free application in heroku

2. Configure environment variables

  export CANDIDATES_EMAILS_TO=ivailo@empowerunited.com
  export CANDIDATES_EMAILS_FROM=ivailo@empowerunited.com
  export GMAIL_SMTP_USER=nelly@empowerunited.com
  export GMAIL_SMTP_PASSWORD=********
  export GMAIL_DOMAIN=empowerunited.com

  heroku config:add CANDIDATES_EMAILS_FROM=$CANDIDATES_EMAILS_FROM
  heroku config:add CANDIDATES_EMAILS_TO=$CANDIDATES_EMAILS_TO
  heroku config:add GMAIL_SMTP_USER=$GMAIL_DOMAIN=$GMAIL_DOMAIN
  heroku config:add GMAIL_SMTP_USER=$GMAIL_SMTP_USER
  heroku config:add GMAIL_SMTP_PASSWORD=$GMAIL_SMTP_PASSWORD

3. Add a job position

  run this command:
  rails g controller designers

  Create some file.html.(slim.erb) file for each screen with number prefix in app/views/designer folder
    example:
      100_welcome.html.slim
      200_what_is_the_distance_to_moon.html.slim
      300_send_contacts.html.slim  * 'send_contacts' is magic word which will trigger the sending by email
      800_thanks.html.slim - optional

  Add in routes
    resources :designers

  Put a link to the new position in homepage.html.slim

  Edit app/controllers/designer_controller.rb
    class DesignerController < ApplicationController
    to become...
    class DesignerController < WizardController

  Make or reuse layout for all the questions/views
    cp administration.html.slim desginer.html.slim

  Optional:
    Put custom CSS/Javascript in
      app/stylesheets/desginer.css.scss
    and don't forget to include it in app/stylesheets/application.css.scss, by adding a new line
      @import "designers";

4. Deploy

  git push heroku
