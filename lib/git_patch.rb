module Redmine::Scm::Adapters    
  class GitAdapter < AbstractAdapter
    def all_files
      cmd = "#{GIT_BIN} --git-dir #{target('')} ls-files"
      files = []
      puts cmd
      shellout(cmd)  do |io|
        io.each_line do |line|
          files << line
        end     
      end
      files
    end
  end
end
