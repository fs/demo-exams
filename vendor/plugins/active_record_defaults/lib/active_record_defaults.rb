module ActiveRecord
  module Defaults
    def self.included(base)
      return if base.included_modules.include?(ActiveRecord::Defaults::InstanceMethods)
      
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
      
      base.send :alias_method, :initialize_without_defaults, :initialize
      base.send :alias_method, :initialize, :initialize_with_defaults
    end
    
    module ClassMethods
      # Define default values for attributes on new records. Requires a hash of <tt>attribute => value</tt> pairs, or a single attribute with an associated block.
      # If the value is a block, it will be called to retrieve the default value.
      # If the value is a symbol, a method by that name will be called on the object to retrieve the default value.
      # 
      # The following code demonstrates the different ways default values can be specified. Defaults are applied in the order they are defined.
      # 
      #   class Person < ActiveRecord::Base
      #     defaults :name => 'My name', :city => lambda { 'My city' }
      #     
      #     default :birthdate do |person|
      #       Date.today if person.wants_birthday_today?
      #     end
      #     
      #     default :favourite_colour => :default_favourite_colour
      #     
      #     def default_favourite_colour
      #       "Blue"
      #     end
      #   end
      # 
      # The <tt>defaults</tt> and the <tt>default</tt> methods behave the same way. Use whichever is appropriate.
      #
      # The default values are only used if the key is not present in the given attributes.
      # 
      #   p = Person.new
      #   p.name # "My name"
      #   p.city # "My city"
      #   
      #   p = Person.new(:name => nil)
      #   p.name # nil
      #   p.city # "My city"
      #
      # == Default values for belongs_to associations
      # 
      # Default values can also be specified for an association. For instance:
      #
      #   class Student < ActiveRecord::Base
      #     belongs_to :school
      #     default :school => lambda { School.new }
      #   end
      #
      # In this scenario, if a school_id was provided in the attributes hash, the default value for the association will be ignored:
      #
      #   s = Student.new
      #   s.school # => #<School: ...>
      # 
      #   s = Student.new(:school_id => nil)
      #   s.school # => nil
      #
      # Similarly, if a default value is specified for the foreign key and an object for the association is provided, the default foreign key is ignored.
      def defaults(defaults, &block)
        default_objects = case
          when defaults.is_a?(Hash)
            defaults.map { |attribute, value| Default.new(attribute, value) }
            
          when defaults.is_a?(Symbol) && block
            Default.new(defaults, block)
            
          else
            raise "pass either a hash of attribute/value pairs, or a single attribute with a block"
        end
        
        write_inheritable_array :attribute_defaults, [*default_objects]
      end
      
      alias_method :default, :defaults
    end
    
    module InstanceMethods
      def initialize_with_defaults(attributes = nil)
        initialize_without_defaults(attributes)
        apply_default_attribute_values(attributes)
        yield self if block_given?
      end
      
      def apply_default_attribute_values(attributes)
        attribute_keys = (attributes || {}).keys.map!(&:to_s)
        
        if attribute_defaults = self.class.read_inheritable_attribute(:attribute_defaults)
          attribute_defaults.each do |default|
            next if attribute_keys.include?(default.attribute)
            
            # Ignore a default value for association_id if association has been specified
            reflection = self.class.reflections[default.attribute.to_sym]
            if reflection and reflection.macro == :belongs_to and attribute_keys.include?(reflection.primary_key_name)
              next
            end
            
            # Ignore a default value for association if association_id has been specified
            reflection = self.class.reflections.values.find { |r| r.respond_to?(:primary_key_name) && r.primary_key_name == default.attribute }
            if reflection and reflection.macro == :belongs_to and attribute_keys.include?(reflection.name.to_s)
              next
            end
            
            send("#{default.attribute}=", default.value(self))
          end
        end
      end
    end
    
    class Default
      attr_reader :attribute
      
      def initialize(attribute, value)
        @attribute, @value = attribute.to_s, value
      end
      
      def value(record)
        if @value.is_a?(Symbol)
          record.send(@value)
        elsif @value.respond_to?(:call)
          @value.call(record)
        else
          @value.duplicable? ? @value.dup : @value
        end
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecord::Defaults
end
