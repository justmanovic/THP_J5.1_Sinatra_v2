require 'csv'

require 'bundler'
Bundler.require

# require_relative "../db/gossip.csv"

# commentaires sur la classe
class Gossip
  attr_reader :content, :author

  def initialize(author_to_save, content_to_save)
    @author = author_to_save
    @content = content_to_save
  end

  def save
      file = CSV.open("db/gossip.csv", "a") do |csv|
      csv << [@author,@content]
    end
  end

  def self.edit(author,content,index)
    all_gossips = CSV.read('db/gossip.csv')
    all_gossips.delete_at(index.to_i-1)
    all_gossips.insert(index.to_i-1,[author,content])

    file = CSV.open('db/gossip.csv','w')
    all_gossips.each do |line|
      file.add_row(line)
    end
    file.close
  end

  def self.read_all
    all_gossips = []
    CSV.read("db/gossip.csv").each do |line|
      all_gossips << Gossip.new(line[0], line[1])
    end
    return all_gossips
  end

  def self.destroy(index)
    all_gossips = CSV.read('db/gossip.csv')
    all_gossips.delete_at(index)

    File.open('db/gossip.csv', 'w') do |csv|
      all_gossips.each do |line|
        csv << line.join(',')
        csv << ("\n")
      end
    end

  end

end

# binding.pry