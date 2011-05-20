class IncrCodeSearchController < ApplicationController
  unloadable

  SUPPORT_SCMS = [ 
    Redmine::Scm::Adapters::GitAdapter, 
    Redmine::Scm::Adapters::SubversionAdapter,
    Redmine::Scm::Adapters::MercurialAdapter
  ]


  def search

    @project = Project.find(params[:project_id])
    @scm_supported = scm_supported(@project)
    return unless @scm_supported
    @keyword = params[:keyword] || request.raw_post.split('&')[0]
  end

  def files
    @project = Project.find(params[:project_id])
    unless scm_supported(@project)
      render :json => '[]'
      return
    end
    @files = []
    open("| #{cmd}") do |io|
      io.each_line {|line| @files << line.chomp }     
    end
    render :json => @files
  end

  private 
  def cmd
    case @project.repository.scm
    when Redmine::Scm::Adapters::GitAdapter
      "git --git-dir #{@project.repository.url}  ls-tree -r --name-only HEAD:"
    when Redmine::Scm::Adapters::SubversionAdapter
      "svn ls -R #{@project.repository.url}"
    when Redmine::Scm::Adapters::MercurialAdapter
      "hg locate -R #{@project.repository.url}"
    end
  end
  
  def scm_supported(project)
    not project.repository.nil? and SUPPORT_SCMS.include?(@project.repository.scm.class)
  end
end
