Dir[File.dirname(__FILE__) + "/eris/**/*.rb"].each do |file|
  require file[0..-4]
end