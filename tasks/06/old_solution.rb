module ArnoldCPM
  module Functions
    def listen_to_me_very_carefully(name)
      @function_name = name
    end
  end

  class Main

    attr_reader :variables

    def initialize(printer)
      @printer = printer
      @variables = {}
    end

    def talk_to_the_hand(value)
      @printer.print value
    end

    def its_showtime
      variables = {}
    end

    def get_to_the_chopper(var)
      @last_variable = var
    end

    def here_is_my_invitation(value)
      @last_value = value
    end

    def get_up(value)
      @last_value += value
    end

    def get_down(value)
      @last_value -= value
    end

    def youre_fired(value)
      @last_value *= value
    end

    def he_had_to_split(value)
      @last_value /= value
    end

    def i_let_him_go(value)
      @last_value %= value
    end

    def enough_talk
      variables[@last_variable] = @last_value
    end

    def method_missing(name)
      if variables[name]
        variables[name]
      else
        name
      end
    end
  end

  class << self
    attr_accessor :printer

    def totally_recall(&block)
      main = Main.new(printer)
      main.instance_eval(&block)
    end
  end
end





















# module ArnoldCPM
#   module Boolean
#     def i_lied
#       0
#     end
#
#     def no_problemo
#       1
#     end
#
#     def because_im_going_to_say_please(bool)
#       return if @skip_execution
#       @skip_execution = truethy?(bool)
#     end
#
#     def bull_shit
#       @skip_execution = !@skip_execution
#     end
#
#     def you_have_no_respect_for_logic
#       @skip_execution = false
#     end
#
#     private
#
#     def truethy?(value)
#       !(value == 0)
#     end
#   end
#
#   class Main
#     include Boolean
#
#     attr_reader :printer
#
#     def initialize
#       @printer = ArnoldCPM.printer
#       @skip_execution = false
#     end
#
#     def its_showtime
#       # TODO: Placeholder lol
#     end
#
#     def you_have_been_terminated
#       # TODO: probably since lazy to change self context
#       # gonna unset the instance vars
#     end
#
#     def get_to_the_chopper(variable)
#       return if @skip_execution
#       @last_variable = variable
#     end
#
#     def here_is_my_invitation(value)
#       return if @skip_execution
#       @last_value = process_value(value)
#     end
#
#     def enough_talk
#       return if @skip_execution
#       instance_eval do
#         instance_variable_set "@#{@last_variable}".to_sym, @last_value
#       end
#     end
#
#     def talk_to_the_hand(value)
#       return if @skip_execution
#       printer.print(process_value(value))
#     end
#
#     def method_missing(name)
#       name
#     end
#
#     def get_up(value)
#       return if @skip_execution
#       @last_value += process_value(value)
#     end
#
#     def get_down(value)
#       return if @skip_execution
#       @last_value -= process_value(value)
#     end
#
#     def youre_fired(value)
#       return if @skip_execution
#       @last_value *= process_value(value)
#     end
#
#     def he_had_to_split(value)
#       return if @skip_execution
#       @last_value /= process_value(value)
#     end
#
#     def i_let_him_go(value)
#       return if @skip_execution
#       @last_value %= process_value(value)
#     end
#
#     def process_value(value)
#       if value.is_a? Numeric
#         value
#       else
#         instance_variable_get "@#{value}".to_sym
#       end
#     end
#   end
#
#   class << self
#     attr_accessor :printer
#
#     def totally_recall(&block)
#       main = Main.new
#       main.instance_eval(&block)
#     end
#   end
#
