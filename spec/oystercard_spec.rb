require 'oystercard'

describe Oystercard do
	it 'has a variable called balance' do
		expect(subject.balance).to eq(0)
	end
	it "tells if in journey" do 
		expect(subject.in_journey).to eq(false)
	end
	it 'can top up' do 
		expect(subject.top_up 20).to eq(20)
	end
	it 'prevents topup when exceeds £90' do
		expect { subject.top_up 100 }.to raise_error("Exceeds topup limit: #{Oystercard::LIMIT}")
	end
	it 'touches in' do 
		subject.top_up(Oystercard::MINIMUM)
		subject.touch_in("Farringdon")
		expect(subject.in_journey).to eq(true)
	end
	it 'prevents touch in when balance smaller than minimum' do
		expect { subject.touch_in("Farringdon") } .to raise_error('Not enough funds')
	end
	it "touches out" do
		subject.top_up(Oystercard::MINIMUM)
		subject.touch_in("Farringdon")
		subject.touch_out("Peckham Rye")
		expect(subject.in_journey). to eq(false)
	end
	it 'deducts minimum fare' do
		subject.top_up(Oystercard::MINIMUM)
		subject.touch_in("Farringdon")
		subject.touch_out("Peckham Rye")
		expect(subject.balance).to eq 0
	end
	it "remembers the entry station" do 
		subject.top_up(10)
		subject.touch_in("Farringdon")
		subject.touch_out("Liverpool Street Station")
		expect(subject.journey_log[0][:entry_station]).to eq "Farringdon"
  end
  it "has an empty journey log by default" do
  	expect(subject.journey_log.length).to eq 0 
  end
  it "remembers all past journeys" do 
  	subject.top_up(5)
  	subject.touch_in("Farringdon")
  	subject.touch_out("Peckham Rye")
  	subject.touch_in("London Bridge Station")
  	subject.touch_out("Bank")
  	expect(subject.journey_log[1][:exit_station]).to eq "Bank"
  end
end

describe Journey do 
	it "returns fare when touched in and out" do 
		card = Oystercard.new
		card.top_up(5)
		card.touch_in('Kings cross')
		card.touch_out("Euston Square")
		expect(card.current_journey.fare). to eq (Oystercard::MINIMUM)
	end
	it "returns penalty if not touched_in or touched out" do
		card = Oystercard.new
		card.top_up(5)
		card.touch_in('Farringdon')
		expect(card.current_journey.fare). to eq (Oystercard::PENALTY)
	end
end