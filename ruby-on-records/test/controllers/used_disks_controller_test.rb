require "test_helper"

class UsedDisksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @used_disk = used_disks(:one)
  end

  test "should get index" do
    get used_disks_url
    assert_response :success
  end

  test "should get new" do
    get new_used_disk_url
    assert_response :success
  end

  test "should create used_disk" do
    assert_difference("UsedDisk.count") do
      post used_disks_url, params: { used_disk: {} }
    end

    assert_redirected_to used_disk_url(UsedDisk.last)
  end

  test "should show used_disk" do
    get used_disk_url(@used_disk)
    assert_response :success
  end

  test "should get edit" do
    get edit_used_disk_url(@used_disk)
    assert_response :success
  end

  test "should update used_disk" do
    patch used_disk_url(@used_disk), params: { used_disk: {} }
    assert_redirected_to used_disk_url(@used_disk)
  end

  test "should destroy used_disk" do
    assert_difference("UsedDisk.count", -1) do
      delete used_disk_url(@used_disk)
    end

    assert_redirected_to used_disks_url
  end
end
