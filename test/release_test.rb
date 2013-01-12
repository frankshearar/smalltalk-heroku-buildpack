require_relative 'spec_helper'
require 'psych'
require 'uri'

describe "release" do
  before :each do
    @buildpack_squeak_base_url = "file://" + File.absolute_path("../test-resources/")
    @squeak_version = "4.4-12327"
    @build_dir = "target/"
    @env = {'SQUEAK_VERSION' => @squeak_version, 'BUILDPACK_SQUEAK_BASE_URL' => @buildpack_squeak_base_url}
  end

  it "should output valid YAML" do
    stdout = run(@env, "bin/release #{@build_dir}")
    expect { Psych.load(stdout) }.to_not raise_error(Psych::SyntaxError)
  end

  it "should mention minimum configuration" do
    conf = Psych.load(`bin/release #{@build_dir}`)

    conf['config_vars'].has_key?('SQUEAK_VERSION').should be_true
    conf['config_vars'].has_key?('BUILDPACK_SQUEAK_BASE_URL').should be_true

    conf['config_vars']['SQUEAK_VERSION'].should include(".")
    expect { URI::parse(conf['config_vars']['BUILDPACK_SQUEAK_BASE_URL']) }.to_not raise_error(URI::InvalidURIError)
  end
end
