var jasmineEnyoBootstrap = jasmineEnyoBootstrap || {};

// exposure for testing
jasmineEnyoBootstrap.getXhr = function() {
  try {
    return new XMLHttpRequest();
  } catch (e) {
  }
  try {
    return new ActiveXObject('Msxml2.XMLHTTP');
  } catch (e) {
  }
  try {
    return new ActiveXObject('Microsoft.XMLHTTP');
  } catch (e) {
  }
  return null;
};

// exposure for testing
jasmineEnyoBootstrap.getDocument = function() {
  return document;
};


function ErisConfig() {
  var xhr = jasmineEnyoBootstrap.getXhr();

  var config;

  var self = this;

  self.load = function() {
    xhr.open("GET", "eris_config.json", false);
    xhr.send();

    if (xhr.status != 200) {
      config = {};
    } else {
      config = JSON.parse(xhr.responseText);
    }
  };

  self.enyoPath = function() {
    var version = config["enyoVersion"] || "0.10";

    return  "/usr/palm/frameworks/enyo/" + version + "/framework/enyo.js";
  };

  self.launchParams = function() {
    if (!config.enyoLaunchParams) {
      return [];
    }

    return Object.keys(config.enyoLaunchParams).filter(function(key) {
      return config.enyoLaunchParams[key];
    });
  };

  return self;
}

jasmineEnyoBootstrap.setEnyoArgs = function() {

  window.enyo = {
    args: {}
  };

  var config = new ErisConfig();
  config.load();

  var launchParams = config.launchParams();

  launchParams.forEach(function(p) {
    enyo.args[p] = true;
  });
};
