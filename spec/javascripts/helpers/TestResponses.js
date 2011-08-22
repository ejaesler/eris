testResponses = {};

testResponses.erisConfig = {
  withDefaults: {
    success: {
      status: 200,
      responseText: JSON.stringify({
          "localEnyoRoot": "../",
          "ciEnyoRoot": "../ciboxenyo"
        }
      )
    }
  },

  withOverrides: {
    success: {
      status: 200,
      responseText: JSON.stringify({
          "localEnyoRoot": "../",
          "ciEnyoRoot": "../ciboxenyo",
          "enyoVersion": "19",
          "enyoLaunchParams": {
            "foo": true,
            "bar": false,
            "baz": true
          }
        }
      )
    }
  }
};
