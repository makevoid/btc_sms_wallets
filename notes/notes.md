#  replies = api.receive
#  # => ["999271828182: Hello Fred", "999314159265: Good day"]
#  replies.first.text
#  # => "Hello Fred"
#  replies.first.from
#  # => "999314159265"
#  replies.last.message_id
#  # => "223606"
#  api.receive "223606"
#  # => []
#
# <b>It is strongly encouraged to setup callbacks to receive replies instead of
# using this method.</b>
def receive(last_retrieved_id = nil)

---

#  check = api.check_number("447624800500")
#  check.price
#  # => 0.8
#  check.country
#  # => "GB"
#
# Example with multiple phone numbers:
#
#  check = api.check_number("447624800500", "61428102137")
#  check["447624800500"].price
#  # => 0.8
#  check["61428102137"].country
#  # => "AU"
#
# Multiple phone number can be supplied as an array or as a list of arguments:
#
#  api.check_number(["447624800500", "61428102137"])
#  api.check_number("447624800500", "61428102137")
#
# If you want to check a single phone number but still want to get
# a hash response, put the number in an array:
#
#  api.check_number(["447624800500"])
def check_number(*phones)

---

http // https

config url in the backend

HTTP HEAD request

response == 200





# SMS Delivery Notification Callback
Variable	Value
message_id	A unique ID assigned to a message.
timestamp	The time of receiving a delivery notification from a mobile operator, in Unix time format.
status	The delivery status.
credit_cost	The total cost of the message in SMS credits.
Incoming SMS Message Callback

# Variable	Value
message_id	A unique ID assigned to an incoming message.
timestamp	The time of receiving the message, in Unix time format.
from	The sender’s phone number.
text	The message’s text, in the UTF-8 character set.
