require 'json'
require 'net/http'

def webhook(event:, context:)
  event_body_json = JSON.parse(event['body'])
  puts 'GitHub Pull Request Event: ' + event_body_json['action']
  if event_body_json['action'] == 'review_requested'

    phone_book = {
      # 'github-username' => 'phone number'
    }

    requested_reviewers = event_body_json['pull_request']['requested_reviewers']
    requested_reviewers.each do |reviewers|
      reviewer =  reviewers['login']

      uri_string = 'https://api.twilio.com/2010-04-01/Accounts/' + ENV['TWILIO_ACCOUNT_SID'] + '/Calls.json'

      params = {
        'Twiml' => '
          <Response>
            <Pause/>
            <Say voice="alice">You have a new pull request in Github. Happy April\'s Fool</Say>
            <Play>http://demo.twilio.com/docs/classic.mp3</Play>
          </Response>',
        'To' => phone_book[reviewer],
        'From' => ENV['TWILIO_FROM_NO']
      }

      uri = URI.parse(uri_string)

      request = Net::HTTP::Post.new(uri)
      request.set_form_data(params)
      request.basic_auth(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
        http.request(request)
      end

      puts 'Response Code: ' + response.code
      puts 'Response Body: ' + response.body
    end
  end
  {
    statusCode: 200
  }
end
