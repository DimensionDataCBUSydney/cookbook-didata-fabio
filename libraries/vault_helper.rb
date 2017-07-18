module Vault
  module Helper
    def configure_vault(vault_url,token)
      require 'vault'
      #include Artifactory::Resource
      Vault.configure do |config|
        config.address = vault_url
        config.token = token
      end
    end

    def get_vault_data(root_path, key_path)
      require 'vault'
      Vault.with_retries(Vault::HTTPConnectionError) do
        data = Vault.logical.read("#{root_path}#{key_path}")
        return data
      end
    end 
  end
end
