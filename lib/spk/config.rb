
module VagrantPlugins
	module Spk
		class Config < Vagrant.plugin(2, :config)
			attr_accessor :command, :work_dir, :packer_bin, :packer_opts, :box_url, :box_name, :cookbooks_url, :databags_url, :stack_template, :pre_commands, :post_commands, :env_vars, :ks_template, :mode, :why_run

			def initialize
				@command = UNSET_VALUE
				@work_dir = UNSET_VALUE
				@packer_bin = UNSET_VALUE
				@packer_opts = UNSET_VALUE
				@box_url = UNSET_VALUE
				@box_name = UNSET_VALUE
				@mode = UNSET_VALUE
				@cookbooks_url = UNSET_VALUE
				@databags_url = UNSET_VALUE
				@pre_commands = UNSET_VALUE
				@post_commands = UNSET_VALUE
				@ks_template = UNSET_VALUE
				@env_vars = UNSET_VALUE
				@why_run = UNSET_VALUE
			end

			def validate(machine=nil)
				errors = _detected_errors

				if @mode.nil? or @mode.empty? or !["run","build-images"].include?(@mode)
					errors << "You need to specify if you want to build-images or run"
				end

				if @stack_template.nil? or @stack_template.empty? 
					errors << "You must provide a stack template"
				end

				errors
			end

			def finalize!
				@command = "curl --no-sessionid --silent" if @command == UNSET_VALUE
				@work_dir = "#{Dir.home}/.vagrant.d/data/spk/vagrant" if @work_dir == UNSET_VALUE
				@packer_bin = 'packer' if @packer_bin == UNSET_VALUE
				@packer_opts = '' if @packer_opts == UNSET_VALUE
				@mode = '' if @mode == UNSET_VALUE
				@box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.2_chef-provisionerless.box' if @box_url == UNSET_VALUE
				@box_name = "opscode_centos-7.2" if @box_name == UNSET_VALUE
				@cookbooks_url = "file://$PWD/berks-cookbooks.tar.gz" if @cookbooks_url == UNSET_VALUE
				@databags_url = '' if @databags_url == UNSET_VALUE
				#@stack_template = "file://#{File.expand_path File.dirname(__FILE__)}/../../files/stack-templates/community-allinone.json" if @stack_template == UNSET_VALUE
				@pre_commands = "file://#{File.expand_path File.dirname(__FILE__)}/../../files/pre-commands.json" if @pre_commands == UNSET_VALUE
				@post_commands = "file://#{File.expand_path File.dirname(__FILE__)}/../../files/post-commands.json" if @post_commands == UNSET_VALUE
				@why_run = false if @why_run == UNSET_VALUE
				@ks_template = "https://raw.githubusercontent.com/Alfresco/alfresco-spk/master/ks/ks-centos.cfg" if @ks_template == UNSET_VALUE
			end
		end
	end
end
