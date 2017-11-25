require 'yaml'

class MarkDownParse
  def initialize(mdText)
     @mdText = mdText
     @yaml = YAML.load(@mdText)

  end

  def getYamlList()
    return @yaml
  end

end
