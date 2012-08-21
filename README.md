# Fog::AWS:DynamoDB::Locker

This is an attempt to use DynamoDB as a lock store.

We don't have a 'Locks as a Service' thing yet, so this is an experiment to make the best of what we do have.

Would love to hear of any use of this or if you think it is just a terrible idea to begin with.

Inspired by the simplicity of [sequel-pg-locker](https://github.com/dylanegan/sequel-pg-locker) by [@dylanegan](https://github.com/dylanegan).

## Installation

Add this line to your application's Gemfile:

    gem 'fog-aws-dynamodb-locker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog-aws-dynamodb-locker

## Usage

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export DYNAMODB_LOCK_TABLE='my-lock-table'
```

```ruby
require 'fog/aws/dynamodb/locker'

# first run only
Fog::AWS::DynamoDB::Locker.init!

# create a lock
Fog::AWS::DynamoDB::Locker.lock!('my lock')
# => true

# try to claim it a second time
Fog::AWS::DynamoDB::Locker.lock!('my lock')
# => false

# release it
Fog::AWS::DynamoDB::Locker.release!('my lock')
# => true
```

## TODO

* real specs
* set a timestamp on each lock
* allow metadata on each lock
* `Fog::AWS::DynamoDB::Locker.sweep!(n)` to remove all locks that are `n` old

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
