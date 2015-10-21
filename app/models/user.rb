class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
          :registerable, 
          :omniauthable,
          :recoverable, 
          :rememberable, 
          :trackable
  #        :validatable, :authentication_keys => [:username]

  #has_and_belongs_to_many :roles

  belongs_to :role
  belongs_to :account

  has_many :videos
  has_many :photos
  has_one :adopter
  has_many :adopters
  has_many :moneys
  has_many :questions, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :money, dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source
  accepts_nested_attributes_for :adopter, allow_destroy: true
  #has_reputation :votes, source: {reputation: :votes, of: :listings}, aggregated_by: :sum

  #validates_presence_of :username
  #validates_uniqueness_of :username
  #after_create :add_role#, :send_confirmation

  #validates :account_id, presence: true, if: Proc.new{ |u| !u.super_admin?}

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true


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

  #def self.from_omniauth(auth)
  #  where(auth.slice(:provider, :uid)).first_or_create do |user|
  #    user.provider = auth.provider
  #    user.uid = auth.uid
  #    user.username = auth.info.nickname
  #    user.avatar = auth.info.image
  #  end
  #end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.avatar = auth.info.image
    end
  end


  def self.find_for_authentication(warden_conditions)
     if warden_conditions[:subdomain].present?
       joins(:account).where(
            "(email = ? AND "+
            "role_id != ? AND "+
            "accounts.subdomain = ?)",
            warden_conditions[:email],
            Role.find_by_name("Super Administrador").id,
            warden_conditions[:subdomain]
       ).first
     else
        where(
          "(email = ? AND "+
          "role_id = ?)",
          warden_conditions[:email],
          Role.find_by_name("Super Administrador").id
        ).first      
     end
  end


  #def self.new_with_session(params, session)
  #  if session["devise.user_attributes"]
  #    new(session["devise.user_attributes"], without_protection: true) do |user|
  #      user.attributes = params
  #      user.valid?
  #    end
  #  else
  #    super
  #  end
  #end

  def adoptant?
    role.name == "Adoptante" rescue "N/A"
  end

  def super_admin?
    role.name == "Super Administrador" rescue "N/A"
  end

  def admin?
    role.name == "Administrador" rescue "N/A"
  end

  def display_account
    account.name rescue "N/A"
  end

  protected

      def password_required?
        !persisted? || !password.nil? || !password_confirmation.nil?
      end

      def email_required?
        true
      end


  #def password_required?
  #  super && provider.blank?
  #end
  #def update_with_password(params, *options)
  #  if encrypted_password.blank?
  #    update_attributes(params, *options)
  #  else
  #    super
  #  end
  #end
  #def send_confirmation
  #  # Send Welcome Mail after confirmation
  #  begin
  #    UserMailer.user_registration_confirmation(self).deliver
  #  rescue
  #  end
  #end

end
