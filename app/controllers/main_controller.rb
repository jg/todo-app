class MainController < ApplicationController
  def index
    json = CollectionJSON.generate_for(Routes['main#index']) do |builder|
      builder.add_link(Routes['tasks#index'], 'tasks')
    end.to_json

    respond_to do |format|
      format.json { render :json => json }
      format.html { render :json => json }
    end
  end
end
