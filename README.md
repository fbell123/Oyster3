# Oyster Card


## Team wildcat smashed it today.

Refactored tests and code for exercise 14.

Journey created as a new class which stores the history as well as initiating
the journey. Fare is also handled by the Journey class.

Oystercard class now has less methods and calls on those from Journey as well as
outputting the station, zone and fare for the user.

```ruby
[1] pry(main)> require './lib/oystercard'
=> true
[2] pry(main)> card = Oystercard.new
=> #<Oystercard:0x007fc88a8d4e88 @balance=50, @journey=#<Journey:0x007fc88a8d4e60 @journey_history=[]>>
[3] pry(main)> card.touch_in(Station.new('Angel',1))
=> ["Angel", 1]
[4] pry(main)> card.touch_out(Station.new('Bank',1))
=> ["Bank", 1, 1]
[5] pry(main)> card.touch_in(Station.new('Bank',1))
=> ["Bank", 1]
[6] pry(main)> card.touch_out(Station.new('Angel',1))
=> ["Angel", 1, 1]
[7] pry(main)> card
=> #<Oystercard:0x007fc88a8d4e88
 @balance=48,
 @journey=
  #<Journey:0x007fc88a8d4e60
   @current_journey={:entry_station=>"Bank", :entry_zone=>1, :exit_station=>"Angel", :exit_zone=>1},
   @journey_history=[{:entry_station=>"Angel", :entry_zone=>1, :exit_station=>"Bank", :exit_zone=>1}, {:entry_station=>"Bank", :entry_zone=>1, :exit_station=>"Angel", :exit_zone=>1}]>>
[8] pry(main)> exit
```


***Dio killed it***
