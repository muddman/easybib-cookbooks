include_recipe "apt::ppa"

apt_repository "chrislea-redis" do
  uri "http://ppa.ezbib.com/trusty55"
end

package "redis-server"

include_recipe "redis::user"
include_recipe "redis::configure"
