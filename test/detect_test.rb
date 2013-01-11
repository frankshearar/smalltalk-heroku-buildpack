describe "detect" do
  it "should detect a filetree repository" do
    $?.exitstatus.should == 0
  end

  it "should not detect a non-smalltalk repository" do
    `bin/detect templates/not-a-smalltalk-repository`
    $?.exitstatus.should_not == 0
  end
end
