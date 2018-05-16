class PortfoliosController < ApplicationController
    layout "portfolio"
    
    
    def index
        @portfolio_items = Portfolio.all
        #@portfolio_items = Portfolio.ruby_on_rails_portfolio_items
        #@portfolio_items = Portfolio.angular
    end

    def angular
        @angular_portfolio_items=Portfolio.angular
    end

    def new
        @portfolio_item=Portfolio.new
        3.times {@portfolio_item.technologies.build}
    end

    def create
        @portfolio_item=Portfolio.new(portfolios_params)
        3.times {@portfolio_item.technologies.build}
        
        respond_to do |format|
            if @portfolio_item.save
              format.html { redirect_to portfolios_path, notice: 'Your portfolio item  is now live.' }
            else
              format.html { render :new }
            end
          end
    end
    
    def edit
        @portfolio_item = Portfolio.find(params[:id])
    end 

    def update
        @portfolio_item = Portfolio.find(params[:id])
        
        respond_to do |format|
            if @portfolio_item.update(portfolios_params)
                format.html { redirect_to portfolios_path, notice: 'portfolio was successfully updated.' }
                #format.json { render :show, status: :ok, location: @blog }
            else
                format.html { render :edit }
                #format.json { render json: @blog.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        @portfolio_item = Portfolio.find(params[:id])
    end

    def destroy
        #Perform the lookup
        @portfolio_item = Portfolio.find(params[:id])
        
        #Destroy/delete the recode
        @portfolio_item.destroy
        
        #Redirect
        respond_to do |format|
            format.html { redirect_to portfolios_url, notice: 'Record was successfully destroyed.' }
          end
    end


    private 
    def portfolios_params
        params.require(:portfolio).permit(:title, 
                                          :subtitle, 
                                          :body, 
                                          technologies_attributes: [:name]
                                         )
    end

end
