# このクラスは将来「進化する」可能性が大きい。
# コードは変更が簡単でなければならない

class Gear
  attr_reader :chainring, :cog, :rim,  :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  #ギアインチを計算できるメソッドを定義してみる
  def gear_inches
    ratio * (rim + (tire * 2))
  end
end

# ギアインチを定義したことにより以前まで動いていたものでエラーになる。
# 小さなアプリケーションなら問題ないが大きいと対処が難しくなる
# puts Gear.new(52, 11).ratio
puts Gear.new(52, 11, 26, 1.5).gear_inches
