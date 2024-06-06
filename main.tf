provider "alicloud" {
  access_key = var.TF_ALI_AK
  secret_key = var.TF_ALI_SK
  # If not set, cn-beijing will be used.
  region = var.region
}

data "alicloud_zones" "zone_vsw" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "vpc_test_hcp_github" {
  # VPC名称
  vpc_name = "vpc-test-sh-hcp-github"
  # VPC地址块
  cidr_block = "10.1.0.0/21"
  resource_group_id = "rg-aek2rkpbtopz2ma"
}

resource "alicloud_vswitch" "vsw_test_hcp_github" {
  # VSwitch名称
  vswitch_name = "vsw-test-sh-hcp-github"
  # VPC ID
  vpc_id = alicloud_vpc.vpc_test_hcp_github.id
  # 交换机地址块
  cidr_block = "10.1.0.0/24"
  #zone_id = data.alicloud_zones.zone_vsw.zones.0.id
  zone_id = "cn-shanghai-b"
  # 资源依赖,会优先创建该依赖资源
  depends_on = [alicloud_vpc.vpc_test_hcp_github]
}

