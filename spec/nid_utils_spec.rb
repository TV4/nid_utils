# encoding: UTF-8
require "spec_helper"
include NidUtils

describe "nid" do

  context "nid should be created with lower case and space replaced with dash" do

    it "should change space to dash" do
      nid_case('foo bar bee').should == 'foo-bar-bee'
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
end
