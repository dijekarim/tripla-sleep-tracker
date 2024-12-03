class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out_after_clock_in, if: -> { clock_out.present? }

  private

  def clock_out_after_clock_in
    errors.add(:clock_out, "must be after clock_in") if clock_out < clock_in
  end
end
