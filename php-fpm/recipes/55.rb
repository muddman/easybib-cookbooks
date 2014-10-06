include_recipe "apt::ppa"
include_recipe "apt::easybib"

apt_repository "easybib-php55" do
  uri         node["apt"]["easybib"]["ppa-php55"]
end
