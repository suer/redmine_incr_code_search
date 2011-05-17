require 'redmine'

Redmine::Plugin.register :redmine_incr_code_search do
  name 'Redmine Incr Code Search plugin'
  author 'Author name'
  description 'Incremental Code Search plugin'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://d.hatena.ne.jp/suer'

  permission :hello, {:incr_code_search => [:search]}, :public => true
  menu :project_menu, :incr_code_search, {:controller => 'incr_code_search', :action => 'search'},
  :caption => 'incr search', :param => :project_id
end
