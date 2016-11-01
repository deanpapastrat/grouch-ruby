require 'grouch/utils/enumerator_support'

module Grouch
  # The day support module includes support for converting the day
  # abbreviations in OSCAR to more standardized date formats
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  module DaySupport
    include EnumeratorSupport

    # A hash where the keys are valid grading basis letters and the values are
    # descriptions of those letters.
    VALID_LETTERS = {
      'm' => 'monday',
      't' => 'tuesday',
      'w' => 'wednesday',
      'r' => 'thursday',
      'f' => 'friday'
    }

    # Converts a letter representing the day to a full-length day name
    # 
    # Valid day letters are:
    # - m: Monday
    # - t: Tuesday
    # - w: Wednesday
    # - r: Thursday
    # - f: Friday
    # 
    # @param [ String ] letter to retrieve a day for
    # 
    # @example
    #   DaySupport.letter_to_day('m') #=> 'monday'
    #
    # @raise [ ArgumentError ] when letter is not a string with a value of
    #   one of the following:
    #     [ "m", "t", "w", "r", "f" ]
    # @return [ String ] a full-length day name, lowercased
    def self.letter_to_day(letter)
      lowercase_letter = letter.to_s.downcase
      case lowercase_letter
      when 'm'
        return 'monday'
      when 't'
        return 'tuesday'
      when 'w'
        return 'wednesday'
      when 'r'
        return 'thursday'
      when 'f'
        return 'friday'
      else
        raise ArgumentError, "'#{letter}'' is not a valid one-digit string."
      end
    end

    # Converts multiple letters to full-length day names
    # 
    # @param [ String, #map ] letters a string of letters or an object that
    #   responds to the 'map' method
    # 
    # @example
    #   letters = ['mwf']
    #   DaySupport.letters_to_days(letters) #=> [
    #     'monday',
    #     'wednesday',
    #     'friday'
    #   ]
    # 
    # @raise [ ArgumentError ] when letters is not mappable
    # @return [ Array<String> ] an array of full-length day names
    def self.letters_to_days(letters)
      return string_enumerator(letters).map { |letter| letter_to_day(letter) }
    end

    # Checks if a day letter is valid
    # 
    # @param [ String ] letter a basis letter
    # 
    # @example Response given a valid basis letter
    #   DaySupport.valid_basis_letter?('m') #=> true
    # 
    # @example Response given an invalid basis letter
    #   DaySupport.valid_basis_letter?('s') #=> false
    # 
    # @return [ Boolean ]
    def self.valid_day_letter?(letter)
      VALID_LETTERS.has_key?(letter)
    end

    # Checks if a string or array of day letters are valid
    # 
    # @param [ String, Array<String> ] letters string or array of day letters
    # 
    # @example Response given valid day letters
    #   DaySupport.valid_basis_letters?('mwf') #=> true
    # 
    # @example Response given invalid day letters
    #   DaySupport.valid_basis_letters?('su') #=> false
    #
    # @return [ Boolean ]
    def self.valid_day_letters?(letters)
      string_enumerator(letters).all? { |letter| valid_day_letter?(letter) }
    end
  end
end
