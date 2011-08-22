describe("ErisConfig", function () {
  var erisConfig, fakeXhr, fakeResponse;

  beforeEach(function() {

    fakeXhr = {
      open: function() {
      },
      send: function() {
        fakeXhr.status = fakeResponse.status;
        fakeXhr.responseText = fakeResponse.responseText;
      },
      responseText: null
    };
    spyOn(jasmineEnyoBootstrap, 'getXhr').andReturn(fakeXhr);

    erisConfig = new ErisConfig();
  });

  describe("#enyoPath", function () {

    describe("with defaults", function () {
      beforeEach(function() {
        fakeResponse = testResponses.erisConfig.withDefaults.success;
        erisConfig.load();
      });

      it("should return a path to the default version", function() {
        expect(erisConfig.enyoPath()).toEqual('/usr/palm/frameworks/enyo/0.10/framework/enyo.js');
      });
    });

    describe("with overrides", function () {
      beforeEach(function() {
        fakeResponse = testResponses.erisConfig.withOverrides.success;
        erisConfig.load();
      });

      it("should return a path to the default version", function() {
        expect(erisConfig.enyoPath()).toEqual('/usr/palm/frameworks/enyo/19/framework/enyo.js');
      });
    });
  });

  describe("#launchParams", function () {

    describe("when no launch parameters are specified", function () {
      beforeEach(function() {
        fakeResponse = testResponses.erisConfig.withDefaults.success;
        erisConfig.load();
      });

      it("should return an empty array", function() {
        expect(erisConfig.launchParams()).toEqual([]);
      });
    });

    describe("when launch parameters are specified", function () {
      beforeEach(function() {
        fakeResponse = testResponses.erisConfig.withOverrides.success;
        erisConfig.load();
      });

      it("should return a comma-delimited list of truthy keys", function() {
        expect(erisConfig.launchParams()).toEqual(["foo","baz"]);
      });
    });
  });
});