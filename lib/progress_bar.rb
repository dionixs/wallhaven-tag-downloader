require 'tty-spinner'

module Wallhaven
  class ProgressBar
    def self.print_status(status)
      spinner = TTY::Spinner.new("[:spinner] #{status}")
      spinner.success('(successful)')
    end
  end
end