require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Eris do
  before :each do
    @tmp_dir = "/tmp/eris-test/"
    FileUtils.rm_r @tmp_dir if File.exists?(@tmp_dir)
    FileUtils.mkdir_p @tmp_dir

    @thor = Thor.new
  end

  describe "generate command" do
    before :each do
      capture_output do
        Dir.chdir @tmp_dir do
          @thor.invoke Eris::Tasks, "generate"
        end
      end
    end

    it "should run jasmine:ci" do
      Bundler.with_clean_env do
        gem_dir = File.expand_path('../../../../', File.dirname(__FILE__))
        gemfile_location = "#{@tmp_dir}/Gemfile"
        gemfile_contents = File.read(gemfile_location).gsub(%Q{gem "eris"}, %Q{gem "eris", :path => "#{gem_dir}"})

        File.open(gemfile_location, 'w') { |file| file << gemfile_contents }
        system("echo 'rvm use ruby-1.9.2-p180@palm-test' > #{@tmp_dir}/.rvmrc")
        system "cd #{@tmp_dir} && gem uninstall -aIx eris"
        system! "cd #{@tmp_dir} && gem list | grep bundler || gem install bundler"
        system! "cd #{@tmp_dir} && bundle install"
        system! "cd #{@tmp_dir} && bundle exec gem list | grep eris"
        system! "cd #{@tmp_dir} && bundle exec gem list | grep jasmine"
        system "cd #{@tmp_dir} && bundle show jasmine"
        eris_config_location = "#{@tmp_dir}eris_config.json"
        eris_config = File.read(eris_config_location)
        eris_config.gsub!("../../", "/usr/palm/frameworks/")
        File.open(eris_config_location, 'w') {|f| f.write(eris_config) }
        system("cd #{@tmp_dir} && bundle exec rake jasmine:ci").should be_true
      end
    end
  end
end
