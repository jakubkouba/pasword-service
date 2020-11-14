require 'sinatra'
$LOAD_PATH.push(File.expand_path('app', File.dirname(__FILE__ )))
$LOAD_PATH.push(File.expand_path('app/lib', File.dirname(__FILE__ )))

require 'password_service'

run PasswordService
