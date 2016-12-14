class DrunkProxy < BasicObject
  attr_reader :objects

  def initialize(objects)
    @objects = objects
  end

  def method_missing(name, *_)
    mapped = objects.select { |o| o.respond_to? name }
                    .map(&name)

    mapped.empty? ? super : mapped
  end
end
