# DeployStatus

## Installation

Add this line to your application's Gemfile:

    gem 'deploy_status'

And then execute:

    $ bundle

## Usage

Mount the app in your config/routes.rb file:

    mount DeployStatus::Server, at: "deploy_status"

Add to config/deploy.rm:
    
    after 'deploy:finished', 'deploy:set_current_version'
    
To print out the curren version, invove the status task:
    invoke 'deploy:status'

## Contributing

1. Fork it ( http://github.com/mwq/deploy_status/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
