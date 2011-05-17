class IncrCodeSearchController < ApplicationController
  unloadable

  def search
    @project = Project.find(params[:project_id])
    @repository = @project.repository
    cmd = "| git --git-dir #{@repository.url} ls-files"
    @files = []
    puts cmd
    open(cmd) do |io|
      io.each_line do |line|
        @files << line.chomp
      end     
    end
    @files
  end

end
