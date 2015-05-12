# nengo
Ruby Gem to convert between Japanese year formats and check age and zodiac information for given years.

## Usage
Install the gem
```ruby
gem install nengo
```
or put the following in your Gemfile
```ruby
gem 'nengo'
```
*Note: requires the 'json' gem*

Then simply require 'nengo' in the file(s) where you want to use it
```ruby
require 'nengo'
```

## Examples
**Get current 和暦年号 (Wareki nengo) year and epoch name:**

```ruby
current_year = Nengo.new # default is this year
current_year.data_nengo[:year_rel]
# => 27
current_year.data_nengo[:name]
# => 平成
```

**Get current age of person born in 昭和 (Shouwa) 50**
```ruby
year = Nengo.new
year.set_by_nengo(jidai: "昭和", year_rel: 50)
year.nenrei
# => 40
```
So someone born in the year 昭和 (Shouwa) 50 is currently 40-41 years old.

**Get the 和暦年号 (Wareki nengo) year and epoch name of the year in which a person who is now 25 years old was born**
```ruby
year = Nengo.new
year.set_by_nenrei(20)
year.data_nengo["name"]
# => 平成
year.data_nengo["year_rel"]
# => 7
```
So someone who's currently 20 years old was born in the 7th (or possibly 6th, but we can't know without specifying the exact date) of the Heisei epoch.

**Get the 干支 (Japanese Zodiac) and Koki (皇紀) information for someone born in 1960**
```ruby
year = Nengo.new(1960)
year.data_eto
# => { :year_rel=>37,
#      :animal=> {"id"=>8, "name"=>"辛", "reading_kanji"=>"金の弟", "reading_kana"=>"かのと"},
#      :element=> {"id"=>1, "name"=>"子", "reading_on"=>"し", "reading_kun"=>"ね"}
#    }
year.year_koki
# => 2620
```
As you can see, a large number of possible conversions are possible.

## Data included
* **西暦** (Western) year
* **年号** (Japanese system based on emperors' lifespans) data
* **年齢** (Current age of people born in the given year) year
* **干支** (Chinese zodiac) data
* **皇紀** (Imperial Japanese calendar) year

## Todo
* Write tests
* Refactor so it's not necessary to store the full list of jidais in each Nengo object
* Fix inconsistencies between string and symbol keys for hashes
