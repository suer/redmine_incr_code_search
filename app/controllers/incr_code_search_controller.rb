class IncrCodeSearchController < ApplicationController
  unloadable

  def search
    @project = Project.find(params[:project_id])
    @repository = @project.repository
    cmd = "| git --git-dir #{@repository.url} ls-files"
    @files = []

    @keyword = params[:keyword] || request.raw_post.split('&')[0]
    open(cmd) do |io|
      io.each_line do |line|
        @files << line.chomp if @keyword.blank? or /#{@keyword}/i =~ line
      end     
    end
    respond_to do |format|
      format.html { }
      format.json { render :json => @files }
    end
    render :layout => false if request.xhr?
  end

  def live_search
    search
  end

end
