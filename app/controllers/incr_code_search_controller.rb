class IncrCodeSearchController < ApplicationController
  unloadable

  SUPPORT_SCMS = [ 
    Redmine::Scm::Adapters::GitAdapter, 
    Redmine::Scm::Adapters::SubversionAdapter,
    Redmine::Scm::Adapters::MercurialAdapter
  ]

  SEPARATOR = ': '

  def search
    @project = Project.find(params[:project_id])
    @scm_supported = scm_supported(@project)
    return unless @scm_supported
    @project.repository.fetch_changesets if not @project.repository.nil? and Setting.autofetch_changesets?
    @keyword = params[:keyword] || request.raw_post.split('&')[0]
  end

  def files
    @project = Project.find(params[:project_id])
    unless scm_supported(@project)
      render :json => '[]'
      return
    end
    @files = []
    @project.repositories.each do |repository|
      open("| #{cmd repository}") do |io|
        io.each_line {|line| @files << repository.name + SEPARATOR + line.chomp }     
      end
    end
    render :json => @files
  end

  private 
  def cmd(repository)
    case repository.scm
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
