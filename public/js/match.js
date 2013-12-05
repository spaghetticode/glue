$(function() {
  var ws, json, event, data;

  window.match = {
    clock: $('[data-clock]').FlipClock({autoStart: false}),
    init: function() {
      this.startAt = new Date($('#match').data('start'));
      if ($('#match').data('end')) {
        this.endAt   = new Date($('#match').data('end'));
      }
      this.setClock();
    },
    start: function(data) {
      this.resetClock();
      this.update(data);
    },
    close: function(data) {
      this.stopClock();
      this.update(data);
    },
    update: function(data) {
      this.refresh(data);
    },
    stopClock: function() {
      this.endAt = new Date();
      this.clock.stop();
    },
    setClock: function() {
      if (this.endAt) {
        this.clock.setTime((this.endAt - this.startAt)/1000);
      } else {
        // match is not finished yet
        this.clock.setTime((new Date() - this.startAt)/1000);
        this.clock.start();
      }
    },
    resetClock: function() {
      this.startAt = new Date();
      this.clock.setTime(0);
      var self = this;
      setTimeout(function() {self.clock.start()}, 200);
    },
    refresh: function(data) {
      $('#score_a').text(data.team_a_score);
      $('#score_b').text(data.team_b_score);
      $('#player_1').text('@' + data.player_1);
      $('#player_2').text('@' + data.player_2);
      $('#player_3').text('@' + data.player_3);
      $('#player_4').text('@' + data.player_4);
    }
  };

  match.init();

  ws = new WebSocket('ws://' + window.location.host + '/websocket');
  ws.onmessage = function(message) {
    json  = JSON.parse(message.data)[0];
    event = json[0];
    data  = json[1];
    switch (event) {
      case 'start_match'  : match.start(data);
      case 'close_match'  : match.close(data);
      case 'update_match' : match.update(data);
    }
  };
});