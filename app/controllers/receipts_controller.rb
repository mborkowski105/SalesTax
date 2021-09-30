class ReceiptsController < ApplicationController
    def index
    end

    def result
        price_calculator_service = PriceCalculatorService.new(params[:query])
        @result = price_calculator_service.calculate

        respond_to do |format|
            format.html {redirect_to index_path}
            format.js
        end
    end
end
