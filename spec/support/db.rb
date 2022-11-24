# frozen_string_literal: true

require_relative "db/helpers"
require_relative "db/database_cleaner"
require_relative "db/factory"

RSpec.configure do |config|
  config.before :suite, :db do
    Hanami.app.start :persistence
  end

  config.include Test::DB::Helpers, :db

  # Configure per-slice factories
  config.define_derived_metadata(file_path: /main/) do |metadata|
    metadata[:factory] = :main
  end
  config.include(Test::DB::FactoryHelper.new(:main), factory: :main)
  config.include(Test::DB::FactoryHelper.new, factory: nil)
end
