# encoding: UTF-8
require "spec_helper"
include NidUtils

class NidCaser
  include NidUtils
end

describe "nid" do

  context "nid should be created with lower case and space replaced with dash" do

    it "should change space to dash" do
      expect(NidCaser.nid_case('foo bar bee')).to eq 'foo-bar-bee'
    end

    it "should nid_case nil to nil" do
      expect(nid_case(nil)).to be_nil
    end

    it "should nid_case '' to ''" do
      expect(nid_case('')).to eq ''
    end

    it "should downcase all chars" do
      expect(nid_case('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ')).to eq 'abcdefghijklmnopqrstuvwxyzåäö'
    end

    it "should all all chars not of the type a-z, åäö, -, 0-9" do
      expect(nid_case("kale8^79'0-")).to eq 'kale8790'
    end

    it "should convert diacritical characters" do
      expect(nid_case('Dürén Ibrahimović')).to eq 'duren-ibrahimovic'
    end

    it 'preserves åäö ÅÄÖ' do
      expect(nid_case('ÅÄÖåäö')).to eq 'åäöåäö'
    end

    it 'converts `¨´^' do
      expect(nid_case("ÈÉËÊèéëê")).to eq 'eeeeeeee'
      expect(nid_case("ÀÁÂàáâ")).to eq 'aaaaaa'
      expect(nid_case("Üü")).to eq 'uu'
      expect(nid_case("ČĆÇčćç")).to eq 'cccccc'
      expect(nid_case("Ññ")).to eq 'nn'
      expect(nid_case("Ïï")).to eq 'ii'
      expect(nid_case("ÆØæø")).to eq 'äöäö'
    end

    it "converts _ to -" do
      expect(nid_case("Let's_Dance")).to eq 'lets-dance'
    end

    it 'removes -- from name' do
      expect(nid_case("Let's -- da-da-dance")).to eq 'lets-da-da-dance'
    end

    it 'removes surrounding and double space from name and tag' do
      expect(nid_case(" Fångarna     på  fortet   ")).to eq 'fångarna-på-fortet'
    end

    it 'converts ISO input to UTF-8' do
      iso_encoded_nid = 'nöje'.encode('ISO-8859-1', 'UTF-8')
      expect(iso_encoded_nid.encoding.name).to eq 'ISO-8859-1'
      nid_cased_nid = nid_case(iso_encoded_nid)
      expect(nid_cased_nid.encoding.name).to eq 'UTF-8'
      expect(nid_cased_nid).to eq 'nöje'
    end
  end

  context "can determine that some things aren't nids" do
    it "accepts nothingness" do
      expect(possible_nid?('')).to be_true
      expect(possible_nid?(nil)).to be_true
    end

    it "accepts åäö" do
      expect(possible_nid?('räksmörgås')).to be_true
    end

    it "rejects strange letters" do
      expect(possible_nid?('dürén-ibrahimović')).to be_false
    end

    it "rejects non-letters" do
      expect(possible_nid?('foo bar')).to be_false
      expect(possible_nid?('foo/bar')).to be_false
      expect(possible_nid?('foo\n')).to be_false
    end

    it "rejects upper-case letters" do
      possible_nid?('FOO').should be_false
    end
  end
end
