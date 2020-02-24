class Oystercard
	LIMIT = 90
	attr_reader :balance 
	attr_accessor :in_use
	def initialize
		@balance = 0
		@in_use = false
	end 
	def top_up(amount)
		fail "Exceeds topup limit: #{LIMIT}" if balance + amount > LIMIT
		@balance += amount
	end
	def deduct(amount)
		@balance -= amount
	end
	def in_journey?
		return in_use ? true : false
	end

end