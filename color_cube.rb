class CoffeeHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/templates/coffee'

  get "/coffee/*.js" do
      filename = params[:splat].first
      coffee filename.to_sym
  end
end

class ColorCube < Sinatra::Base
  use CoffeeHandler

  get "/" do
    slim :index
  end
end

