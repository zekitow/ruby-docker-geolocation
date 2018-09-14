module Requests
  class BaseRequest
    include ActiveModel::Model

    #
    # Validates request and raise
    # error unless its valid.
    #
    def validate!
      raise BadRequestError.new(self.errors.full_messages.uniq.join(', ')) unless valid?
    end

    # Overwrite ActiveModel
    def persisted?
      false
    end

    #
    # Creates dynamic method for validation like "use_attribute?"
    # If the method exists at the instance, the method will be called.
    # If the method does not exists at the instance, the rule will be applied.
    #
    # Ex.: use_age?, user_price?
    #
    def method_missing(m, *args, &block)
      mtd = m.to_s
      return send("#{mtd.to_sym}") if respond_to? mtd

      if mtd.starts_with? 'use_' and mtd.ends_with? '?'
        attr = mtd.gsub(/use_/,'').gsub('?','')
        val = send("#{attr.to_sym}")
        return (not val.empty?) if val.kind_of?(Array)
        return (not val.blank?)
      else
        raise NoMethodError.new("Undefined method '#{m}'!")
      end
    end

  end
end