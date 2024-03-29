try {
  module.exports = require("../../build/Release/tree_sitter_php_binding");
} catch (error1) {
  if (error1.code !== 'MODULE_NOT_FOUND') {
    throw error1;
  }
  try {
    module.exports = require("../../build/Debug/tree_sitter_php_binding");
  } catch (error2) {
    if (error2.code !== 'MODULE_NOT_FOUND') {
      throw error2;
    }
    throw error1
  }
}

try {
  module.exports.php.nodeTypeInfo = require("../../php/src/node-types.json");
  module.exports.php_only.nodeTypeInfo = require("../../php_only/src/node-types.json");
} catch (_) {}
