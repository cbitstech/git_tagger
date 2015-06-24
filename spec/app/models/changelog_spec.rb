require "timecop"
require_relative "../../../app/models/changelog"

class Rails
  def self.root
    ["/rails/", ""]
  end
end

module GitTagger
  RSpec.describe Changelog do
    let(:fixed_date) { Time.local(2012, 2, 9) }

    describe "initialization" do
      context "when autocreate is true" do
        it "sets the update text accordingly" do
          Timecop.travel(fixed_date) do
            changelog = Changelog.new(nil, "* teh message", true)

            expect(changelog.update_text).to eq "##  - 2012-02-09\n* teh message\n\n"
          end
        end
      end

      context "when autocreate is false" do
        it "sets the update text accordingly" do
          Timecop.travel(fixed_date) do
            changelog = Changelog.new(nil, "teh message", false)

            expect(changelog.update_text).to eq "##  - 2012-02-09\n * teh message\n\n"
          end
        end
      end
    end

    describe "#update" do
      let(:mock_file) { double("file") }

      before do
        expect(mock_file).to receive(:puts).with("##  - 2012-02-09\n * \n\n")
        allow(File).to receive(:foreach).with("/rails/CHANGELOG.md")
        allow(File).to receive(:open).with("/rails/CHANGELOG.md.new", "w")
          .and_yield(mock_file)
        expect(File).to receive(:rename).with("/rails/CHANGELOG.md.new", "/rails/CHANGELOG.md")
      end

      context "when the file doesn't exist" do
        it "creates a new file with the update_text" do
          expect(File).to receive(:open).with("/rails/CHANGELOG.md", "w")

          Timecop.travel(fixed_date) do
            Changelog.new(nil, nil, false).update(:rails_application)
          end
        end
      end

      context "when the file exists" do
        it "prepends the update_text" do
          allow(File).to receive(:exist?).with("/rails/CHANGELOG.md") { true }

          Timecop.travel(fixed_date) do
            Changelog.new(nil, nil, false).update(:rails_application)
          end
        end
      end
    end
  end
end
