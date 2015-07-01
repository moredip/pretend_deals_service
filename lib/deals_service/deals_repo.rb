
module DealsService
  class Deal < Struct.new(:sku,:desc)
    def to_json(*args)
      puts self
      self.to_h.to_json(*args)
    end
  end

  class DealsRepo
    def deals
      [
        Deal.new('sweater','Warm up the winter months!'),
        Deal.new('jumpsuit','The 80s are BACK!'),
        Deal.new('tshirt','Buy 3, get 1 free!')
      ]
    end
  end
end
