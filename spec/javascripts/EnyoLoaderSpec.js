describe("setEnyoArgs", function () {
  var enyoTag, fakeXhr, fakeResponse, fakeDocument;

  beforeEach(function() {
    enyo = {};
    fakeXhr = {
      open: function() {
      },
      send: function() {
        fakeXhr.status = fakeResponse.status;
        fakeXhr.responseText = fakeResponse.responseText;
      },
      responseText: null
    };

    fakeDocument = document.createElement('div');
    fakeDocument.setAttribute('class', 'fake doc');
    fakeDocument.appendChild(document.createElement('head'));

    spyOn(jasmineEnyoBootstrap, 'getXhr').andReturn(fakeXhr);
  });


  describe("with defaults", function () {
    beforeEach(function() {
      fakeResponse = testResponses.erisConfig.withDefaults.success;

      jasmineEnyoBootstrap.setEnyoArgs();
    });

    it("should give enyo no launch params", function() {
      expect(enyo.args).toEqual({})
    });
  });

  describe("with overrides", function () {
    beforeEach(function() {
      fakeResponse = testResponses.erisConfig.withOverrides.success;

      jasmineEnyoBootstrap.setEnyoArgs();
    });

    it("should give enyo the requested launch params", function() {
      expect(enyo.args).toBeDefined();
      expect(enyo.args.foo).toBeTruthy();
      expect(enyo.args.baz).toBeTruthy();
    });
  });

});
