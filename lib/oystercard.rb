class Oystercard
	LIMIT = 90
	MINIMUM = 1
	attr_reader :balance 
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
		return @in_use ? true : false
	end
	def touch_in
		raise 'Not enough funds' if @balance < MINIMUM
		@in_use = true
	end
	def touch_out
		@in_use = false
	end
end