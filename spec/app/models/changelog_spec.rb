require "timecop"
require_relative "../../../app/models/changelog"

module GitTagger
  RSpec.describe Changelog do
    describe "initialization" do
      context "when autocreate is true" do
        it "sets the update text accordingly" do
          Timecop.travel(Time.local(2012, 2, 9)) do
            changelog = Changelog.new(nil, "* teh message", true)

            expect(changelog.update_text).to eq "##  - 2012-02-09\n* teh message\n\n"
          end
        end
      end

      context "when autocreate is false" do
        it "sets the update text accordingly" do
          Timecop.travel(Time.local(2012, 2, 9)) do
            changelog = Changelog.new(nil, "teh message", false)

            expect(changelog.update_text).to eq "##  - 2012-02-09\n * teh message\n\n"
          end
        end
      end
    end
  end
end
