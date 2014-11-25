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
  Make a controller app/controllers
  Make a views folter app/views/your_controller
  Make an html.slim file for each screen with number prefix
    100_welcome...
    200_what_is_the_distance_to_moon
    300_send_contacts - 'send_contacts' is magic word which will trigger the sending by email
    800_thanks - optional


4. Deploy

  git push heroku
