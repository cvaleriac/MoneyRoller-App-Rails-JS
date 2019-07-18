class Rollover < ActiveRecord::Base
    belongs_to :user
    belongs_to :institution

    accepts_nested_attributes_for :institution, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true

    validates :amount, presence: true
    validates :origin, presence: true
    validates :institution, presence: true

    scope :order_by_amount, -> {order(:amount)}
    scope :by_user, -> (current_user) {where('user_id = ?', current_user.id)}   
    
    
    scope :outgoing, -> {where(:rollover_type => 'Outgoing')}
    scope :incoming, -> {where(rollover_type: "Incoming")}



end