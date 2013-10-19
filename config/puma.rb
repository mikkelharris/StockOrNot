threads 1, 6
workers 2

@env = ENV['RAILS_ENV'];

environment @env

bind 'unix:///tmp/stockshop.sock'

on_worker_boot do
	require "active_record"
	cwd = File.dirname(__FILE__)+"/.."
	ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
	ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("#{cwd}/config/database.yml")[ENV["RAILS_ENV"]])
end
