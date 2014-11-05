module Railyard
  class Gemfile

    def initialize(path)
      @path = path
    end

    def update_version(number)
      body = read

      if match = body.match(/^gem \"rails\", \"(\d+(?:\.\d+(?:\.\d+)?)?)\"$/)
        body.gsub!(match[1], number)
      else
        body.gsub!(/, \"[\d\.]+\"/, "")
      end

      write(body)
    end

  private

    def remove_version(body)
      body.gsub(/, \"[\d\.]+\"/, "")
    end

    def read
      File.read(@path)
    end

    def write(body)
      File.open(@path, "w") { |file| file.write(body) }
    end

  end
end
