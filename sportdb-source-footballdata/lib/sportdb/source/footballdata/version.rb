module SportDb
module Source
module Footballdata

  MAJOR = 1    ## todo: namespace inside version or something - why? why not??
  MINOR = 1
  PATCH = 0
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "sportdb-source-footballdata/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    File.expand_path( File.dirname(File.dirname(File.dirname(File.dirname(File.dirname(__FILE__))))) )
  end

end # module Footballdata
end # module Source
end # modlue SportDb
