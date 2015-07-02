class SnippetsController < ApplicationController

  def index
    if params[:search].present?
      @snippets = Snippet.search(params[:search]).without_private_snippet.page params[:page]
    else
      @snippets = Snippet.without_private_snippet.page params[:page]
    end
    respond_to do |format|
      format.json
      format.json { render json: @snippets, status: 'success' }
    end
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    respond_to do |format|
      if @snippet.save
        @snippet.update_attributes(share_url: snippet_url(@snippet)) if @snippet.is_private?
        format.html { redirect_to snippet_path(@snippet), notice: 'Snippet successfully created!' }
        format.json { render json: @snippet, status: 'success' }
      else
        format.html { render action: "new" }
        format.json { render json: @snippet.errors, status: 'fail' }
      end
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
    respond_to do |format|
      format.html{}
      format.json { render json: @snippet, status: 'success' }
    end
  end

  protected

  def snippet_params
    params.require(:snippet).permit(:description, :is_private, :share_url)
  end

end
