base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

$LOAD_PATH.unshift(base_dir)
$LOAD_PATH.unshift(lib_dir)
$LOAD_PATH.unshift(test_dir)

require 'test/unit'
require 'rack/test'

require 'cctools'

exit Test::Unit::AutoRunner.run(true, test_dir)
