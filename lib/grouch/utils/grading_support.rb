require 'grouch/utils/enumerator_support'

module Grouch
  # The grading support module includes support for converting the grade basis
  # abbreviations in OSCAR to more human-readable formats
  # 
  # @author Dean Papastrat
  # @since 0.1.0
  module GradingSupport
    include EnumeratorSupport

    # A hash where the keys are valid grading basis letters and the values are
    # descriptions of those letters.
    VALID_LETTERS = {
      'a' => 'audit',
      'l' => 'letter grade',
      'p' => 'pass/fail'
    }

    # Converts a letter representing the grading basis to a human-readable name
    # 
    # Valid bases are:
    # - a: audit
    # - l: letter grade
    # - p: pass/fail
    # 
    # @param [ String ] letter to retrieve a basis for
    # 
    # @example
    #   GradingSupport.letter_to_basis('l') #=> 'letter grade'
    #
    # @raise [ ArgumentError ] when letter is not a string with a value of
    #   one of the following:
    #     [ "a", "l", "p" ]
    # @return [ String ] a human-readable basis, lowercased
    def self.letter_to_basis(letter)
      lowercase_letter = letter.to_s.downcase

      unless valid_basis_letter?(letter)
        raise ArgumentError, "'#{letter}'' is not a valid one-digit string."
      end

      return VALID_LETTERS[lowercase_letter]
    end

    # Converts multiple letters to human-readable grading bases
    # 
    # @param [ String, #map ] letters a string of letters or an object that
    #   responds to the 'map' method
    # 
    # @example
    #   letters = ['ap']
    #   GradingSupport.letters_to_days(letters) #=> [
    #     'audit',
    #     'pass/fail'
    #   ]
    #
    # @return [ Array<String> ] an array of human-readable grading bases
    def self.letters_to_bases(letters)
      return string_enumerator(letters)
        .map { |letter| letter_to_basis(letter) }
    end

    # Checks if a basis letter is valid
    # 
    # @param [ String ] letter a basis letter
    # 
    # @example Response given a valid basis letter
    #   GradingSupport.valid_basis_letter?('a') #=> true
    # 
    # @example Response given an invalid basis letter
    #   GradingSupport.valid_basis_letter?('b') #=> false
    # 
    # @return [ Boolean ]
    def self.valid_basis_letter?(letter)
      VALID_LETTERS.has_key?(letter)
    end

    # Checks if a string or array of basis letters are valid
    # 
    # @param [ String, Array<String> ] letters string or array of basis letters
    # 
    # @example Response given valid basis letters
    #   GradingSupport.valid_basis_letters?('lp') #=> true
    # 
    # @example Response given invalid basis letters
    #   GradingSupport.valid_basis_letters?('cd') #=> false
    #
    # @return [ Boolean ]
    def self.valid_basis_letters?(letters)
      string_enumerator(letters).all? { |letter| valid_basis_letter?(letter) }
    end
  end
end
