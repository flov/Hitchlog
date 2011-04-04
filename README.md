Hitchlog
--------

Hitchhiking is my favorite way of transportation. Whenever I had time to
travel i chose hitchhiking before car pooling and trains. It is a great way
to get in touch with the local people and to get a glimpse of the life of 
a completely other personality.
When I managed to go a long tour of about 1000 kms in one day i’ve felt 
energised and quite happy about my day spent on the road, meeting all 
these people coming from different backgrounds. Additionally I also felt that I
deserve to be there more than any other tourist :P

After a while it was quite difficult for me to remember all these different people
and the stories that were connected to it. Additionaly it would have been nice to 
see how much kilometers I made and how much cars I have seen from inside while hitchhiking.

By making it easy to log these experiences,
this application aims at creating a hitchhiking log.
Furthermore the logs can be used to create demographic statistics about hitchhiking:
e.g. how much male/female driver did you hitchhike with, the average waiting time, 
or how much kilometers did you hitchhike, etc...

[Frank Verhart](http://hitchwiki.org/en/User:Fverhart) started to document his 
hitchhiking statistics on [hitchwiki](http://hitchwiki.org/en/User:Fverhart) the idea
of this application is to make it easy to provide an easy way to collect that data


Set Up
-----------------------
Copy config/database.yml.example to config/database.yml

    cp config/database.yml.example config/databse.yml

and run:

    bundle install
    rake db:migrate
    rails s

Documenting A Hitchhike
-----------------------

The current flow of documenting hitchhikes:

* Log in
* Click on new Trip
* Fill in: 
  - from
  - to
  - date
  - duration
  - number of rides
* Now that you defined a trip and the number of rides, you can provide additional
  information specific hitchhikes of a trip.
  - title and story
  - photo
  - waiting time and duration of ride
  
  Person:
    - Name
    - Occupation
    - Origin
    - Mission
    - Age
    - Gender

* If you provided an image, crop it
* Submit

Upcoming Features / TODOs
-------

* Implementation with other sites:
  - combining the [Mediawiki API](http://www.mediawiki.org/wiki/API:Login) of hitchwiki  with the
    Hitchlog Login process
  - Javascript embed to show your personal hitchhiking experiences on other sites like hitchwiki

Environment
-----------

* Ruby 1.9.2
* Rails 3.0.3
* Rspec 2.0.1
* Cucumber 0.9.2
* Mysql
* ... (see Gemfile)

We are using the Famfamfam icon collection
