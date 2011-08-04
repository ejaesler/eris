testResponses = {};

testResponses.erisConfig = {
  noLaunchParams: {
    success: {
      status: 200,
      responseText: JSON.stringify({
          "localEnyoRoot": "../",
          "ciEnyoRoot": "../ciboxenyo"
        }
      )
    }
  },

  withLaunchParams: {
    success: {
      status: 200,
      responseText: JSON.stringify({
          "localEnyoRoot": "../",
          "ciEnyoRoot": "../ciboxenyo",
          "enyoLaunchParams": {
            "foo": "bar baz",
            "zip": 12
          }
        }
      )
    }
  }
};
