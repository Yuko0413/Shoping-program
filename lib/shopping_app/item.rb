require_relative "ownable"


class Item
  include Ownable

  attr_reader :number, :name, :price

  @@instances = []  ##配列、クラス変数、設定したクラス内及びそれを継承するサブクラス、インスタンス内で参照可能.例に挙げる

  def initialize(number, name, price, owner=nil) #=iになる
    @number = number
    @name = name
    @price = price
    self.owner = owner #アイテムにもオーナーがある

    # Itemインスタンスの生成時、そのItemインスタンス(self)は、@@insntancesというクラス変数に格納されます。
    @@instances << self
  end

  def label
    { number: number, name: name, price: price }
  end

  def self.all
    #　@@instancesを返します ==> Item.allでこれまでに生成されたItemインスタンスを全て返すということです。
    @@instances
  end

end

# i = Item.new(1,"aaa",1000,"bbb")
# it = self.new.all
# puts it.self.all