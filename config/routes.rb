%w(search files).each do |action|
  get "incr_code_search/#{action}(.:format)", controller: 'incr_code_search', action: action
end
