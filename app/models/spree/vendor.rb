module Spree
  class Vendor < Spree::Base
    acts_as_paranoid

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    with_options dependent: :destroy do
      has_many :option_types
      has_many :products
      has_many :properties
      has_many :shipping_methods
      has_many :stock_locations
      has_many :variants
      has_many :vendor_users
    end

    has_many :users, through: :vendor_users

    after_create :create_stock_location

    state_machine :state, initial: :pending do
      event :activate do
        transition to: :active
      end

      event :block do
        transition to: :blocked
      end
    end

    self.whitelisted_ransackable_attributes = %w[name state]

    # e-commerce-yossi begin

    URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
    validates :show_website, :allow_blank => true,
      format: { with: URL_REGEXP, message: 'URL has invalid format' }

    # e-commerce-yossi end

    private

    def create_stock_location
      stock_locations.where(name: name, country: Spree::Country.default).first_or_create!
    end
  end
end
