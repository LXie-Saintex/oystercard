class Oystercard
	LIMIT = 90
	MINIMUM = 1
	attr_reader :balance, :entry_station
	def initialize
		@balance = 0
		@entry_station = nil
	end 
	def top_up(amount)
		fail "Exceeds topup limit: #{LIMIT}" if balance + amount > LIMIT
		@balance += amount
	end
	def in_journey? 
		return @entry_station ? true : false
	end
	def touch_in(entry_station)
		raise 'Not enough funds' if @balance < MINIMUM
		@entry_station = entry_station
	end
	def touch_out
		deduct(MINIMUM)
		@entry_station = nil
	end
	private 
	def deduct(amount)
		@balance -= amount
	end
end