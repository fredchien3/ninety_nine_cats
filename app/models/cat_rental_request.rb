class CatRentalRequest < ApplicationRecord
  validates_presence_of :cat_id, :start_date, :end_date, :status
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status" }
  validate :end_after_start
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      overlapping_pending_requests.each { |request| request.deny! }
      self.status = "APPROVED"
      self.save!
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  def end_after_start
    errors.add(:end_date, 'can\'t come before start date') unless end_date >= start_date
  end

  def overlapping_requests
    CatRentalRequest.where.not('id = ?', self.id).where('cat_id = ?', self.cat_id).where.not('start_date > ? OR end_date < ?', self.end_date, self.start_date)
  end

  def overlapping_approved_requests
    self.overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    self.overlapping_requests.where("status = 'PENDING'")
  end

  def does_not_overlap_approved_request
    errors.add(:dates, 'can\'t overlap an already approved request') if self.overlapping_approved_requests.exists?
  end
end
