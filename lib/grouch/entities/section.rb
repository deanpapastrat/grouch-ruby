require 'set'
require 'grouch/utils/day_support'
require 'grouch/utils/enumerator_support'

module Grouch
  # The section entity describes a certain group of meetings within a course
  # and who will be leading those meetings.
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  class Section < Entity
    include Grouch::Utils::EnumeratorSupport
    include Grouch::Utils::DaySupport

    # Creates a new section object
    # 
    # @param [ Integer ] crn unique id for the section for a semester
    # @param [ String ] identifier the unique per-course identifier
    # @param [ Array<String> ] instructors names of people teaching
    # @param [ Array<Meeting> ] meetings an array of meetings for the section
    # 
    # @raise [ ArgumentError ] when an argument is nil
    # @raise [ ArgumentError ] when meetings does not contain meeting objects
    # 
    # @return [ Section ] the new section
    def initialize(crn, identifier, instructors, meetings)
      meetings = meetings.to_a

      args = [crn, identifier, instructors, meetings]
      raise ArgumentError, 'All fields must be present.' if args.include?(nil)

      unless meetings.all? { |meeting| meeting.instance_of?(Grouch::Meeting)}
        raise ArgumentError, 'Meetings argument must contain meeting objects.'
      end

      @crn, @identifier = crn, identifier
      @instructors, @meetings = instructors, meetings

      return self
    end

    # Returns a unique per-semester identifier for the section across all
    # sections for a particular semester
    #
    # @example
    #   course.crn #=> 30062
    #
    # @return [ Integer ] an integer representing the section crn
    attr_reader :crn

    # Returns a unique-per course and semester identifier for the section
    # across all sections in a particular semester for a course
    #
    # @example
    #   course.identifier #=> 'K1'
    #
    # @return [ String ] a string representing the section identifier
    attr_reader :identifier

    # Returns the names of the instructors leading the section
    #
    # @example
    #   course.instructors #=> ['Monica Sweat']
    #
    # @return [ Array<String> ] an array of instructor names
    attr_reader :instructors

    # Returns meetings for the section
    #
    # @return [ Array<Meeting> ] an array of meetings
    attr_reader :meetings

    # Returns the places where the section will meet
    #
    # @example
    #   section.meeting_locations #=> [
    #     'Clough Undergraduate Commons 102',
    #     'Instructional Center 204'
    #   ]
    # 
    # @return [ Array<String> ] an array of the locations as strings
    def meeting_locations
      return @cached_meeting_locations if @cached_meeting_locations

      @meetings.map(&:location)
    end

    # Returns the days the section will meet
    # 
    # @example
    #   section.meeting_days #=> ['monday', 'wednesday', 'friday']
    # 
    # @return [ Set<String> ] days of the week
    def meeting_days
      return @cached_meeting_days if @cached_meeting_days

      @cached_meeting_days = @meetings.each_with_object(Set.new) do |meeting, set|
        string_enumerator(meeting.days).each do |day|
          set << letter_to_day(day)
        end
      end
    end

    # Returns the times the section will meet during the week
    # 
    # @example
    #   section.meeting_times #=> [
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
    #       :day => 'wednesday',
    #       :end_time => '5:35pm',
    #       :start_time => '6:55pm'
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
    def meeting_times
      return @cached_meeting_times if @cached_meeting_times
      @cached_meeting_times = @meetings.reduce([]) do |memo, meeting|
        days = string_enumerator(meeting.days).map do |day|
          {
            day: letter_to_day(day),
            end_time: meeting.end_time,
            start_time: meeting.start_time,
          }
        end
        memo += days
      end
    end

    # The types of meetings that will occur, i.e., lecture or recitation
    # 
    # @example
    #   section.meeting_types #=> ['lecture']
    # 
    # @return [ Set<String> ] a set of meeting types
    def meeting_types
      return @cached_meeting_types if @cached_meeting_types
      @cached_meeting_types =
        @meetings.each_with_object(Set.new) do |meeting, set|
          set << meeting.type
        end
    end
  end
end
