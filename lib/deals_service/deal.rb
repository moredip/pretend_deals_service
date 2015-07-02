module DealsService
  class Deal < Struct.new(:sku,:desc)
    def to_json(*args)
      self.to_h.to_json(*args)
    end
  end
end
