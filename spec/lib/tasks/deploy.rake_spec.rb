require "spec_helper"
require "rake"

RSpec.describe "deploy:tag" do
  let(:rake) { Rake::Application.new }
  let(:root_path) do
    File.expand_path(File.join(File.dirname(__FILE__), "..", "..", ".."))
  end
  let(:task_path) { "lib/tasks/deploy" }
  subject { Rake::Task["deploy:tag"] }

  def loaded_files_excluding_current_rake_file
    $LOADED_FEATURES.reject do |file|
      file == File.join(root_path, "#{ task_path }.rake")
    end
  end

  before :each do
    Rake.application = rake
    Rake.application.rake_require(task_path,
                                  [root_path],
                                  loaded_files_excluding_current_rake_file)
    Rake::Task.define_task(:environment)
    allow($stdout).to receive(:write) # Hiding puts output
    subject.reenable
  end

  context "when there are changes not committed" do
    it "aborts" do
      tmp_file = ""
      File.open(File.join(root_path, "README.md"), "r+") do |f|
        tmp_file = f.read
        f.write " "
      end

      expect { subject.invoke }.to raise_error SystemExit

      File.open(File.join(root_path, "README.md"), "w") do |f|
        f.write tmp_file
      end
    end
  end
end
