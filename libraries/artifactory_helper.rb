module DiData_Artifactory
  module Helper
    def configure_Artifactory(endpoint,apiKey)
      require 'artifactory'
      #include Artifactory::Resource
      Artifactory.configure do |config|
        config.endpoint = endpoint
        config.api_key = apiKey
      end
    end

    def download_Artifacts(repo,name,version,local_path)
      require 'artifactory'
      artifacts = Artifactory::Resource::Artifact.search(name: name,  repos: repo)
      if !artifacts.nil?
        if version.nil?
          artifact = artifacts[-1]
        else
          artifact = artifacts.find {|s| s.uri.include? version }
        end
        Chef::Log.fatal
        downloadedfile = artifact.download(local_path)
        return downloadedfile
      else
        raise 'artifact with the name ' + name + 'cannot be found in the repo ' + repo
      end
    end
  end
end
