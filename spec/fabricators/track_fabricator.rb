# encoding: utf-8
Fabricator(:track) do
  disc 1
  name "California Über Alles"
  number 1
  length "3:03"
end

# The following tracks are used when desiring to create a full length triple
# disc album, from the every intoxicating Depeche Mode.
Fabricator(:stripped, class_name: "Track") do
  disc 1
  length "3:51"
  name "Stripped (7\" Version)"
  number 1
end

Fabricator(:a_question_of_lust, class_name: "Track") do
  disc 1
  length "4:31"
  name "A Question Of Lust"
  number 2
end

Fabricator(:a_question_of_time, class_name: "Track") do
  disc 1
  length "4:00"
  name "A Question Of Time (Remix)"
  number 3
end

Fabricator(:strangelove, class_name: "Track") do
  disc 1
  length "3:47"
  name "Strangelove"
  number 4
end

Fabricator(:never_let_me_down_again, class_name: "Track") do
  disc 1
  length "4:22"
  name "Never Let Me Down Again"
  number 5
end

Fabricator(:behind_the_wheel, class_name: "Track") do
  disc 1
  length "4:00"
  name "Behind The Wheel (Remix)"
  number 6
end

Fabricator(:personal_jesus, class_name: "Track") do
  disc 1
  length "3:46"
  name "Personal Jesus"
  number 7
end

Fabricator(:enjoy_the_silence, class_name: "Track") do
  disc 1
  length "4:16"
  name "Enjoy The Silence (7\" Version)"
  number 8
end

Fabricator(:policy_of_truth, class_name: "Track") do
  disc 1
  length "5:14"
  name "Policy Of Truth"
  number 9
end

Fabricator(:world_in_my_eyes, class_name: "Track") do
  disc 1
  length "3:56"
  name "World In My Eyes (7\" Version)"
  number 10
end

Fabricator(:i_feel_you, class_name: "Track") do
  disc 2
  length "4:35"
  name "I Feel You"
  number 1
end

Fabricator(:walking_in_my_shoes, class_name: "Track") do
  disc 2
  length "5:02"
  name "Walking In My Shoes (Single Version)"
  number 2
end

Fabricator(:condemnation, class_name: "Track") do
  disc 2
  length "3:23"
  name "Condemnation (Paris Mix)"
  number 3
end

Fabricator(:in_your_room, class_name: "Track") do
  disc 2
  length "4:50"
  name "In Your Room (Zephyr Mix)"
  number 4
end

Fabricator(:barrel_of_a_gun, class_name: "Track") do
  disc 2
  length "5:26"
  name "Barrel Of A Gun"
  number 5
end

Fabricator(:its_no_good, class_name: "Track") do
  disc 2
  length "5:59"
  name "It's No Good"
  number 6
end

Fabricator(:home, class_name: "Track") do
  disc 2
  length "5:46"
  name "Home"
  number 7
end

Fabricator(:useless, class_name: "Track") do
  disc 2
  length "4:53"
  name "Useless (Remix)"
  number 8
end

Fabricator(:only_when_i_lose_myself, class_name: "Track") do
  disc 2
  length "4:41"
  name "Only When I Lose Myself"
  number 9
end

Fabricator(:little_15, class_name: "Track") do
  disc 2
  length "4:14"
  name "Little 15"
  number 10
end

Fabricator(:everything_counts, class_name: "Track") do
  disc 2
  length "6:38"
  name "Everything Counts (Live)"
  number 11
end

Fabricator(:down_in_it, class_name: "Track") do
  disc 1
  length "3:44"
  name "Down In It"
  number 1
end
