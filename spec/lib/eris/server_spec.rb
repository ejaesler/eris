require 'spec_helper'

=begin
x  * serve all files in a directory
x  * map / to /index.html
  * inject JavaScript and/or script tags into index.html ONLY
  * map /luna to novacom
  * map /xhr to curl
=end


describe "Eris Server" do
  include Rack::Test::Methods

  let(:tmp_dir) do
    tmp_dir = "#{Dir.tmpdir}/eris"
    FileUtils.rm_rf tmp_dir
    FileUtils.mkdir_p tmp_dir+"/a/"


    system("echo 'function() {}' > #{tmp_dir}/a/foo.js")

    index = <<INDEX
<html>
  <script enyo=true src='enyo/0.10/framework/enyo.js'></script>
  <script eris-helpers=true src='eris-helpers/ErisHelpers.js'></script>
  <script app-helpers=true src='app-helpers/AppHelpers.js'></script>
</html>
INDEX
    File.open("#{tmp_dir}/index.html.erb", 'w') {|f| f.write(index) }

    tmp_dir
  end

  let(:app) do
    @our_app = Eris::Server.new(tmp_dir)
    @our_app
  end

  it "can return any static filepath" do
    get '/a/foo.js'
    last_response.should be_ok
    last_response.body.should match(/function/)
  end

  it "can serve index.html when asking for '/'" do
    get '/'
    last_response.should be_ok
    last_response.body.should match(/^<html>/)
  end

  context "when serving an Enyo app" do

    before :each do
      get '/'
      @body = Nokogiri(last_response.body)
    end

    it "should load the local version of the enyo framework" do
      enyo_tags = @body.css('script[@enyo]')

      enyo_tags.length.should == 1
      enyo_tags.first["src"].should == "enyo/0.10/framework/enyo.js"
    end

    it "should load the common helper files" do
      eris_helper_tags = @body.css('script[@eris-helpers]')

      eris_helper_tags.length.should == 1
      eris_helper_tags.first["src"].should == "eris-helpers/ErisHelpers.js"
    end

    it "should load the app's specific helper files" do
      eris_helper_tags = @body.css('script[@app-helpers]')

      eris_helper_tags.length.should == 1
      eris_helper_tags.first["src"].should == "app-helpers/AppHelpers.js"
    end

  end

  context "when serving eris-helpers" do
    before :each do
      get '/eris-helpers/ErisHelpers.js'
      @body = last_response.body;
    end

    it "should include the fake app relaunch" do
      @body.should match(/relaunchWithParams =/)
    end

    it "should include the XHR proxy for Luna calls" do
      @body.should match(/var NovacomRequest = enyo.kind\(\{/)
    end

    it "should include the XHR proxy for arbitrary AJAX calls" do
      @body.should match(/var ProxiedRequest = enyo.kind\(\{/)
    end
  end

  describe "app-helpers IS THIS A NOOP?" do
    xit "should render them out of the app path" do
      get '/app-helpers/AppHelpers.js'
      last_response.body.should == "var appHelpers = {}"
    end
  end

  describe "when making a palm/luna XHR" do
    it "should shell out to luna" do
      luna_request = double('LunaRequest')
      luna_request.stub!(:execute)
      LunaRequest.stub!(:new).and_return(luna_request)
      luna_request.should_receive(:execute)

      req_string = '{"body": {"foo" : "bar" }, "url": "http://www.example.com/"}'

      get "/luna?req=#{URI.encode(req_string)}"
    end
  end

#  describe "when making an external API XHR" do
#    it "should shell out to curl" do
#      Kernel.stub!(:`)
#      get '/luna/fooo'
#    end
#  end
end
