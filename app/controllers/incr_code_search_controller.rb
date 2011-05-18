class IncrCodeSearchController < ApplicationController
  unloadable

  def search
    @project = Project.find(params[:project_id])
    @repository = @project.repository
    cmd = "| git --git-dir #{@repository.url} ls-tree -r HEAD:"
    @files = []

    @keyword = params[:keyword] || request.raw_post.split('&')[0]
    valid = true
    begin
      Regexp.new(@keyword) 
    rescue RegexpError
      valid = false
    end
    open(cmd) do |io|
      io.each_line do |line|
        @files << line.split(" ")[-1].chomp if @keyword.blank? or (valid and /#{@keyword}/i =~ line.split(" ")[-1])
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
