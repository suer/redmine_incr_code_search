require 'redmine'

Redmine::Plugin.register :redmine_incr_code_search do
  name 'Redmine Incr Code Search plugin'
  author 'suer'
  description 'Incremental Code Search plugin'
  version '0.0.4'
  url 'https://github.com/suer/redmine_incr_code_search'
  author_url 'http://d.hatena.ne.jp/suer'

  project_module :incr_code_search do
    permission :incr_code_search, {:incr_code_search => [:search]}, :public => true
    menu :project_menu, :incr_code_search, {:controller => 'incr_code_search', :action => 'search'},
    :caption => :menu_caption, :param => :project_id
  end
end
