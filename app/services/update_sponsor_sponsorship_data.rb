class UpdateSponsorSponsorshipData

  def initialize(sponsor)
    @sponsor = sponsor
  end

  def call
    set_request_fulfilled
    set_active_sponsorship_count
  end

  private

  attr_reader :sponsor

  def set_request_fulfilled
    sponsor.request_fulfilled = is_request_fulfilled?
  end

  def is_request_fulfilled?
    sponsor.sponsorships.all_active.size >= sponsor.requested_orphan_count
  end

  def set_active_sponsorship_count
    sponsor.active_sponsorship_count = sponsor.sponsorships.all_active.size
  end
end
