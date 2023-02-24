class ApplicationController < Sinatra::Base

  #set the Content_Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  #use the :id syntax to create a dynamic route
  get '/games/:id' do
    # #get allthe games from the database
    # games = Game.all.order(:title).limit(10)
    # #return a JSON response with an array of all the game data
    # games.to_json

    #look up the game in the database using its ID
    game = Game.find(params[:id])
    #send a JSON-formatted response of the game data
    #include associated reviews in the JSON response
    # game.to_json(include: { reviews: { include: :user } })

    #include associated revews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
