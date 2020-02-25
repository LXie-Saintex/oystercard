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
	it 'can deduct' do 
		subject.top_up 90
		expect(subject.deduct 50).to eq(40)
	end
	it 'prevents topup when exceeds £90' do
		expect { subject.top_up 100 }.to raise_error("Exceeds topup limit: #{Oystercard::LIMIT}")
	end
	it 'touches in' do 
		subject.top_up(5)
		subject.touch_in
		expect(subject.in_journey?).to eq(true)
	end
	it 'prevents touch in when balance smaller than minimum' do
		expect { subject.touch_in } .to raise_error('Not enough funds')
	end
	it "touches out" do
		subject.top_up(5)
		subject.touch_in
		subject.touch_out
		expect(subject.in_journey?). to eq(false)
	end
end