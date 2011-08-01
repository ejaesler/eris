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
      # capture_output do
        Dir.chdir @tmp_dir do
          @thor.invoke Eris::Tasks, "generate"
        end
      # end
    end

    it "should run jasmine:ci" do
      Bundler.with_clean_env do
        gem_dir = File.expand_path('../../../../', File.dirname(__FILE__))
        system! "cd #{gem_dir} && bundle exec rake build"
        system! "mkdir -p #{@tmp_dir}/vendor/cache/"
        system! "cp #{gem_dir}/pkg/eris-#{Eris::VERSION}.gem #{@tmp_dir}/vendor/cache/"
        system "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'gem uninstall -aIx eris'"
        system! "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'gem list | grep bundler || gem install bundler'"
        system! "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'bundle install'"
        system! "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'bundle exec gem list | grep eris'"
        system! "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'bundle exec gem list | grep jasmine'"
        system "cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'bundle show jasmine'"
        eris_config_location = "#{@tmp_dir}eris_config.json"
        eris_config = File.read(eris_config_location)
        eris_config.gsub!("../../", "/usr/palm/frameworks/")
        File.open(eris_config_location, 'w') {|f| f.write(eris_config) }
        system("cd #{@tmp_dir} && rvm-exec ruby-1.9.2-p180@palm-test bash -c 'bundle exec rake jasmine:ci'").should be_true
      end
    end
  end
end
