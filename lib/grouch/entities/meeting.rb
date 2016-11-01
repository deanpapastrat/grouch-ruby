require 'grouch/utils/day_support'

module Grouch
  # The meeting entity describes when a particular section is in session
  # and what will occur during that session.
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  class Meeting < Entity
    include Grouch::Utils::DaySupport

    # Returns the person leading the meeting
    #
    # @example
    #   meeting.instructor #=> 'Monica Sweat'
    #
    # @return [ String ] a string with the person's name
    attr_reader :instructor

    # Returns the where the meeting will occur
    #
    # @example
    #   meeting.location #=> 'Clough Undergraduate Commons 102'
    #
    # @return [ String ] a string representing the location
    attr_reader :location

    # Returns the where the meeting will occur
    #
    # @example
    #   meeting.type #=> 'lecture'
    #
    # @return [ String ] a string representing the meeting type
    attr_reader :type

    # Returns the days that the meeting will occur
    #
    # @example
    #   meeting.days #=> ['monday', 'wednesday', 'friday']
    #
    # @return [ Array<String> ] array of day names
    attr_reader :days

    # Returns the time the meeting will end
    # 
    # @example
    #   meeting.end_time #=> '8:55am'
    #
    # @return [ String ] a string representation of the end time
    attr_reader :end_time

    # Returns the time the meeting will begin
    # 
    # @example
    #   meeting.start_time #=> '8:05am'
    #
    # @return [ String ] a string representation of the start time
    attr_reader :start_time
  end
end
