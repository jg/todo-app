module Routes
  def self.url_helpers
    Rails.application.routes.url_helpers
  end

  def self.[](s)
    controller, action = s.split('#')

    case action
      when "create", "update", "destroy", "show", "edit"
        ->(id) {
          url_helpers.url_for(:controller => controller,
                              :action => action,
                              :id => id,
                              :only_path => true)
        }
        else
          url_helpers.url_for(:controller => controller,
                              :action => action,
                              :only_path => true)
    end
  end
end
