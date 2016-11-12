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

    # Returns the number of seats available
    # 
    # @example
    #   meeting.seats_limit_count #=> 30
    #
    # @return [ Integer ] an integer representing the count
    attr_reader :seats_limit_count

    # Returns the number of taken seats
    # 
    # @example
    #   meeting.seats_taken_count #=> 0
    #
    # @return [ Integer ] an integer representing the count
    attr_reader :seats_taken_count

    # Returns the number of waitlist spots available
    # 
    # @example
    #   meeting.waitlist_limit_count #=> 15
    #
    # @return [ Integer ] an integer representing the count
    attr_reader :waitlist_limit_count

    # Returns the number of taken waitlist spots
    # 
    # @example
    #   meeting.waitlist_taken_count #=> 0
    #
    # @return [ Integer ] an integer representing the count
    attr_reader :seats_taken_count

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
      @_meeting_locations ||= @meetings.map(&:location)
    end

    # Returns the days the section will meet
    # 
    # @example
    #   section.meeting_days #=> ['monday', 'wednesday', 'friday']
    # 
    # @return [ Set<String> ] days of the week
    def meeting_days
      @_meeting_days ||=
        @meetings.each_with_object(Set.new) do |meeting, set|
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
      @_meeting_times ||= @meetings.reduce([]) do |memo, meeting|
        memo += meeting.times
      end
    end

    # The types of meetings that will occur, i.e., lecture or recitation
    # 
    # @example
    #   section.meeting_types #=> ['lecture']
    # 
    # @return [ Set<String> ] a set of meeting types
    def meeting_types
      @_meeting_types ||=
        @meetings.each_with_object(Set.new) do |meeting, set|
          set << meeting.type
        end
    end

    # Sets the number of seats available for the section.
    # 
    # @note Only use this for setting or updating counts via the scraper!
    #   This method is ONLY meant to be publicly used for projects that
    #   need to tap directly into Grouch's data structures for rapid section
    #   availability refreshing.
    # 
    # @param [ Integer ] seats_limit how many total seats are available
    # @param [ Integer ] seats_taken how many seats are already registered for
    # @param [ Integer ] waitlist_limit how many total waitlist spots there are
    # @param [ Integer ] waitlist_taken how many waitlist spots are filled
    # 
    # @return [ Void ]
    def set_counts(seats_limit: , seats_taken:, waitlist_limit: nil,
      waitlist_taken: nil)

      unless seats_limit.kind_of?(Integer)
        raise ArgumentError, 'seats_limit must be an integer.'
      end

      unless seats_taken.kind_of?(Integer)
        raise ArgumentError, 'seats_taken must be an integer.'
      end

      @seats_limit_count = seats_limit.to_i
      @seats_taken_count = seats_taken.to_i

      unless waitlist_limit.nil? || waitlist_limit.kind_of?(Integer)
        raise ArgumentError, 'waitlist_limit must be nil or an integer.'
      end

      unless waitlist_taken.nil? || waitlist_taken.kind_of?(Integer)
        raise ArgumentError, 'waitlist_taken must be nil or an integer.'
      end

      @waitlist_limit_count = waitlist_limit unless waitlist_limit.nil?
      @waitlist_taken_count = waitlist_taken unless waitlist_taken.nil?
      return nil
    end
  end
end
