require 'minitest/autorun'
require 'net/http'
require 'jekyll'

module TestHelper

  PORT = 8686

  def start_server
    @pid = fork do
      system("jekyll serve -p #{PORT} > /dev/null")
    end
    sleep 2
  end

  def stop_server
    Process.kill 'TERM', @pid
    Process.wait @pid
    require 'pry'; binding.pry
  end

  def get_page(url)
    @last_response = Net::HTTP.get(URI(url))
  end
end
