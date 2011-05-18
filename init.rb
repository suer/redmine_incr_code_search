require 'redmine'

Redmine::Plugin.register :redmine_incr_code_search do
  name 'Redmine Incr Code Search plugin'
  author 'suer & mallowlabs in codefirst.org'
  description 'Incremental Code Search plugin'
  version '0.0.1'
  url 'https://github.com/codefirst/redmine_incr_code_search'
  author_url 'http://d.hatena.ne.jp/suer'

  permission :hello, {:incr_code_search => [:search]}, :public => true
  menu :project_menu, :incr_code_search, {:controller => 'incr_code_search', :action => 'search'},
  :caption => :menu_caption, :param => :project_id
end
