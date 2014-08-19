# SMS_CLOCKWORK_KEY = File.read( File.expand_path "~/.clockwork" )
SMS_TEXTMAGIC_KEY = File.read( File.expand_path "~/.textmagic" ).strip


# TODO: move config in env rb
SMS_TEXTMAGIC_USERNAME = "makevoid"

GATEWAY_NUMBER = "393456645473" # shared textmagic
# GATEWAY_NUMBER = "447937946609" # bought from textmagic, (uk) global inbound number


# https://www.textmagic.com/app/api?username=makevoid&password=RK5lAuzCsX&cmd=send&text=Test+message&phone=393491598100&unicode=0

class Sms

  LAST_SMS_ID = defined?(Transaction) ? Transaction.last_sms_id : nil

  def self.deliver(number, message)
    new.deliver(number, message)
  end

  def self.receive(sms_id=LAST_SMS_ID)
    new.receive(sms_id)
  end

  def self.number
    CURRENT_NUMBER
  end

  def self.balance
    textmagic_balance
  end

  #

  def initialize
  end

  def deliver(number_to, message_text)
    @number = number_to
    # clockwork_send message_text
    # (other sms api)
    textmagic_send message_text
  end

  def receive(sms_id=LAST_SMS_ID)
    textmagic_receive sms_id
  end

  private

  def textmagic_api
    @textmagic_api ||= TextMagic::API.new(SMS_TEXTMAGIC_USERNAME, SMS_TEXTMAGIC_KEY)
  end

  def textmagic_send(message_text)
    # TODO:
    sms_id = textmagic_api.send message_text, @number
  end

  def textmagic_receive(sms_id)
    # returns a list of structs <Messages>, callable methods :text, :from, :message_id
    textmagic_api.receive sms_id
  end

  def textmagic_balance
    textmagic_api.account.balance
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