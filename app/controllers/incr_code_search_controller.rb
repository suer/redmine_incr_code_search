class IncrCodeSearchController < ApplicationController
  unloadable

  def search
    @project = Project.find(params[:project_id])
    return if @project.repository.nil? or @project.repository.scm.class != Redmine::Scm::Adapters::GitAdapter
    @keyword = params[:keyword] || request.raw_post.split('&')[0]
  end

  def files
    @project = Project.find(params[:project_id])
    if @project.repository.nil? or @project.repository.scm.class != Redmine::Scm::Adapters::GitAdapter
      render :json => []
    end
    @files = []
    open("| git --git-dir #{@project.repository.url} ls-tree -r --name-only HEAD:") do |io|
      io.each_line {|line| @files << line.chomp }     
    end
    render :json => @files
  end

end
