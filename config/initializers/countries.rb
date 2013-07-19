module Countries
  def self.[](key)
    unless @countries
      @countries = YAML.load(File.open("#{Rails.root}/config/countries.yml"))
    end
    @countries[key]
  end

  def self.[]=(key,value)
    @countries[key.to_sym] = value
  end
end
