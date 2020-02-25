require 'oystercard'

describe Oystercard do
	it 'has a variable called balance' do
		expect(subject.balance).to eq(0)
	end
	it "tells if in journey" do 
		expect(subject.in_journey?).to eq(false)
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
		expect(subject.in_journey?).to eq(true)
	end
	it 'prevents touch in when balance smaller than minimum' do
		expect { subject.touch_in("Farringdon") } .to raise_error('Not enough funds')
	end
	it "touches out" do
		subject.top_up(Oystercard::MINIMUM)
		subject.touch_in("Farringdon")
		subject.touch_out
		expect(subject.in_journey?). to eq(false)
	end
	it 'deducts minimum fare' do
		subject.top_up(Oystercard::MINIMUM)
		subject.touch_in("Farringdon")
		subject.touch_out
		expect(subject.balance).to eq 0
	end
	it "remembers the entry station" do 
		subject.top_up(10)
		subject.touch_in("Farringdon")
		expect(subject.entry_station).to eq "Farringdon"
  end
end