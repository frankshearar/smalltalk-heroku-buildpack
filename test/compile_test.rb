require_relative 'spec_helper'

describe "compile" do
  before :each do
    @buildpack_squeak_base_url = "file://" + File.absolute_path("../test-resources/")
    @squeak_version = "4.4-12327"
    @base_dir = "target/"
    @build_dir = "templates/filetree"
    @cache_dir = "target/cache/"

    FileUtils.rm_r(@base_dir) if Dir.exist?(@base_dir)
    FileUtils.mkdir_p(@cache_dir)
  end

  it "should fail if both SQUEAK_VERSION and BUILDPACK_SQUEAK_BASE_URL are not set" do
    env = {}
    status = run(env, "bin/compile #{@build_dir} #{@cache_dir}")
    status.exitstatus.should_not == 0
  end

  it "should fail if SQUEAK_VERSION is set but not BUILDPACK_SQUEAK_BASE_URL" do
    env = {'SQUEAK_VERSION' => @squeak_version}
    status = run(env, "bin/compile #{@build_dir} #{@cache_dir}")
    status.exitstatus.should_not == 0
  end
  
  it "should fail if BUILDPACK_SQUEAK_BASE_URL is set but not SQUEAK_VERSION" do
    env = {'BUILDPACK_SQUEAK_BASE_URL' => @buildpack_squeak_base_url}
    status = run(env, "bin/compile #{@build_dir} #{@cache_dir}")
    status.exitstatus.should_not == 0
  end
end

describe "compiling with both SQUEAK_VERSION and BUILDPACK_SQUEAK_BASE_URL" do
  before :all do
    @buildpack_squeak_base_url = "file://" + File.absolute_path("test-resources/")
    @squeak_version = "4.4-12327"
    @cache_dir = File.absolute_path("target")
    @build_dir = "template/filetree"
    @env = {'SQUEAK_VERSION' => @squeak_version, 'BUILDPACK_SQUEAK_BASE_URL' => @buildpack_squeak_base_url}

    FileUtils.rm_r(@cache_dir) if Dir.exist?(@cache_dir)

    @status = run(@env, "bin/compile #{@build_dir} #{@cache_dir}")
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
