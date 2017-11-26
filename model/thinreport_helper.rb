# coding: utf-8

require 'thinreports'
require 'yaml'



class ThinreportHelper
  @@json_obj
  @@file_name
  def initialize(json_obj,file_name)
    @@json_obj = json_obj
  end

  def self.init_use_file(yaml_file_name)
    json_obj = open(yaml_file_name, 'r') { |f| YAML.load(f) }
    @@file_name = yaml_file_name + ".pdf"
    new(json_obj,yaml_file_name)
  end

  def gen_pdf(tlf_file_name)
    report = Thinreports::Report.new layout: tlf_file_name
    report.start_new_page
    report.page.item(:name_rubi).value(@@json_obj.dig("名前","ふりがな"))
    report.page.item(:name_main).value(@@json_obj.dig("名前","氏名"))
    #report.page.item(:year).value(@@json_obj.dig("現住所","ふりがな"))
    #report.page.item(:month).value('11')
    #report.page.item(:date).value('26')
    #report.page.item(:old).value('14')
    report.page.item(:address_rubi).value(@@json_obj.dig("現住所","ふりがな"))
    report.page.item(:address_main).value(@@json_obj.dig("現住所","住所"))
    report.page.item(:tel).value(@@json_obj.dig("現住所","TEL"))
    report.page.item(:tel_mobile).value(@@json_obj.dig("現住所","携帯"))
    report.page.item(:address_sub_rubi).value(@@json_obj.dig("連絡先の住所","ふりがな"))
    report.page.item(:address_sub_main).value(@@json_obj.dig("連絡先の住所","住所"))
    report.page.item(:tel_sub).value(@@json_obj.dig("連絡先の住所","TEL"))
    report.page.item(:tel_sub_mobile).value(@@json_obj.dig("連絡先の住所","携帯"))
    user_history = @@json_obj.dig("学歴_職歴")
    counter = 0
    user_history.each{|element|
      detail,year_month = element.shift
      index = "history"+counter.to_s
      year_month_str = year_month.dig("年月日")
      year_month_list = year_month_str.split(",")
      report.page.item("year"+counter.to_s).value(year_month_list[0])
      report.page.item("month"+counter.to_s).value(year_month_list[1])
      report.page.item("history"+counter.to_s).value(detail)
      ++counter
    }
    report.generate(filename: @@file_name)
  end
end

#test
thinhelper = ThinreportHelper.init_use_file("Profile.yml")
thinhelper.gen_pdf("jis_rireki0.tlf")
