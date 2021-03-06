$:.unshift(File.dirname(__FILE__))

module Wowr
  module Armory
    module Achievement
      autoload :Base,                      'achievement/base'
      autoload :Category,                  'achievement/category'
      autoload :CategoryDetails,           'achievement/category_details'
      autoload :CategoryDetailsWithPoints, 'achievement/category_details_with_points'
      autoload :CharacterInfo,             'achievement/character_info'
      autoload :Completed,                 'achievement/completed'
      autoload :List,                      'achievement/list'
    end
  end
end
