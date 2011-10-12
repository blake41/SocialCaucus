class Fulltextindexes < ActiveRecord::Migration
  def self.up
    execute('ALTER TABLE politicians_tweets_abouts ENGINE = MyISAM')
    execute('ALTER TABLE activists ENGINE = MyISAM')
    execute('CREATE FULLTEXT INDEX fulltext_text ON politicians_tweets_abouts (text(255))')
    execute('CREATE FULLTEXT INDEX fulltext_description ON activists (description(255))')
    execute('CREATE FULLTEXT INDEX fulltext_location ON activists (location(255))')
  end

  def self.down
    execute('ALTER TABLE sms ENGINE = innodb')
    execute('ALTER TABLE customers ENGINE = innodb')
    execute('DROP INDEX fulltext_text ON politicians_tweets_abouts')
    execute('DROP INDEX fulltext_description ON activists')
    execute('DROP INDEX fulltext_location ON activists')
  end
end
