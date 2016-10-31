module Grouch
  # The course entity represents a college course scraped from OSCAR.
  # 
  # @author Dean Papastrat <dean.g.papastrat@gmail.com>
  # @since 0.1.0
  class Course < Entity
    # Returns the name of the course
    #
    # @example
    #   course.name #=> "Data Structures and Algorithms"
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
    #   course.school #=> "cs"
    # 
    # @return [ String ]
    attr_reader :school

    # Returns the basis on which the course can be graded, generally
    # in ALP format
    # 
    # - "a" stands for audit
    # - "l" stands for letter grade
    # - "p" stands for pass/fail
    #
    # @example
    #   course.grade_basis #=> "a"
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
    #   course.semester #=> "fall"
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
    # @example Standard Response
    #   course.full_name #=> "CS 1332 - Data Structures and Algorithms"
    #
    # @example If only school and number are present
    #   course.full_name #=> "CS 1332"
    #
    # @example If only school and name are present
    #   course.full_name #=> "CS - Data Structures and Algorithms"
    #
    # @example If only number and name are present
    #   course.full_name #=> "1332 - Data Structures and Algorithms"
    #
    # @example If only school is present
    #   course.full_name #=> "CS"
    #
    # @example If only number is present
    #   course.full_name #=> "1332"
    #
    # @example If name is present
    #   course.full_name #=> "Data Structures and Algorithms"
    #
    # @example If name, number, and school are nil
    #   course.full_name #=> nil
    # 
    # @return [ String ]
    def full_name
    end

    # Returns the grading bases in a human-readable format
    # 
    # The 3 types of grading bases that correspond with ALP are:
    # - audit
    # - letter grade
    # - pass/fail
    #
    # @example Single grading basis
    #   course.grading_basis #=> "a"
    #   course.grading_formats #=> ["audit"]
    # 
    # @example Multiple grading bases
    #   course.grading_basis #=> "lp"
    #   course.grading_formats #=> ["letter grade", "pass/fail"]
    #
    # @return [ Array<String> ] an array of human-readable grading bases
    def grading_formats
    end
  end
end
