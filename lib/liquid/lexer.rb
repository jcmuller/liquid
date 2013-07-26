module Liquid
  class Token
    attr_accessor :type, :contents
    def initialize(*args)
      @type, @contents = args
    end

    def self.[](*args)
      Token.new(*args)
    end

    def inspect
      out = "<#{@type}"
      out << ": \'#{@contents}\'" if contents
      out << '>'
    end

    def to_s
      self.inspect
    end
  end

  class Lexer
    SPECIALS = {
      '|' => :pipe,
      '.' => :dot,
      ':' => :colon,
      ',' => :comma,
      '[' => :open_square,
      ']' => :close_square
    }
    IDENTIFIER = /[\w\-]+/
    SINGLE_STRING_LITERAL = /'[^\']*'/
    DOUBLE_STRING_LITERAL = /"[^\"]*"/
    INTEGER_LITERAL = /-?\d+/
    FLOAT_LITERAL = /-?\d+(?:\.\d+)?/

    def initialize(input)
      @ss = StringScanner.new(input)
    end

    def tokenize
      @output = []

      loop do
        tok = next_token
        unless tok
          @output << Token[:end_of_string]
          return @output
        end
        @output << tok
      end
    end

    def next_token
      consume_whitespace
      return if @ss.eos?
      
      case
      when t = @ss.scan(IDENTIFIER) then Token[:id, t]
      when t = @ss.scan(SINGLE_STRING_LITERAL) then Token[:string, t]
      when t = @ss.scan(DOUBLE_STRING_LITERAL) then Token[:string, t]
      when t = @ss.scan(INTEGER_LITERAL) then Token[:integer, t]
      when t = @ss.scan(FLOAT_LITERAL) then Token[:float, t]
      else
        c = @ss.getch
        if s = SPECIALS[c]
          return Token[s,c]
        end

        raise SyntaxError, "Unexpected character #{c}."
      end
    end

    def consume_whitespace
      @ss.skip(/\s*/)
    end
  end
end