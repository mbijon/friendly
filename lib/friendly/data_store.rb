module Friendly
  class DataStore
    attr_reader :database

    def initialize(database)
      @database = database
    end

    def insert(persistable, attributes)
      dataset(persistable).insert(attributes)
    end

    def all(persistable, query)
      filtered = dataset(persistable).where(query.conditions)
      if query.limit || query.offset
        filtered = filtered.limit(query.limit, query.offset)
      end
      filtered = filtered.order(query.order) if query.order
      filtered.map
    end

    def first(persistable, query)
      dataset(persistable).first(query.conditions)
    end

    def update(persistable, id, attributes)
      dataset(persistable).where(:id => id).update(attributes)
    end

    def delete(persistable, id)
      dataset(persistable).where(:id => id).delete
    end

    protected
      def dataset(persistable)
        database.from(persistable.table_name)
      end
  end
end
