include_recipe "apt::ppa"

easybib_launchpad "ppa:nijel/phpmyadmin" do
  action :discover
end

apt_repository "nijel-phpmyadmin" do
  uri   "http://ppa.ezbib.com/trusty55"
end

package "phpmyadmin"
