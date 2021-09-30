class PriceCalculatorService

    attr_reader :products

    def initialize(products = "")
        @products = products
    end

    def calculate
        products_array = @products.split("\n")
        total_price = calculate_total_price_before_tax(products_array)
        total_tax_rate = 0

        products_array.each do |product|
            total_tax_rate += calculate_individual_product_tax(product)
        end

        return total_price * (1 + total_tax_rate)
    end

    private

    def calculate_total_price_before_tax(products_array = [])
        total = 0
        products_array.each do |product|
            price = product[/(?<= at ).*/].to_f
            # Regexp used to grab everything in string after " at " in order to determine price
            # e.g. "1 book at 12.49" -> "12.49"

            total += price
        end

        return total
    end

    def calculate_individual_product_tax(product = "")
        total_tax_rate = 0
        if (!is_tax_exempt?(product))
            total_tax_rate += 0.10
        end

        if (is_imported?(product))
            total_tax_rate += 0.05
        end
        
        return total_tax_rate
    end

    def is_tax_exempt?(product = "")
        books = ["book"]
        foods = ["chocolate"]
        medical_products = ["pill"]

        books.each do |book|
            if (product.include?(book))
                return true 
            end
        end

        foods.each do |food|
            if (product.include?(food))
                return true 
            end
        end

        medical_products.each do |medical_product|
            if (product.include?(medical_product))
                return true 
            end
        end

        return false
    end

    def is_imported?(product = "")
        if (product.include?("imported"))
            return true

        else
            return false
        end 
    end
end