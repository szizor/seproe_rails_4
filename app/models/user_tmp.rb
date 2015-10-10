class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :role_ids, :status, :adopter_attributes

  # has_and_belongs_to_many :roles
  #  accepts_nested_attributes_for :roles
  # has_many :videos
  # has_many :photos
  # has_one :adopter
  # has_many :adopters
  # has_many :moneys
  # has_many :questions, dependent: :destroy
  # has_many :responses, dependent: :destroy
  # has_many :images, dependent: :destroy
  # has_many :events, dependent: :destroy
  # has_many :money, dependent: :destroy
  # has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  # accepts_nested_attributes_for :adopter, allow_destroy: true
  #has_reputation :votes, source: {reputation: :votes, of: :listings}, aggregated_by: :sum

  validates_presence_of :username
  validates_uniqueness_of :username
  after_create :add_role, :send_confirmation

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def add_role
    unless self.roles.present?
      self.role_ids = [3]
    end
  end

  def voted_for?(listing)
    evaluations.where(target_type: listing.class.to_s, target_id: listing.id, value: 1.0).present?
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.avatar = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def send_confirmation
    # Send Welcome Mail after confirmation
    begin
      UserMailer.user_registration_confirmation(self).deliver
    rescue
    end
  end
end
