require "ecr"
require "ecr/macros"

module Prax
  class Views
    macro render(name)
      String.build do |__str__|
        embed_ecr "#{{{__DIR__}}}/templates/{{name.id}}.ecr", "__str__"
      end
    end

    def initialize
      if HOSTS.starts_with?(ENV["HOME"])
        @hosts = "~" + HOSTS[ENV["HOME"].length..-1]
      else
        @hosts = HOSTS
      end
    end

    def layout(@title, &block)
      render :layout
    end

    def application_not_found(@name, @host)
      layout "Application not found" do
        render :application_not_found
      end
    end

    def error_starting_application(app)
      @log = File.read(app.path.log_path) if app

      layout "Error starting application" do
        render :error_starting_application
      end
    end

    def proxy_error(@host, @port, @exception)
      layout "Proxy Error" do
        render :proxy_error
      end
    end

    def welcome
      layout "Welcome" do
        render :welcome
      end
    end
  end
end
