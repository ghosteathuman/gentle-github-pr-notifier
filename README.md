# Gentle GitHub PR Notifier

Gives a call whenever there is a Pull Request in GitHub requesting for review.

## Getting Ready

1. [Ruby 2.7](https://www.ruby-lang.org/en/downloads/) required.
2. [GitHub](https://https://github.com/) & [Twilio](https://www.twilio.com/) account required.
3. [AWS](https://aws.amazon.com/) account is required for deployment.

## Getting Started
1. Clone this project and ensure that [serverless](https://serverless.com/) is installed.
2. Update the phone book in `handler.rb`.

### Run on AWS
1. Run `$ sls deploy --twilioAccountSid=<twilio account sid> --twilioAuthToken=<twilio auth token> --twilioFromNo=<twilio number to call from>`

Note that `--region` defaults to `us-west-2` unless overridden.
