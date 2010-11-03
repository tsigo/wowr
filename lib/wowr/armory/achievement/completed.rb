module Wowr
  module Armory
    module Achievement
      class Completed < Wowr::Armory::Achievement::Base
        attr_reader :date_completed
        def initialize achievement
          super(achievement)
          @date_completed = achievement['dateCompleted']
          begin
            @date_completed   = achievement[:dateCompleted] == "" ? nil : DateTime.parse(achievement[:dateCompleted])
          rescue
            @date_completed   = achievement[:dateCompleted] == "" ? nil : achievement[:dateCompleted]
          end
        end
      end
    end
  end
end
