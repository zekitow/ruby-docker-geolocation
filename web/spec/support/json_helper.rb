def json_request(dir, name)
  full_fime_name_path = File.join("./spec/support/#{dir}/json", "#{name}.json");
  JSON.parse(File.open(full_fime_name_path, 'r').read)
end