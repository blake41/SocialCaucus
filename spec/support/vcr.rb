require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = Rails.root.join("spec","vcr")
  c.stub_with :typhoeus
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = true
end

# RSpec.configure do |c|
#   c.treat_symbols_as_metadata_keys_with_true_values = true
#   c.around(:each, :vcr) do |example|
#     name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
#     options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
#     VCR.use_cassette(name, options) { example.call }
#   end
# end