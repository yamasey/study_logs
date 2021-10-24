# 依存オブジェクトの注入

class Hoge
  #....

  # barメソッドはDummyインスタンスとしか共同作業しないと明示的にしてしている
  # HogeクラスはDummyクラスにかなり依存している
  def bar
    foo * Dummy.new('a', 'b').some_method
  end

  # 本来Hogeクラスはsome_methodに応答さえしてくれるインスタンスが入ればよく、それが何のクラスか知る必要がない
  attr_reader :dummy
  def initialize(dummy)
    @dummy = dummy
  end

  # これでHogeはsome_methodに応答するインスタンスをセットするだけでよくsome_methodに応答するインスタンスであれば誰でも歓迎できる。
  def bar
    foo * dummy.some_method
  end
end
