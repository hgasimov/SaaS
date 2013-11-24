class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    order = params[:order] == nil ? session[:order] : params[:order]   
    if order == "title" or order == "release_date"
      session[:order] = order
    end

    @all_ratings = Movie.all_ratings
    if params[:ratings] != nil and !params[:ratings].empty?
      @selected_ratings = session[:selected_ratings] = params[:ratings].keys      
    elsif session[:selected_ratings] != nil
      @selected_ratings = session[:selected_ratings]
    else
      @selected_ratings = @all_ratings
    end

    @movies = Movie.find(:all, :conditions => {:rating => @selected_ratings}, :order => order)
    #@movies = Movie.where(:rating => @selected_ratings).find(:all, :order => order)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
