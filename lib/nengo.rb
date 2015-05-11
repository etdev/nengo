# coding: utf-8
class Nengo
  attr_reader :year_seireki
  attr_reader :year_koki
  attr_reader :year_nengo
  attr_reader :data_nengo
  attr_reader :data_eto
  attr_reader :nenrei
  attr_reader :jidai_data

  JIDAI_DATA_PATH = "#{Dir.pwd.join('data', 'jidai_data.json')}"
  ANIMAL_LIST_ETO_PATH = "#{Dir.pwd.join('data', 'animal_list_eto.json')}"
  ELEMENT_LIST_ETO_PATH = "#{Dir.pwd.join('data', 'element_list_eto.json')}"

  def initialize(year = nil)
    year = year.nil? ? current_year_seireki : year
    @jidai_data = load_jidai_data
    set_by_seireki(year)
  end

  def set_by_seireki(year_seireki)
    @year_seireki = year_seireki
    @data_nengo = get_data_nengo(@year_seireki)
    @nenrei = get_nenrei(@year_seireki)
    @data_eto = get_data_eto(@year_seireki)
    @year_koki = get_koki(@year_seireki)
  end

  def current_year_seireki
    Time.now.year
  end

  def set_by_nengo(nengo_data)
    @year_seireki = nengo_to_seireki(nengo_data)
    set_by_seireki(@year_seireki)
  end

  def set_by_nenrei(nenrei)
    @year_seireki = current_year_seireki - nenrei
    set_by_seireki(@year_seireki)
  end

  def set_by_koki(koki)
    @year_seireki = koki - 660
    set_by_seireki(@year_seireki)
  end

  def get_data_nengo(year_seireki)
    data_nengo = @jidai_data.select { |jidai| jidai["begin_yr"] <= year_seireki && jidai["end_yr"] >= year_seireki }.first
    data_nengo["year_rel"] = year_seireki - data_nengo["begin_yr"] + 1
    data_nengo
  end

  def get_data_eto(year_seireki)
    data_eto = {}
    year_rel = get_year_eto(year_seireki)
    data_eto[:year_rel] = year_rel
    data_eto[:animal] = get_animal_eto(year_rel)
    data_eto[:element] = get_element_eto(year_rel)
    data_eto
  end

  def get_year_eto(year_seireki)
    if year_seireki >= 4
      (year_seireki - 3) % 60
    elsif year_seireki < 0
      60 - ((year_seireki + 2) % 60)
    else
      eto_first_three(year_seireki)
    end
  end

  def get_animal_eto(year_rel)
    year_animal = year_rel == 10 ? year_rel : (year_rel % 10) + 1
    animal_list_eto = JSON.parse(File.read(ANIMAL_LIST_ETO_PATH))
    year_animal = animal_list_eto.select { |hash| hash["id"] == year_animal }.first
    year_animal
  end

  def get_element_eto(year_rel)
    year_element = year_rel == 12 ? year_rel : year_rel % 12
    element_list_eto = JSON.parse(File.read(ELEMENT_LIST_ETO_PATH))
    element_list_eto.select { |hash| hash["id"] == year_element }.first
  end

  def get_nenrei(year_seireki)
    current_year_seireki - year_seireki
  end

  def get_koki(year_seireki)
    year_seireki + 660
  end

  def nengo_to_seireki(data_nengo)
    current_jidai = @jidai_data.select { |jidai_hash| jidai_hash["name"] == data_nengo[:jidai] }.first
    current_jidai["begin_yr"].to_i + data_nengo[:year_rel] - 1
  end

  def eto_first_three(year_seireki)
    case year_seireki
    when 1
      58
    when 2
      59
    when 3
      60
    else
      raise "入力された年が無効です"
    end
  end

  private
    def load_jidai_data
      jidai_data_file = File.read(JIDAI_DATA_PATH)
      JSON.parse(jidai_data_file)
    end

end
