post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    next unless config.name == 'Debug'
    config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
      '$(FRAMEWORK_SEARCH_PATHS)'
    ]
  end
end