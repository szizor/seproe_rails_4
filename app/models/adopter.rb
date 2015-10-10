class Adopter < ActiveRecord::Base
  has_many :adoption_requests
  has_many :contacts
  has_many :listings
  belongs_to :user
  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: true
  validates_presence_of :nombre, :telefono, :email, :giro, :domicilio, :if => :validate_required_fields_given_type
  mount_uploader :logo, ImageUploader
  mount_uploader :acta, GenericUploader
  mount_uploader :ife, GenericUploader
  mount_uploader :razon, GenericUploader

  def display_name
    if tipo == "moral"
      nombre
    else
      nombre #contacts.first && contacts.first.name
    end
  end

  def display_title
    if tipo == "moral"
      giro
    else
      contacts.first && contacts.first.title
    end
  end

  def display_phone
    if tipo == "moral"
      telefono
    else
      contacts.first && contacts.first.phone
    end
  end

  def display_email
    if tipo == "moral"
      email
    else
      contacts.first && contacts.first.email
    end
  end

  private
  def validate_required_fields_given_type
    tipo == "moral"
  end
end
