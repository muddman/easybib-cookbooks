include_recipe "apt::ppa"

sources_file = "/etc/apt/sources.list.d/#{node["ruby-brightbox"]["ppa"].split(':')[1].gsub("/", "-")}.list"

apt_repository "brightbox-ruby" do
  uri   "http://ppa.ezbib.com/trusty55"
  not_if do
    File.exists?(sources_file)
  end
end

package "ruby#{node["ruby-brightbox"]["version"]}"
