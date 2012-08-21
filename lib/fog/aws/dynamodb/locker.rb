require 'fog'
require 'fog/aws/dynamodb/locker/version'

module Fog::AWS::DynamoDB::Locker
  extend self

  def connect
    Fog::AWS::DynamoDB.new(aws_access_key_id: env!('AWS_ACCESS_KEY_ID'), aws_secret_access_key: env!('AWS_SECRET_ACCESS_KEY'))
  end

  def db
    @db ||= connect
  end

  def env!(key)
    ENV[key] || raise("Could not find #{key} in ENV")
  end

  def init!(opts={})
    db.create_table(table_name,
                    {:HashKeyElement => {:AttributeName => "id", :AttributeType => "S"}},
                    {:ReadCapacityUnits => 1, :WriteCapacityUnits => 1}.merge(opts))
    true
  end

  def lock!(id, meta_data={})
    begin   
      db.put_item(table_name, {:id => {:S => id}}, {:Expected => {:id => {:Exists => false}}})
    rescue Excon::Errors::BadRequest => e
      if JSON.parse(e.response.body)['__type'] == 'com.amazonaws.dynamodb.v20111205#ConditionalCheckFailedException'
        return false
      else
        raise 
      end
    end
    true
  end

  def release!(id)
    db.delete_item(table_name, {:HashKeyElement => {"S" => id}})
    true
  end

  def table_name
    env!('DYNAMODB_LOCK_TABLE')
  end
end
