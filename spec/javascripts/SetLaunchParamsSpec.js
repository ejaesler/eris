describe("setLaunchParams", function () {

  beforeEach(function() {
    window.history.pushState({}, "Jasmine Suite", "http://localhost:8888/");
  });

  describe("when no launch parameters are specified", function () {
    beforeEach(function() {
      spyOn(jasmineEnyoBootstrap, 'getXhr').andCallFake(function() {
        return {
          open: function() {
            return testResponses.erisConfig.noLaunchParams.success;
          }
        }
      });

      jasmineEnyoBootstrap.setLaunchParams();
    });

    it("should not put any params onto the window's query string", function() {
      expect(window.location.search).toEqual("");
    });
  });

  describe("when launch parameters are specified", function () {
    beforeEach(function() {
      spyOn(jasmineEnyoBootstrap, 'getXhr').andCallFake(function() {
        return {
          open: function() {
            return testResponses.erisConfig.withLaunchParams.success;
          }
        }
      });

      jasmineEnyoBootstrap.setLaunchParams();
    });

    it("should put any params from eris_config.json onto the window", function() {
      expect(window.location.search).toEqual("?foo=bar%20baz&zip=12");
    });
  });
});