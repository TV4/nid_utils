# encoding: UTF-8
module NidUtils
  extend ActiveSupport::Concern

  included do
    I18n.backend.store_translations(:se_nid_utils, :i18n => {
    :transliterate => {
      :rule => {
          å: "å",
          ä: "ä",
          ö: "ö",
          Å: "Å",
          Ä: "Ä",
          Ö: "Ö",
          æ: "ä",
          ø: "ö",
          Æ: "Ä",
          Ø: "Ö"
        }}})
  end

  module ClassMethods
    def nid_case(text)
      return text unless text.present?
      text = normalize_chars(text)
      lower_case(text).gsub('_','-').gsub(' ','-').gsub(/[^0-9a-zåäö-]/, '').gsub(/-/, ' ').squish.gsub(/ /, '-')
    end

    def normalize_chars(string)
      return string unless string.present?
      I18n.backend.transliterate(:se_nid_utils,string)
    end

    def lower_case(text)
      return text unless text.present?
      text.tr('ÅÄÖ', 'åäö').downcase
    end
  end

  def nid_case(text)
    self.class.nid_case(text)
  end
end