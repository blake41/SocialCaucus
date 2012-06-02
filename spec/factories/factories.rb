FactoryGirl.define do
  factory :politician do
    screen_name 'MicheleBachmann'
    user_id '18217624'
  end
end

FactoryGirl.define do
  factory :politicians_tweets do
    timestamp '05/10/2011'
  end
end

FactoryGirl.define do
	factory :activist do
		user_id '12345678'
	end
end

FactoryGirl.define do
  factory :politicians_tweets_about do
  	activist_id '12345678'
  end
end
