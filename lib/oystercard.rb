class Oystercard
	LIMIT = 90
	MINIMUM = 1
	PENALTY = 6
	attr_reader :balance, :journey_log, :in_journey, :current_journey
	def initialize
		@balance = 0
		@journey_log = []
		@in_journey = false
	end 
	def top_up(amount)
		fail "Exceeds topup limit: #{LIMIT}" if balance + amount > LIMIT
		@balance += amount
	end
	def touch_in(station)
		raise 'Not enough funds' if @balance < MINIMUM
		@in_journey = true
		make_journey(station)
	end
	def touch_out(station)
		deduct(MINIMUM)
		@in_journey  = false
		conclude_journey(station)
	end
	private 
	def deduct(amount)
		@balance -= amount
	end
	def make_journey(station)
		@current_journey = Journey.new
		@current_journey.start_journey(station)
	end
	def conclude_journey(station)
		@current_journey.finish_journey(station)
		store_journey
	end
	def store_journey
		@journey_log << @current_journey.journey
	end	
end

 class Journey
 	attr_reader :journey
  def initialize
	  @journey = {} 
	end
  def start_journey(station)
  	@journey[:entry_station] = station
  end
  def finish_journey(station)
  	@journey[:exit_station] = station
  end
  def fare 
  	if !@journey[:entry_station] || !@journey[:exit_station]
  		Oystercard::PENALTY 
  	else 
  		Oystercard::MINIMUM
  	end
  end 
 end