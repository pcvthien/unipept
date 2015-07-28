class PagesController < ApplicationController
  before_action :authorize, only: [:admin]

  def home
    @title = 'Home'
    @post = Post.last
  end

  def about
    @title = 'About'
  end

  def publications
    @title = 'Publications'
  end

  def mail
    @title = "Thanks!"
    `mail -s "[Unipept] New issue" bart.mesuere@ugent.be <<EOM
      #{params[:email]}
    EOM`
  end

  def admin
    @title = 'Admin'

    # progressbar stuff
    file = Rails.root.join('public', 'progress')
    return unless FileTest.exists?(file)

    file = File.open(file, 'r')
    @progress = file.readlines.to_a.map { |line| line.strip.gsub(/#/, "\n").lines.to_a }
  end
end
