# encoding: UTF-8
module NidUtils
  ########## 
  # taken from i18n gem and patch with:
  #
  #  å: "å",
  #  ä: "ä",
  #  ö: "ö",
  #  Å: "Å",
  #  Ä: "Ä",
  #  Ö: "Ö",
  #  æ: "ä",
  #  ø: "ö",
  #  Æ: "Ä",
  #  Ø: "Ö"
  #
  ########## 

  DEFAULT_REPLACEMENT_CHAR = "?"

  # A transliterator which accepts a Hash of characters as its translation
  # rule.
  DEFAULT_APPROXIMATIONS = {
    "À"=>"A", "Á"=>"A", "Â"=>"A", "Ã"=>"A", "Ä"=>"Ä", "Å"=>"Å", "Æ"=>"Ä",
    "Ç"=>"C", "È"=>"E", "É"=>"E", "Ê"=>"E", "Ë"=>"E", "Ì"=>"I", "Í"=>"I",
    "Î"=>"I", "Ï"=>"I", "Ð"=>"D", "Ñ"=>"N", "Ò"=>"O", "Ó"=>"O", "Ô"=>"O",
    "Õ"=>"O", "Ö"=>"Ö", "×"=>"x", "Ø"=>"Ö", "Ù"=>"U", "Ú"=>"U", "Û"=>"U",
    "Ü"=>"U", "Ý"=>"Y", "Þ"=>"Th", "ß"=>"ss", "à"=>"a", "á"=>"a", "â"=>"a",
    "ã"=>"a", "ä"=>"ä", "å"=>"å", "æ"=>"ä", "ç"=>"c", "è"=>"e", "é"=>"e",
    "ê"=>"e", "ë"=>"e", "ì"=>"i", "í"=>"i", "î"=>"i", "ï"=>"i", "ð"=>"d",
    "ñ"=>"n", "ò"=>"o", "ó"=>"o", "ô"=>"o", "õ"=>"o", "ö"=>"ö", "ø"=>"ö",
    "ù"=>"u", "ú"=>"u", "û"=>"u", "ü"=>"u", "ý"=>"y", "þ"=>"th", "ÿ"=>"y",
    "Ā"=>"A", "ā"=>"a", "Ă"=>"A", "ă"=>"a", "Ą"=>"A", "ą"=>"a", "Ć"=>"C",
    "ć"=>"c", "Ĉ"=>"C", "ĉ"=>"c", "Ċ"=>"C", "ċ"=>"c", "Č"=>"C", "č"=>"c",
    "Ď"=>"D", "ď"=>"d", "Đ"=>"D", "đ"=>"d", "Ē"=>"E", "ē"=>"e", "Ĕ"=>"E",
    "ĕ"=>"e", "Ė"=>"E", "ė"=>"e", "Ę"=>"E", "ę"=>"e", "Ě"=>"E", "ě"=>"e",
    "Ĝ"=>"G", "ĝ"=>"g", "Ğ"=>"G", "ğ"=>"g", "Ġ"=>"G", "ġ"=>"g", "Ģ"=>"G",
    "ģ"=>"g", "Ĥ"=>"H", "ĥ"=>"h", "Ħ"=>"H", "ħ"=>"h", "Ĩ"=>"I", "ĩ"=>"i",
    "Ī"=>"I", "ī"=>"i", "Ĭ"=>"I", "ĭ"=>"i", "Į"=>"I", "į"=>"i", "İ"=>"I",
    "ı"=>"i", "Ĳ"=>"IJ", "ĳ"=>"ij", "Ĵ"=>"J", "ĵ"=>"j", "Ķ"=>"K", "ķ"=>"k",
    "ĸ"=>"k", "Ĺ"=>"L", "ĺ"=>"l", "Ļ"=>"L", "ļ"=>"l", "Ľ"=>"L", "ľ"=>"l",
    "Ŀ"=>"L", "ŀ"=>"l", "Ł"=>"L", "ł"=>"l", "Ń"=>"N", "ń"=>"n", "Ņ"=>"N",
    "ņ"=>"n", "Ň"=>"N", "ň"=>"n", "ŉ"=>"'n", "Ŋ"=>"NG", "ŋ"=>"ng",
    "Ō"=>"O", "ō"=>"o", "Ŏ"=>"O", "ŏ"=>"o", "Ő"=>"O", "ő"=>"o", "Œ"=>"OE",
    "œ"=>"oe", "Ŕ"=>"R", "ŕ"=>"r", "Ŗ"=>"R", "ŗ"=>"r", "Ř"=>"R", "ř"=>"r",
    "Ś"=>"S", "ś"=>"s", "Ŝ"=>"S", "ŝ"=>"s", "Ş"=>"S", "ş"=>"s", "Š"=>"S",
    "š"=>"s", "Ţ"=>"T", "ţ"=>"t", "Ť"=>"T", "ť"=>"t", "Ŧ"=>"T", "ŧ"=>"t",
    "Ũ"=>"U", "ũ"=>"u", "Ū"=>"U", "ū"=>"u", "Ŭ"=>"U", "ŭ"=>"u", "Ů"=>"U",
    "ů"=>"u", "Ű"=>"U", "ű"=>"u", "Ų"=>"U", "ų"=>"u", "Ŵ"=>"W", "ŵ"=>"w",
    "Ŷ"=>"Y", "ŷ"=>"y", "Ÿ"=>"Y", "Ź"=>"Z", "ź"=>"z", "Ż"=>"Z", "ż"=>"z",
    "Ž"=>"Z", "ž"=>"z"
  }

  UNWANTED_CHARACTERS_PATTERN = /[^0-9a-zåäö-]/

  def self.included(base)
    base.extend(ClassMethods)
  end

  def nid_case(text)
    self.class.nid_case(text)
  end

  def possible_nid?(candidate)
    self.class.possible_nid?(candidate)
  end

  module ClassMethods

    def nid_case(text)
      return text unless present?(text)
      text = normalize_chars(text)
      squish(lower_case(text).gsub('_','-').gsub(' ','-').gsub(UNWANTED_CHARACTERS_PATTERN, '').gsub(/-/, ' ')).gsub(/ /, '-')
    end

    def possible_nid?(candidate)
      return true if candidate.nil?
      !(candidate =~ UNWANTED_CHARACTERS_PATTERN)
    end

    def lower_case(text)
      return text unless present?(text)
      text.tr('ÅÄÖ', 'åäö').downcase
    end

    private

    def normalize_chars(text)
      return text unless present?(text)
      transliterate(text)
    end

    def transliterate(string)
      string.gsub(/[^\x00-\x7f]/u) do |char|
        DEFAULT_APPROXIMATIONS[char] || DEFAULT_REPLACEMENT_CHAR
      end
    end

    #let's take some more methods from rails!
    # from activesupport/core_ext/boject/blank.rb
    def blank?(text)
      text.respond_to?(:empty?) ? text.empty? : !text
    end

    # An object is present if it's not <tt>blank?</tt>.
    def present?(text)
      !blank?(text)
    end

    #and from activesupport/core_ext/string/filter.rb
    def squish(text)
      squish!(text.dup)
    end

    # Performs a destructive squish. See String#squish.
    def squish!(text)
      text.strip!
      text.gsub!(/\s+/, ' ')
      text
    end
  end

end
