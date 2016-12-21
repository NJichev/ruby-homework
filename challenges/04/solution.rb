class DrunkProxy < BasicObject
  attr_reader :objects

  def initialize(objects)
    @objects = objects
  end

  def method_missing(name, *args)
    mapped = objects.select { |o| o.respond_to? name }
                    .map { |o| o.send name, *args }

    mapped.empty? ? super : mapped
  end
end
