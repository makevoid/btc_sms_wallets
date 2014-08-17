# currency BTC - Numeric types
#
# todo: enable / test refinement

CURRENCY = {
  mbtc: 5,
  btc:  8,
}

class Numeric
  def to_mbtc
    self * (10 ** -CURRENCY[:mbtc])
  end
end


# refinement

# module Conversion
#   CURRENCY = {
#     mbtc: 5,
#     btc:  8,
#   }

#   refine String do
#     def to_mbtc
#       self * (10 ** -CURRENCY[:mbtc])
#     end
#   end
# end

# module BtcSuperWallet
#   using Conversion

#   # ...
# end