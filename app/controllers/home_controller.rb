require 'markDownParse.rb'

class HomeController < ApplicationController
  def top
  end

  def receiveFile
    file = params[:uppic]

    yamlFile =  MarkDownParse.new(file.read)
    yamlFile = yamlFile.getYamlList()
    @name = yamlFile['名前']['氏名']
  end
end
