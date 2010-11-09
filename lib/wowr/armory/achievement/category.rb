module Wowr
  module Armory
    module Achievement
      class Category
        attr_reader :name
        attr_reader :subcategories
        attr_reader :id
        attr_writer :parent
        def initialize category
          @name = category['name']
          @id = category['id'].to_i if category['id']
          @subcategories = Array.new
        end

        def add_subcategory category
          @subcategories << category
          category.parent = self
        end
      end
    end
  end
end
