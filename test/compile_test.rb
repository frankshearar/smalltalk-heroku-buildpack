def run cmd
  system cmd
end

describe "compile" do
  before :each do
    @buildpack_squeak_base_url = "file://" + File.absolute_path("../test-resources/")
    @squeak_version = "4.4-12327"
    @cache_dir = "target/"
    @filetree_repo = "template/filetree"

    FileUtils.rm_r(@cache_dir) if Dir.exist?(@cache_dir)
    Dir.mkdir(@cache_dir)
  end

  it "should fail if both SQUEAK_VERSION and BUILDPACK_SQUEAK_BASE_URL are not set" do
    run "bin/compile #{@filetree_repo} #{@cache_dir}"
    $?.exitstatus.should_not == 0
  end

  it "should fail if SQUEAK_VERSION is set but not BUILDPACK_SQUEAK_BASE_URL" do
    run "SQUEAK_VERSION=#{@squeak_version} bin/compile #{@filetree_repo} #{@cache_dir}"
    $?.exitstatus.should_not == 0
  end
  
  it "should fail if BUILDPACK_SQUEAK_BASE_URL is set but not SQUEAK_VERSION" do
    run "BUILDPACK_SQUEAK_BASE_URL='#{@buildpack_squeak_base_url}' bin/compile #{@filetree_repo} #{@cache_dir}"
    $?.exitstatus.should_not == 0
  end
end

describe "compiling with both SQUEAK_VERSION and BUILDPACK_SQUEAK_BASE_URL" do
  before :all do
    @buildpack_squeak_base_url = "file://" + File.absolute_path("test-resources/")
    @squeak_version = "4.4-12327"
    @cache_dir = File.absolute_path("target")
    @filetree_repo = "template/filetree"

    FileUtils.rm_r(@cache_dir) if Dir.exist?(@cache_dir)

    @status = run "SQUEAK_VERSION=#{@squeak_version} BUILDPACK_SQUEAK_BASE_URL='#{@buildpack_squeak_base_url}' bin/compile #{@filetree_repo} #{@cache_dir}"
  end

  it "should succeed" do
    @status.should be_true
  end

  it "should make the cache directory" do
    Dir.exist?(@cache_dir).should be_true
  end

  it "should have a Squeak image" do
    Dir.entries("target").detect(nil) { |fn| /Squeak.*\.image/.match(fn) }.should_not be_nil
    Dir.entries("target").detect(nil) { |fn| /Squeak.*\.changes/.match(fn) }.should_not be_nil
  end

  it "should have a virtual machine" do
    Dir.entries("target").detect(nil) { |fn| fn.include?("coglinux\.fake.vm") }.should_not be_nil
  end
end
