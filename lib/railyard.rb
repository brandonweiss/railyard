require "railyard/version"
require "railyard/gemfile"

require "pathname"
require "thor"
require "bundler"

module Railyard

  class CLI < Thor

    desc "version [NUMBER]", "Show or change the Rails version"
    def version(number = nil)
      if number
        message = installed? ? "Changing Rails version..." : "Installing Rails..."

        Gemfile.new(gemfile_path).update_version(number)
        puts message

        success = install
        puts "Rails version #{number} doesn't appear to exist." unless success
      else
        if !installed?
          puts "Installing Rails..."
          install
        end

        sandbox("bundle exec rails --version")
      end
    end

    desc "new [APP_PATH]", "Create a new Rails application"
    def new(app_path = nil, *args)
      if !installed?
        puts "Installing Rails..."
        install
      end

      if app_path && app_path !~ /^--?/
        args.unshift expand_path(app_path)
        args << "--skip-bundle" unless args.include?("--skip-bundle")
      else
        args << "--help"
      end

      rails_new(args)
    end

    desc "plugin [APP_PATH]", "Create a new Rails Engine"
    def plugin(app_path = nil, *args)
      if !installed?
        puts "Installing Rails..."
        install
      end

      if app_path && app_path !~ /^--?/
        args.unshift expand_path(app_path)
        args << "--skip-bundle" unless args.include?("--skip-bundle")
      else
        args << "--help"
      end

      rails_plugin(args)
    end

    def help
      puts "railyard #{Railyard::VERSION}"
      super
    end

    no_commands do

      def rails_new(args)
        sandbox("bundle exec rails new #{args.join(' ')}")
      end

      def rails_plugin(args)
        sandbox("bundle exec rails plugin new #{args.join(' ')}")
      end

      def installed?
        sandbox("bundle check > /dev/null")
      end

      def install
        sandbox("bundle install --path vendor > /dev/null")
      end

      def sandbox(command)
        Bundler.with_clean_env do
          system("cd #{sandbox_path}; #{command}")
        end
      end

      def sandbox_path
        Pathname.new(File.expand_path("../../sandbox", __FILE__))
      end

      def gemfile_path
        sandbox_path.join("Gemfile")
      end

      def expand_path(path)
        path[0] == "/" ? path : working_directory.join(path)
      end

      def working_directory
        Pathname.new(Dir.pwd)
      end

    end

  end
end
