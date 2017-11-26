require 'markDownParse.rb'
require 'thinreport_helper.rb'

class HomeController < ApplicationController
  def top
  end

  def receiveFile
    file = params[:uppic]

    yamlFile =  MarkDownParse.new(file.read)
    @yaml_obj = yamlFile.getYamlList()
    thinhelper = ThinreportHelper.new(@yaml_obj)
    # binding.pry
    thinhelper.gen_pdf("app/assets/jis_rireki0.tlf")

    # thinhelper = ThinreportHelper.init_use_file("../Profile.yml")
    # thinhelper.gen_pdf("jis_rireki0.tlf")
    # binding.pry
    # @name = yamlFile['名前']['氏名']
  end
end
