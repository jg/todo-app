# Routes['tasks#show'](12) -> /tasks/12
# Routes['tasks#index'] -> /tasks
# class Routes
#   extend Rails.application.routes.url_helpers
# 
# 
#   def [](s)
#     default_url_options[:host] = "localhost"
#     controller, action = s.split('#')
# 
#     case action
#       when "new", "index", "edit"
#         url_for(:controller => controller, :action => action)
#       when "create", "update", "destroy", "show"
#         ->(id){ url_for(:controller => controller, :action => action, :id => id) }
#     end
#   end
# end
#   class RootUrl
#     include ActionController::UrlFor
#     include Rails.application.routes.url_helpers
#
#     delegate :env, :request, :to => :controller
#
#     def initialize(controller)
#       @controller = controller
#       @url        = root_path # named route from the application.
#     end
#   end
