module Footballdata


def self.download_season_by_season( sources, start: nil )   ## format i - one datafile per season
  download_base  = "http://www.football-data.co.uk/mmz4281"

  start = Season.parse( start )   if start  ## convert to season obj

  sources.each do |rec|
    season     = Season.parse( rec[0] )   ## note: dirname is season_key e.g. 2011-12 etc.
    basenames  = rec[1]

    if start && season < start
      puts "skipping #{season} before #{start}"
      next
    end

    basenames.each do |basename|
      # build short format e.g. 2008/09 becomes 0809 etc
      season_path = "%02d%02d" % [season.start_year % 100, season.end_year % 100]
      url = "#{download_base}/#{season_path}/#{basename}.csv"

      puts " url: >#{url}<"
      get( url )
    end
  end
end


def self.download_all_seasons( basename )   ## format ii - all-seasons-in-one-datafile
  download_base  = "http://www.football-data.co.uk/new"

  url  = "#{download_base}/#{basename}.csv"

  puts " url: >#{url}<"
  get( url )
end

#############
# helpers
def self.get( url )
  ## [debug] GET=http://www.football-data.co.uk/mmz4281/0405/SC0.csv
  ##    Encoding::UndefinedConversionError: "\xA0" from ASCII-8BIT to UTF-8
  ##     note:  0xA0 (160) is NBSP (non-breaking space) in Windows-1252

  ## note: assume windows encoding (for football-data.uk)
  ##   use "Windows-1252" for input and convert to utf-8
  ##
  ##    see https://www.justinweiss.com/articles/3-steps-to-fix-encoding-problems-in-ruby/
  ##    see https://en.wikipedia.org/wiki/Windows-1252

  response = Webget.dataset( url, encoding: 'Windows-1252' )

  ## note: exit on get / fetch error - do NOT continue for now - why? why not?
  exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200
end

end # module Footballdata
