class Transaction# transaction log
  include DataMapper::Resource

  property :id, Serial
  property :sms_id, Integer
  property :created_at, DateTime

  before :create do
    self.created_at = Time.now
  end

  # default scope order :sms_id desc

  def self.last_sms_id
    last = all(order: [:sms_id.desc]).last
    last.sms_id if last
  end
end