class RedisService
  REDIS_CLIENT = Redis.new

  def self.set_key(key,value)
    REDIS_CLIENT.set(key,value.to_json)
    end
  def self.get_key(key)
    REDIS_CLIENT.get(key)
  end

  def self.del_key(key)
    REDIS_CLIENT.del(key)
  end
end