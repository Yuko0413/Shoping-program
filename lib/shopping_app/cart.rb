require_relative "item_manager"
require_relative "ownable"


class Cart
  include ItemManager
  include Ownable


  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    #Item.all.select{|item| item.owner == self }   自分自身を指す、 
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    # ItemManagerのitemsメソッド →Item.all.select{|item| item.owner == self }
    #　→.select { |変数| ブロック処理 }「{}」で囲ったブロックの変数に要素を一つずつ格納しながら、ブロックの処理が真になったときの要素を取得。
    @items 
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out #どんなメソッド、変数が使えるかを考える
    return if owner.wallet.balance < total_amount #財布が合計金額より少ない、falseが返る
     
    
    items.each do |item| #複数系から単数形にしたほうが良い
      price = item.price #購入したitemの金額がpriceに入っている
      self.owner.wallet.withdraw(price)                 

      item.owner.wallet.deposit(price) #オーナーの財布に入金処理ができた
      item.owner = self.owner #販売者からカスタマーに上書きする
    end

    @items = [] #カートの中を空にする,配列だから配列を空にする

  # # ## 要件
  # #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること。
  # #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
  # #   - カートの中身（Cart#items）が空になること。

  # # ## ヒント
  # #   - カートのオーナーのウォレット ==> self.owner.wallet
  # #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  # #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  # #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?)
  end

end




