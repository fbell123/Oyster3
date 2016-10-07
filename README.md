# Oyster Card


## Team wildcat smashed it today.


Oystercard initiates Journey_log which stores journeys and passes them to Journey.
Station is a separate entity.

Oystercard class now has less methods and calls on those from Journey as well as
outputting the station, zone and fare for the user.

Journey class checks to see if the current journey is complete, returning the
relevant fare or penalty as needed.

Journey_log class stores all journeys.

Station class allows name and zone of station to be input.



```ruby
[1] pry(main)> require './lib/oystercard'
=> true
[2] pry(main)> card = Oystercard.new
=> #<Oystercard:0x007f9d78b01928 @balance=50, @journey_log=#<JourneyLog:0x007f9d78b01900 @history=[]>>
[3] pry(main)> station1 = Station.new("A",1)
=> #<Station:0x007f9d78a62620 @name="A", @zone=1>
[4] pry(main)> station4 = Station.new("B",4)
=> #<Station:0x007f9d78990f80 @name="A", @zone=4>
[5] pry(main)> card.touch_in(station4)
Station: A
=> nil
[6] pry(main)> card.touch_out(station1)
Station: B. Charge: 4
=> nil
[7] pry(main)> card
=> #<Oystercard:0x007f9d78b01928
 @balance=46,
 @journey=#<Journey:0x007f9d7989d348 @entry_station=#<Station:0x007f9d78990f80 @name="B", @zone=4>, @exit_station=#<Station:0x007f9d78a62620 @name="A", @zone=1>, @journey_log=#<JourneyLog:0x007f9d78b01900 @history=[#<Journey:0x007f9d7989d348 ...>]>>,
 @journey_log=#<JourneyLog:0x007f9d78b01900 @history=[#<Journey:0x007f9d7989d348 @entry_station=#<Station:0x007f9d78990f80 @name="B", @zone=4>, @exit_station=#<Station:0x007f9d78a62620 @name="A", @zone=1>, @journey_log=#<JourneyLog:0x007f9d78b01900 ...>>]>>
[8] pry(main)> exit
```


***Dagmara killed it***
