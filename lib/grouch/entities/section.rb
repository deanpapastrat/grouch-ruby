module Grouch
  # The section entity describes a certain group of meetings within a course
  # and who will be leading those meetings.
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  class Section < Entity
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
    #   section.locations #=> ['Clough Undergraduate Commons 102', 'Instructional Center 204']
    # 
    # @return [ Array<String> ] an array of the locations as strings
    def locations
    end

    # Returns the days the section will meet
    # 
    # @example
    #   section.meeting_days #=> ['monday', 'wednesday', 'friday']
    # 
    # @return [ Set<String> ] days of the week
    def meeting_days
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
    end

    # The types of meetings that will occur, i.e., lecture or recitation
    # 
    # @example
    #   section.meeting_types #=> ['lecture']
    # 
    # @return [ Set<String> ] a set of meeting types
    def meeting_types
    end
  end
end
