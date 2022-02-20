require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  COLORS = %w(white black brown calico)

  validates_presence_of :name, :color, :sex, :birth_date, :description
  
  validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validates :sex, length: { is: 1 }, inclusion: { in: %w(M F), message: "%{value} is not a valid sex" }

  def age
    today = Date.today
    birthday = self.birth_date

    days_old = (Date.today - self.birth_date).to_i
    return "#{days_old} days" if days_old <= 30

    months_old = days_old.days / 1.months
    return "#{months_old} months" if months_old <= 11

    years_old = days_old.days / 1.years
    return "#{years_old} years"
  end
end
