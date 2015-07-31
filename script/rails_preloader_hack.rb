# From http://cfc.kizzx2.com/index.php/run-single-test-with-spring-in-rails-4-1/
# In your vimrc, add something like:
#   let g:vimux_ruby_cmd_all_tests = 'bundle exec rails r -e test ~/.vim/bundle/vimux-ruby-test/script/rails_preloader_hack.rb'
#   let g:vimux_ruby_cmd_unit_test = g:vimux_ruby_cmd_all_tests
#   let g:vimux_ruby_cmd_context = g:vimux_ruby_cmd_all_tests

$: << Rails.root.join('test')

options = {}
OptionParser.new do |opts|
  opts.on('-n TEST_NAME') do |n|
    options[:test_name] = n
  end

  opts.on('-e ENVIRONMENT') do |e|
    raise ArgumentError.new("Must run in test environment") if e != 'test'
  end
end.parse!

test_files = ARGV.dup
ARGV.clear
if options[:test_name]
  ARGV << "-n" << options[:test_name]
end

test_files.each do |f|
  Dir[f].each do |f1|
    load f1
  end
end
