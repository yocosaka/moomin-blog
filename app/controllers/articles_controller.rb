class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :set_article, only: %i[show destroy edit update]

  def index
    @articles = Article.all
  end

  def show
    @comments = @article.comments
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Successfully #{@article.title} is created..."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = "Successfully #{@article.title} is updated..."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Successfully #{@article.title} is deleted..."
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
