# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

ruby_version_is "1.9" do
  describe "Symbol#capitalize" do
    it "returns a Symbol" do
      :glark.capitalize.should be_an_instance_of(Symbol)
    end

    it "converts the first character to uppercase if it is ASCII" do
      :lower.capitalize.should == :Lower
    end

    it "leaves the first character alone if it is not an alphabetical ASCII character" do
      :"£1.20".capitalize.should == :"£1.20"
      "\u{00DE}c".to_sym.capitalize.should == :"Þc"
      "\u{00DF}C".to_sym.capitalize.should == :"ßc"
    end

    it "converts subsequent uppercase ASCII characters to their lowercase equivalents" do
      :lOWER.capitalize.should == :Lower
    end

    it "leaves ASCII characters already in the correct case as they were" do
      :Title.capitalize.should == :Title
    end

    it "works with both upper- and lowercase ASCII characters in the same Symbol" do
      :mIxEd.capitalize.should == :Mixed
    end

    it "leaves uppercase Unicode characters as they were" do
      "a\u{00DE}c".to_sym.capitalize.should == :"AÞc"
    end

    it "leaves lowercase Unicode characters as they were" do
      "a\u{00DF}C".to_sym.capitalize.should == :"Aßc"
    end

    it "leaves non-alphabetic ASCII characters as they were" do
      "Glark?!?".to_sym.capitalize.should == :"Glark?!?"
    end
  end
end
