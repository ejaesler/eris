require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Eris do
  before :each do
    @tmp_dir = "#{Dir.tmpdir}/eris"
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
    
    it "should generate a Gemfile" do
      Dir.chdir @tmp_dir do
        gemfile_contents = File.read("Gemfile")
        gemfile_contents.should include('source "http://rubygems.org"')
        gemfile_contents.should include('gem "eris"')
      end
    end
    
    it "should generate a Rakefile" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read("Rakefile")
        rakefile_contents.should include('namespace :jasmine do')
      end      
    end
    
    it "should generate a spec/unit/support/jasmine.yml" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read("spec/unit/support/jasmine.yml")
        rakefile_contents.should include('src_files:')
      end            
    end

    it "should generate a spec/unit/support/jasmine_runner.rb" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read("spec/unit/support/jasmine_runner.rb")
        rakefile_contents.should include('')
      end            
    end

    it "should generate a spec/unit/source/sampleSpec.js" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read("spec/unit/source/sampleSpec.js")
        rakefile_contents.should include('describe')
      end            
    end

    it "should generate a rvmrc" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read(".rvmrc")
        rakefile_contents.should include('rvm use ruby-1.9.2-p180@palm')
      end            
    end
    
    it "should generate a ci_build.sh" do
      Dir.chdir @tmp_dir do
        rakefile_contents = File.read("ci_build.sh")
        rakefile_contents.should include('bundle exec rake jasmine:ci')
      end      
    end
  end
end