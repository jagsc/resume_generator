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
    @file_name = "jis_rireki0"
    report = thinhelper.gen_pdf("app/assets/#{@file_name}.tlf")
    # binding.pry
    # @file_name = "tes.pdf"

    send_data report.generate,
              filename:    "#{@file_name}.pdf",
              type:        "application/pdf",
              disposition: "inline"

    # thinhelper = ThinreportHelper.init_use_file("../Profile.yml")
    # thinhelper.gen_pdf("jis_rireki0.tlf")
    # binding.pry
    # @name = yamlFile['名前']['氏名']
  end
end
