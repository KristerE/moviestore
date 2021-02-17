class Api::V1::ArticlesController < ApplicationController

  def edit
    article=Article.find_by(article_number: params[:id])

    if article !=nil
      if article.update(update_params)
        render json: {status: 'SUCCESS', message:'Updated article ',data:article},status: :ok
      else
        render json: {status: 'ERROR', message:'Article not updated ',data:article},status: :unprocessable_entity
      end
    else
      render json: {status: 'ERROR', message:'Article not found ',error:'No article with article_number or name = ' + params[:id]},status: :not_found
    end
  end

  def show
    article = Article.where(article_number: params[:id])

    if article.count>0
    render json: {status: 'SUCCESS', message:'Loaded article ',data:article},status: :ok
    else
      render json: {status: 'EMPTY', message:"No article with article number:" + params[:id],data:article},status: :not_found
    end
  end

  def destroy
    article=Article.find_by(article_number: params[:id])

    if article
      article.destroy
      render json: {status: 'SUCCESS', message:'Article deleted',data:article},status: :ok
    else
      render json: {status: 'ERROR', message:'Article not found ',error:'No article with article_number = ' + params[:id]},status: :not_found
    end
  end

  def find_article
     # Databas View
     # Om id är Numerisk söker vi på artikelnummer, annars på eller del av namnet
    if params[:id].to_i>0
     article = ViewArticle.where(article_number: params[:id])
    else
      article=ViewArticle.where("name LIKE :query", query: "%#{params[:id]}%")
    end
    
    if article.count>0
    render json: {status: 'SUCCESS', message:'Loaded article ',data:article},status: :ok
    else
      render json: {status: 'EMPTY', message:"No article with article number or name like: " + params[:id],data:article},status: :not_found
    end
  end

  def create
    if(params.has_key?(:name) && params.has_key?(:category))
      new_nr=self.new_article_number
      params['article_number']=new_nr
      category=Category.find_by(category: params['category'])

      if category!=nil
        params['points']=category['points']
        params['price']=category['default_price']
        article=Article.new(article_params)
      else
        return render json: {status: 'ERROR', message:'No Category with id='+ params['category']},status: 400
      end
      
      if article.save
        render json: {status: 'SUCCESS', message:'Saved article ',data:article},status: :ok
      else
        render json: {status: 'ERROR', message:'Article not saved ',data:article},status: :unprocessable_entity
      end
    else
      render json: {status: 'ERROR', message:'Missing parameters: name, category'},status: :bad_request
    end
  end

  ### Private functions ###
  private

  def article_params
    
    params.permit( :article_number, :name, :category, :price, :points)
  end

  def update_params
    params.permit(:category, :price)
  end


  def new_article_number
    # Nästa lediga artikelnummer.
    if !Article.exists?
      return 1
    else
      sql="SELECT MIN(Main.article_number) + 1 AS new_article_number FROM articles Main LEFT OUTER JOIN articles Sub ON Main.article_number + 1 = Sub.article_number WHERE (Sub.article_number IS NULL) LIMIT 1"
      conn=Article.connection
      conn.select_value(sql)
    end
  end


end
