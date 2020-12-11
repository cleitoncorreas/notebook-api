module V2
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate#, :author

    belongs_to :kind do
      link(:related) {v2_contact_kind_url(object.id)}
    end

    has_many :phones do
      link(:related) {v2_contact_phones_url(object.id)}
    end

    has_one :address do
      link(:related) {v2_contact_address_url(object.id)}
    end

    #link(:self) {contact_url(object.id)}
    #link(:kind) {kind_url(object.kind.id)}

   # def author
   #   "Cleiton Corrêa"
   # end

    meta do
      { author: "Cleiton Corrêa"}
    end

    def attributes(*args)
      h = super(*args)
      #h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
      h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
      h
    end
  end
end
