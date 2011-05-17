class IncrCodeSearchController < ApplicationController
  unloadable

  def search
    @project = Project.find(params[:project_id])
    @repository = @project.repository
    @files = @repository.scm.all_files
  end

end
