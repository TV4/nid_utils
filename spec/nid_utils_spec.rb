# encoding: UTF-8
require "spec_helper"
include NidUtils

class NidCaser
  include NidUtils
end

describe "nid" do

  context "nid should be created with lower case and space replaced with dash" do

    it "should change space to dash" do
      NidCaser.nid_case('foo bar bee').should == 'foo-bar-bee'
    end

    it "should nid_case nil to nil" do
      nid_case(nil).should be_nil
    end

    it "should nid_case '' to ''" do
      nid_case("").should == ""
    end

    it "should downcase all chars" do
      nid_case('ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ').should == 'abcdefghijklmnopqrstuvwxyzåäö'
    end

    it "should all all chars not of the type a-z, åäö, -, 0-9" do
      nid_case("kale8^79'0-").should == 'kale8790'
    end

    it "should convert diacritical characters" do
      nid_case("Dürén Ibrahimović").should == 'duren-ibrahimovic'
    end

    it 'preserves åäö ÅÄÖ' do
      nid_case("ÅÄÖåäö").should == 'åäöåäö'
    end

    it 'converts `¨´^' do
      nid_case("ÈÉËÊèéëê").should == 'eeeeeeee'
      nid_case("ÀÁÂàáâ").should == 'aaaaaa'
      nid_case("Üü").should == 'uu'
      nid_case("ČĆÇčćç").should == 'cccccc'
      nid_case("Ññ").should == 'nn'
      nid_case("Ïï").should == 'ii'
      nid_case("ÆØæø").should == 'äöäö'
    end

    it "converts _ to -" do
      nid_case("Let's_Dance").should == 'lets-dance'
    end

    it 'removes -- from name' do
      nid_case("Let's -- da-da-dance").should == 'lets-da-da-dance'
    end

    it 'removes surrounding and double space from name and tag' do
      nid_case(" Fångarna     på  fortet   ").should == 'fångarna-på-fortet'
    end

  end

  context "can determine that some things aren't nids" do
    it "accepts nothingness" do
      possible_nid?('').should be_true
      possible_nid?(nil).should be_true
    end

    it "accepts åäö" do
      possible_nid?('räksmörgås').should be_true
    end

    it "rejects strange letters" do
      possible_nid?('dürén-ibrahimović').should be_false
    end

    it "rejects non-letters" do
      possible_nid?('foo bar').should be_false
      possible_nid?('foo/bar').should be_false
      possible_nid?('foo\n').should be_false
    end

    it "rejects upper-case letters" do
      possible_nid?('FOO').should be_false
    end
  end
end
