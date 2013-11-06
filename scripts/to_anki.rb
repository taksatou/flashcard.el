#!/usr/bin/env ruby

require 'yaml'
require 'csv'

def front(key, val)
  key
end

def back(key, val)
  res = ""
  res += "<h3>#{key}</h3>"
  res += "<p><i>#{val['pronunciation']}</i></p>" if val['pronunciation']
  res += "<p>#{val['category']}</p>" if val['category']
  res += "<p>#{val['definition']}</p>" if val['definition']
  res += "<p>#{val['note']}</p>" if val['note']
  res
end

if __FILE__ == $0
  YAML.load(ARGF.read).each do |card|
    puts CSV.generate_line([front(*card), back(*card)], encoding:'utf-8')
  end
end
