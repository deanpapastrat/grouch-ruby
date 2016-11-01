module Grouch
  module EnumeratorSupport
    # Creates a enumerator for each char in a string or each element in an
    # array.
    # 
    # @param [ String, #map ] enumerable a string of or an object that responds
    #   to the 'map' method
    # 
    # @example Standard response given a string
    #   letters = ['cat']
    #   letters_enumerator = EnumeratorSupport.string_enumerator(letters)
    #   letters_enumator.map(&:uppercase) #=> ['C', 'A', 'T']
    # 
    # @example Standard response given an array
    #   letters = ['d', 'o', 'g']
    #   letters_enumerator = EnumeratorSupport.string_enumerator(letters)
    #   letters_enumerator.map(&:uppercase) #=> ['D', 'O', 'G']
    # 
    # @example Standard response when given an array of strings
    #   words = ['dog', 'cat']
    #   words_enumerator = EnumeratorSupport.string_enumerator(letters)
    #   words_enumerator.map(&:uppercase) #=> ['DOG', 'CAT']
    # 
    # @example Standard response when given nil
    #   letters = []
    #   letters_enumerator = EnumeratorSupport.string_enumerator(letters)
    #   letters_enumerator.map(&:uppercase) #=> []
    # 
    # @example Error when not given a string or enumerable 
    #   numbers = 1332
    # 
    #   # Raises ArgumentError:
    #   numbers_enumerator = EnumeratorSupport.string_enumerator(numbers)
    # 
    # @raise [ ArgumentError ] when input is not mappable
    # @return [ Enumerable ]
    def self.string_enumerator(enumerable)
      return [] if enumerable.nil?
      if enumerable.class == String
        enumerable.each_char
      elsif enumerable.class.instance_methods.includes?(:map)
        enumerable
      else
        raise ArgumentError, "'#{enumerable.class}' is not mappable."
      end
    end
  end
end
