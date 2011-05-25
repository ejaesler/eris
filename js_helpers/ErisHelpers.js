// simulates an application relaunch
var relaunchWithParams = function(launchParams) {
  // stubs for what Enyo expects when running in browser
  window.PalmSystem = {
    stageReady: function() {
    },
    setWindowOrientation: function() {
    }
  };

  PalmSystem.launchParams = decodeURIComponent(launchParams);
  Mojo.relaunch();
};

// Proxy all calls to palm:// and luna:// via novacom

var NovacomRequest = enyo.kind({
  name: NovacomRequest,
  kind: enyo.PalmService.Request,

  call: function() {
    var p = this.params || {};
    console.log("==> CALLING AJAX <== " + JSON.stringify(p));

    var lunaRequest = encodeURIComponent(enyo.json.stringify({
      url: this.service + this.method,
      body: p
    }));

    enyo.xhr.request({
      url: '/luna?req=' + lunaRequest,
      callback: enyo.hitch(this, "receive")
    });
  },

  setResponse: function(a) {
    console.error(a);
    this.inherited(arguments);
  },

  createBridge: enyo.nop,
  destroy: enyo.nop

});

if (!window.PalmSystem) {
  enyo.PalmService.prototype.requestKind = "NovacomRequest";
  enyo.DbService.prototype.requestKind = "NovacomRequest";
}
var logApiFailures = false;


// Proxy all XHRs to external APIs

var ProxiedRequest = enyo.kind({
  name: ProxiedRequest,
  kind: enyo.PalmService.Request,

  call: function() {
    var p = this.params || {};
    console.log("==> PROXYING AJAX to " + this.url + "  <== " + JSON.stringify(p));

    var newRequest = encodeURIComponent(enyo.json.stringify({
      url: this.url,
      body: p
    }));

    enyo.xhr.request({
      url: '/xhrproxy?req=' + newRequest,
      callback: enyo.hitch(this, "receive")
    });
  },

  setResponse: function(a) {
    console.error(a);
    this.inherited(arguments);
  },

  createBridge: enyo.nop,
  destroy: enyo.nop
});


