module Routes
  def self.url_helpers
    Rails.application.routes.url_helpers
  end

  def self.[](s)
    controller, action = s.split('#')

    opts = {
      :controller => controller,
      :action => action,
      :host => host
    }

    case action
      when "create", "update", "destroy", "show", "edit"
        ->(id) {
          url_helpers.url_for(opts.merge({:id => id}))
        }
        else
          url_helpers.url_for(opts)
    end
  end

  def self.host
    if ENV['RAILS_ENV'] == 'development'
      '192.168.0.13:3000'
    else
      'polar-scrubland-5755.herokuapp.com'
    end
  end
end
