class UserToken
  class InvalidToken < StandardError; end

  def self.default
    new(Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.generate(user, expire_in)
    default.generate(user, expire_in)
  end

  def self.authenticate(token)
    default.authenticate(token)
  end

  def initialize(salt, algorithm)
    @salt, @algorithm = salt, algorithm
  end

  def authenticate(token)
    data, _ = *JWT.decode(token, @salt, @algorithm)
    User.find(data['data'])
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    raise InvalidToken, e
  end

  def generate(user, expire_in)
    data = {:data => user.id}
    data[:exp] = (Time.now.to_i + expire_in) if expire_in

    JWT.encode(data, @salt, @algorithm)
  end
end
