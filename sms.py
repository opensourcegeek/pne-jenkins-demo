from os import environ
import sys

from twilio.rest import TwilioRestClient


# get the twillio deets
try:
    account = environ['TWILIO_ACCOUNT']
    token = environ['TWILIO_TOKEN']
except KeyError:
    # fail with error and exit
    print 'TWILIO_ACCOUNT/ TWILIO_TOKEN is not set, please export it'
    sys.exit()

# the recipient
RECIPIENT = '+447834538884'

# make the client and send the sms
client = TwilioRestClient(account, token)

message = client.messages.create(
    to=RECIPIENT,
    from_='+44 191 328 0601',
    body='Hello; looks like the source was updated')
