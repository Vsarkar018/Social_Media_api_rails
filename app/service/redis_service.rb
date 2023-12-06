class RedisService
  REDIS_CLIENT = Redis.new

  def self.set_key(key,value)
    REDIS_CLIENT.set(key,value.to_json)
    end
  def self.get_key(key)
    value = REDIS_CLIENT.get(key)
    return nil if value.nil?
    JSON.parse(value)
  end

  def self.del_key(key)
    REDIS_CLIENT.del(key)
  end

  def self.set_expiry(key, time)
    REDIS_CLIENT.expire(key,time)
  end

end