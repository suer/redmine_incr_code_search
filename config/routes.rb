ActionController::Routing::Routes.draw do |map|
  map.connect 'incr_code_search/:project_id/:action.:format', :controller => 'incr_code_search'
end
