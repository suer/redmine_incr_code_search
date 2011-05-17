ActionController::Routing::Routes.draw do |map|
  map.connect 'incr_code_search/:project_id/search', :controller => 'incr_code_search', :action => 'search'
end
