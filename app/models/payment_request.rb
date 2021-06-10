class PaymentRequest < ApplicationRecord
  after_update :notify_contractor

  enum state: {
    pending: 0,
    accepted: 1,
    rejected: 2
  }

  def accept
  	update!(state: 'accepted')
  end

  def reject
  	update!(state: 'rejected')
  end

  def notify_contractor
  	::BUNNY_OBJECT.publish({id: id, state: state}.to_json)
  end
end
