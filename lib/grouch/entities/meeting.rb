require 'grouch/utils/day_support'

module Grouch
  # The meeting entity describes when a particular section is in session
  # and what will occur during that session.
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  class Meeting < Entity
    include Grouch::Utils::DaySupport

    # Creates a new meeting object
    # 
    # @param [ String ] instructor name of person who's leading the meeting
    # @param [ String ] days string of day letters supported by DaySupport
    # @param [ String ] start_time 12-hour time string for when meeting starts
    # @param [ String ] end_time 12-hour time string for when meeting ends
    # @param [ String ] type what type of meeting this is
    # @param [ String ] location building and room number for the meetong
    # 
    # @raise [ ArgumentError ] when an argument is nil
    # @raise [ ArgumentError ] when meetings does not contain meeting objects
    # 
    # @return [ Section ] the new section
    def initialize(instructor, days, start_time, end_time, type, location)

      args = [instructor, days, start_time, end_time, type, location]

      raise ArgumentError, 'All fields must be present.' if args.include?(nil)

      unless valid_day_letters?(days)
        raise ArgumentError, "Invalid days present in string: #{days}."
      end

      @instructor, @days = instructor, days
      @start_time, @end_time = start_time, end_time
      @type, @location = type, location

      return self
    end

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
    #   meeting.days #=> 'mwf'
    #
    # @return [ String ] string of day letters
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

    # Returns the names of the days that the meeting occurs on
    # 
    # @example
    #   meeting.day_names #=> ['monday', 'wednesday', 'friday']
    # 
    # @return [ Array<String> ] array of full-length day names
    def day_names
      @_day_names ||= letters_to_days(@days)
    end

    # Returns an array of hashes of the times that the meeting occurs
    # 
    # @example
    #   meeting.times #=> [
    #     {
    #       :day => 'monday',
    #       :end_time => '8:55am',
    #       :start_time => '8:05am'
    #     },
    #     {
    #       :day => 'wednesday',
    #       :end_time => '8:55am',
    #       :start_time => '8:05am'
    #     },
    #     {
    #       :day => 'friday',
    #       :end_time => '8:55am',
    #       :start_time => '8:05am'
    #     }
    #   ]
    # 
    # @return [ Array<Hash> ] an array with one hash per meeting that
    #   provides the start time, end time and day of week.
    # 
    #   The format looks like this:
    # 
    #     [
    #       {
    #         day: String,
    #         end_time: String,
    #         start_time: String
    #       }
    #     ]
    def times
      @_times ||= string_enumerator(@days).map do |day|
        {
          day: letter_to_day(day),
          end_time: @end_time,
          start_time: @start_time,
        }
      end
    end
  end
end
