# SMS_CLOCKWORK_KEY = File.read( File.expand_path "~/.clockwork" )
# SMS_TEXTMAGIC_KEY = File.read( File.expand_path "~/.textmagic" )

class Sms
  def self.deliver(number, message)
    new(number).deliver(message)
  end

  def initialize(number)
    @number = number
  end

  def deliver(message_text)
    # clockwork_send message_text
    # (other sms api)
    texmagic_send message_text
  end

  private

  def textmagic_send(message_text)
    # TODO:
  end
  
  # unused, no receive in clockwork
  # 
  # def clockwork_send(message_text)
  #   api = Clockwork::API.new  SMS_CLOCKWORK_KEY
  #   message = api.messages.build( to: @number.gsub(" ", ''), content: message_text )
  #   response = message.deliver
  # 
  #   if response.success
  #     puts response.message_id
  #   else
  #     puts response.error_code
  #     puts response.error_description
  #   end
  # 
  #   response.success # something like: "VI_249751157" will be returned
  # end
  
end

# Sms.send "39 3491598100", "test"