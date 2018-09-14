# spec/support/fixture_helpers.rb

def fixture_file_path(filename)
  "./spec/#{filename}"
end

def read_fixture_file(filename)
  File.read(fixture_file_path(filename))
end

def json_fixture_file(filename, castTo)
  content = read_fixture_file(filename)
  JSON.parse(content).map { |attr| castTo.new(attr) }
end

def fixture_as_hash(filename)
  content = read_fixture_file(filename)
  JSON.parse(content).to_hash
end