Slack.configure do |config|
	config.token = ENV["SLACK_API_TOKEN"]
	fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

$slack_client = Slack::Web::Client.new
$slack_client.auth_test

puts "=> Slack Client configured"
