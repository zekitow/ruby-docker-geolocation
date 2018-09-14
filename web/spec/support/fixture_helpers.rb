# spec/support/fixture_helpers.rb

def fixture_file_path(filename)
  "./spec/fixtures/#{filename}"
end

def read_fixture_file(filename)
  File.read(fixture_file_path(filename))
end

def json_fixture_file(filename, castTo)
  content = read_fixture_file(filename)
  result  = JSON.parse(content).map { |attr| castTo.new(attr) }
end