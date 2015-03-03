module Railyard
  class Gemfile

    def initialize(path)
      @path = path
    end

    def update_version(number)
      body  = read
      lines = body.split("\n")
      rails = lines.find { |line| line =~ /rails/ }

      if match = rails.match(/(\d[\d\.]{0,})/)
        new_rails = rails.gsub(match[1], number)
      else
        new_rails = "#{rails}, \"#{number}\""
      end

      body = lines.join("\n") + "\n"
      body.gsub!(rails, new_rails)

      write(body)
    end

  private

    def read
      File.read(@path)
    end

    def write(body)
      File.open(@path, "w") { |file| file.write(body) }
    end

  end
end
