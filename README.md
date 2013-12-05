# GLUE - Sinatra version

[![Build Status](https://secure.travis-ci.org/spaghetticode/glue.png)](http://travis-ci.org/spaghetticode/glue)

This is a ruby sinatra application to be used with jeko's [biliarduino](https://github.com/amicojeko/biliarduino) [table football](http://en.wikipedia.org/wiki/Table_football) manager.

This is an open source application developed on my current company time, [MIKAMAI](https://www.mikamai.com/).

## FEATURES

* it can run directly on the raspberrypi device, no need for an external server
* uses websockets for fast feedback
* 2 levels of players: registered players and dummy players for demos/quick games
* dummy players get names from config/dummy_player_names.yml, which includes some famous soccer player of the past

The table football program (biliarduino) will communicate via websockets with this app, which will also serve regular html pages to see the current match scoreboard. Still WIP, more features to come in the future.

## TWITTER

When the match starts and ends the app tries to publish a tweet. The twitter account information must be stored in config/twitter.yml (see config/twitter.yml.sample).


![table football](http://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Baby_foot_artlibre_jnl.jpg/450px-Baby_foot_artlibre_jnl.jpg)
