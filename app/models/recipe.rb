class Recipe < ActiveRecord::Base
    validates_presence_of :name, :batch_size, :description, :procedure
    #validates_inclusion_of :mash_type, :in => [:extract, :grain, :partial]

    def mash_type
        mash_type = nil
        if not @mash_type.nil?
            mash_type = @mash_type.to_sym
        end
        mash_type
    end

    def mash_type= (value)
      write_attribute(:mash_type, value.to_s)
    end
end
