class Scraper::Urls
  BASE_URL = 'https://raw.githubusercontent.com/openZH/covid_19/master/fallzahlen_kanton_total_csv_v2/'.freeze

  def self.all
    %w[
      COVID19_Fallzahlen_FL_total.csv
      COVID19_Fallzahlen_Kanton_AG_total.csv
      COVID19_Fallzahlen_Kanton_AI_total.csv
      COVID19_Fallzahlen_Kanton_AR_total.csv
      COVID19_Fallzahlen_Kanton_BE_total.csv
      COVID19_Fallzahlen_Kanton_BL_total.csv
      COVID19_Fallzahlen_Kanton_BS_total.csv
      COVID19_Fallzahlen_Kanton_FR_total.csv
      COVID19_Fallzahlen_Kanton_GE_total.csv
      COVID19_Fallzahlen_Kanton_GL_total.csv
      COVID19_Fallzahlen_Kanton_GR_total.csv
      COVID19_Fallzahlen_Kanton_JU_total.csv
      COVID19_Fallzahlen_Kanton_LU_total.csv
      COVID19_Fallzahlen_Kanton_NE_total.csv
      COVID19_Fallzahlen_Kanton_NW_total.csv
      COVID19_Fallzahlen_Kanton_OW_total.csv
      COVID19_Fallzahlen_Kanton_SG_total.csv
      COVID19_Fallzahlen_Kanton_SH_total.csv
      COVID19_Fallzahlen_Kanton_SO_total.csv
      COVID19_Fallzahlen_Kanton_SZ_total.csv
      COVID19_Fallzahlen_Kanton_TG_total.csv
      COVID19_Fallzahlen_Kanton_TI_total.csv
      COVID19_Fallzahlen_Kanton_UR_total.csv
      COVID19_Fallzahlen_Kanton_VD_total.csv
      COVID19_Fallzahlen_Kanton_VS_total.csv
      COVID19_Fallzahlen_Kanton_ZG_total.csv
      COVID19_Fallzahlen_Kanton_ZH_total.csv
    ].map { |filename| "#{BASE_URL}#{filename}" }
  end
end


