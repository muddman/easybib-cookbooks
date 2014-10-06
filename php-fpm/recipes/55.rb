include_recipe "apt::ppa"
include_recipe "apt::easybib"

apt_repository "easybib-php55" do
  uri         "http://ppa.ezbib.com/trusty55"
end
