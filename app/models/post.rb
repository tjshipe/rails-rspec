class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :generate_slug
  validates_presence_of :title, :content
  
  # def initialize(title)
  #   @title = title
  # end

  private

  def titleize_title
    self.title.capitalize!
  end

  def generate_slug
    title = self.title.downcase
    simple_string = /(\d|\w).+(\d|\w)/.match(title)[0]
    simple_string.gsub!(/\W/,'-')
    self.slug = simple_string
  end
end
