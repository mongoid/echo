# vim:set filetype=ruby:
guard(
  "rspec",
  all_after_pass: false,
  cli: "--fail-fast --tty --format documentation --colour") do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { |m| "spec/requests/#{m[1]}_spec.rb" }
end
