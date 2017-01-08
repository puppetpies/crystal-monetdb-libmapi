# #######################################################################
#
# Author: Brian Hood
# Name: Crystal bindings for MonetDB
# Codename: Dagobert I
# Description:
#   Tools library
#
#
# #######################################################################
require "progress"

struct Number
  def times_with_progress(&block)
    bar = ProgressBar.new
    bar.total = self
    bar.incomplete = "."
    bar.complete = "o"
    self.times do |i|
      yield i
      bar.inc
    end
  end
end

class Timers
  property? start : Time
  property? finish : Time

  def initialize
    @start = Time.now
    @finish = Time.now
  end

  def start
    @start = Time.now
  end

  def stop
    @finish = Time.now
  end

  def stats
    duration = @finish - @start
    return "Start: #{@start} Finish: #{@finish} Duration: #{duration.to_s}"
  end
end
