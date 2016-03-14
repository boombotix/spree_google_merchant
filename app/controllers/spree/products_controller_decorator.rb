module Spree
  ProductsController.class_eval do
    helper_method :manager, :include_variants?, :in_stock, :properties

    def google_merchant
      if include_variants?
        @items = full_variants
        @properties = GoogleMerchant::Manager.property_set(
          @items.collect(&:product).uniq.sort_by(&:id)
        )
      else
        @items = Product.active.includes(:variants)
        @properties = GoogleMerchant::Manager.property_set(@items)
      end
      respond_to do |format|
        format.any(:xml, :rss) { render formats: [:xml, :rss] }
      end
    end

    private

    def full_variants
      t1 = Variant.arel_table
      reflections = HashWithIndifferentAccess.new(Variant.reflections)
      t2_name = "#{reflections[:first_non_master].plural_name}_#{t1.name}"
      t2 = Arel::Table.new(t2_name)

      Variant.active.where(
        t1[:is_master].eq(false).or(t2[:id].eq(nil))
      ).includes(
        :product,
        :advertising_image,
        :default_price,
        :stock_items,
        :master,
        :first_non_master,
        {option_values: :option_type}
      ).references(t2_name)
    end

    def manager
      @manager ||= GoogleMerchant::Manager
    end

    def include_variants?
      manager.include_variants?
    end

    def in_stock
      @in_stock ||= Variant.in_stock.pluck(:id)
    end

    def properties
      @properties
    end
  end
end
