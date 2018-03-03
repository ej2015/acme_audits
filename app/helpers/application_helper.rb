module ApplicationHelper

  def bs_alert_class (k)
    case k
    when "notice"
      "alert-success"
    when "alert"
      "alert-warning"
    end
  end


end
