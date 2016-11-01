require 'grouch/utils/grading_support'

module Grouch
  # The course entity represents a college course scraped from OSCAR.
  # 
  # @author Dean Papastrat <dean.g.papastrat@gmail.com>
  # @since 0.1.0
  class Course < Entity
    include Grouch::Utils::GradingSupport

    # Create a new course object with the given properties
    # 
    # @param [ String ] school the school the course is in
    # @param [ Integer ] number the course number
    # @param [ String ] name the name of the course
    # @param [ String ] semester the semester the course is meeting
    # @param [ Integer ] year the year the course is meeting
    # @param [ Integer ] hours how many hours of credit the course is worth
    # @param [ Array<Section> ] sections groupings of meetings for a course
    # @param [ String ] grade_basis how the course can be graded
    # @param [ Array<Restriction> ] restrictions course restrictions
    # @param [ Array<Requisite> ] prerequisites required prior courses
    # @param [ Array<Requisite> ] corequisites required simultaneous courses
    #
    # @return [ Course ] the newly created course
    def initialize(school, number, name, semester, year, hours, sections,
      grade_basis: nil, restrictions: nil, prerequisites: nil, 
      corequisites: nil)

      # Coerce data into our formats
      hours = hours.to_i
      grade_basis = grade_basis.downcase if grade_basis
      number = number.to_i
      school = school.downcase
      semester = semester.downcase
      year = year.to_i

      # TODO: Validate attributes

      # Set mandatory attributes
      @school, @number, @name = school, number, name
      @semester, @year, @hours = semester, year, hours
      @sections = sections

      # Set optional attributes
      @grade_basis, @restrictions = grade_basis, restrictions
      @prerequisites, @corequisites = prerequisites, corequisites
      return self
    end

    # Returns the name of the course
    #
    # @example
    #   course.name #=> 'Data Structures and Algorithms'
    #
    # @return [ String ]
    attr_reader :name

    # Returns the course number
    # 
    # @example
    #   course.number #=> 1332
    #
    # @return [ Integer ]
    attr_reader :number

    # Returns the school that the course is in
    #
    # @example
    #   course.school #=> 'cs'
    # 
    # @return [ String ]
    attr_reader :school

    # Returns the basis on which the course can be graded, generally
    # in ALP format
    # 
    # - 'a' stands for audit
    # - 'l' stands for letter grade
    # - 'p' stands for pass/fail
    #
    # @example
    #   course.grade_basis #=> 'a'
    #
    # @return [ Array<String> ]
    attr_reader :grade_basis

    # Returns the number of hours the course is worth
    # 
    # @example
    #   course.hours #=> 1.0
    #
    # @return [ Float ]
    attr_reader :hours

    # Returns the semester the course occurs during
    # 
    # This can be any of the following:
    # - spring
    # - summer
    # - fall
    # 
    # @example
    #   course.semester #=> 'fall'
    #
    # @return [ String ]
    attr_reader :semester

    # Returns the year the course occurs during
    # 
    # @example
    #   course.year #=> 2017
    #
    # @return [ Integer ]
    attr_reader :year

    # Returns corequisites for the course.
    # 
    # @return [ Array<Requisite> ]
    attr_reader :corequisites

    # Returns prerequisites for the course
    #
    # @return [ Array<Requisite> ]
    attr_reader :prerequisites

    # Returns restrictions for the course
    # 
    # @return [ Array<Restriction> ]
    attr_reader :restrictions

    # Returns sections for the course
    # 
    # @return [ Array<Section> ]
    attr_reader :sections

    # Returns the full name of the course, in more of a display-name format
    # 
    # @example
    #   course.full_name #=> 'CS 1332 - Data Structures and Algorithms'
    # 
    # @return [ String ]
    def full_name
      string = [@school.upcase, @number].join(" ")
      string += " - #{@name}" if string != "" && @name
      string = nil if string == ""

      return string
    end

    # Returns the grading bases in a human-readable format
    # 
    # The 3 types of grading bases that correspond with ALP are:
    # - audit
    # - letter grade
    # - pass/fail
    #
    # @example Single grading basis
    #   course.grade_basis #=> 'a'
    #   course.grading_formats #=> ['audit']
    # 
    # @example Multiple grading bases
    #   course.grade_basis #=> 'lp'
    #   course.grading_formats #=> ['letter grade', 'pass/fail']
    #
    # @return [ Array<String> ] an array of human-readable grading bases
    def grading_formats
      letters_to_bases(@grade_basis)
    end
  end
end
