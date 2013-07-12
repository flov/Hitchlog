# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard 'livereload' do
  watch(%r{config/locales/.+\.yml})
  watch(%r{app/.+\.(erb|haml)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{app/assets/.+\.(coffee|scss|sass)})
end


guard 'jasmine' do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})         { "spec/javascripts" }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
end
