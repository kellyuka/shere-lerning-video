FactoryBot.define do
  factory :list do
    title { 'title-test'}
    recommend {'recommend-test'}
    playlistid { 'playlistid-test'}
    user
  end
end
