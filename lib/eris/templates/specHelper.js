function getJson(filename) {
	return enyo.g11n.Utils.getJsonFile({path: 'spec/unit/source/mock', locale: filename});
}