# encoding: utf-8
Fabricator(:album) do
  name "Fresh Fruit for Rotting Vegetables"
  released Date.new(1980, 9, 5)
end

# Special fabricator for a multi-disc full album.
Fabricator(:singles_86_98, class_name: "Album") do
  name "The Singles 86 > 98"
  released Date.new(1998, 9, 28)

  after_build do |album|
    album.tracks.push([
      Fabricate.build(:stripped),
      Fabricate.build(:a_question_of_lust),
      Fabricate.build(:a_question_of_time),
      Fabricate.build(:strangelove),
      Fabricate.build(:never_let_me_down_again),
      Fabricate.build(:behind_the_wheel),
      Fabricate.build(:personal_jesus),
      Fabricate.build(:enjoy_the_silence),
      Fabricate.build(:i_feel_you),
      Fabricate.build(:walking_in_my_shoes),
      Fabricate.build(:condemnation),
      Fabricate.build(:in_your_room),
      Fabricate.build(:barrel_of_a_gun),
      Fabricate.build(:its_no_good),
      Fabricate.build(:home),
      Fabricate.build(:useless),
      Fabricate.build(:only_when_i_lose_myself),
      Fabricate.build(:little_15),
      Fabricate.build(:everything_counts)
    ])
    album.photos.push([
      Fabricate.build(:singles_86_98_cover),
      Fabricate.build(:singles_86_98_back)
    ])
    album.producer = Fabricate(:daniel_miller)
  end
end

Fabricator(:halo_one, class_name: "Album") do
  name "Down In It"

  after_build do |album|
    album.tracks.push(Fabricate.build(:down_in_it))
    album.producer = Fabricate(:daniel_miller)
  end
end
