module Grouch
  # The day support module includes support for converting the day
  # abbreviations in OSCAR to more standardized date formats
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  module DaySupport
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
      if letters.class == String
        enumerator = letters.each_char
      elsif letters.class.instance_methods.includes?(:map)
        enumerator = letters
      else
        raise ArgumentError, "'#{letters.class}' is not mappable."
      end

      return enumerator.map { |letter| letter_to_day(letter) }
    end
  end
end
