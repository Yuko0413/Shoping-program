require_relative "ownable"

class Wallet   ##財布への入金処理？
  include Ownable

  attr_reader :balance

  def initialize(owner)   ##balanceは残高
    self.owner = owner
    @balance = 0
  end

  def deposit(amount)  ##amountは金額、depositは入金or貯金
    @balance += amount.to_i
  end

  def withdraw(amount) ##withdrawは撤回(出金)する
    return unless @balance >= amount
    @balance -= amount.to_i
    amount
  end

end