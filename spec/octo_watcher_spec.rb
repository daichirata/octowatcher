require File.dirname(__FILE__) + '/spec_helper'

describe OctoWatcher::App do
  context "access pages" do
    describe '/' do
      before { get '/' }

      it "should return error" do
        last_response.should be_ok
      end
    end
  end
end
