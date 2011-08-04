var jasmineEnyoBootstrap = jasmineEnyoBootstrap || {};

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

jasmineEnyoBootstrap.setLaunchParams = function() {

  var xhr = jasmineEnyoBootstrap.getXhr();
  var erisConfig = JSON.parse(xhr.open("GET", "eris_config.json", true).responseText);

  var launchParams = erisConfig.enyoLaunchParams;

  if (!launchParams) {
    return;
  }

  window.history.pushState({}, "Jasmine Suite", "http://localhost:8888?" + buildQueryString());

  function buildQueryString() {
    return Object.keys(launchParams).map(function(key) {
      return encodeURIComponent(key) + '=' + encodeURIComponent(launchParams[key]);
    }).join('&');
  }
};
