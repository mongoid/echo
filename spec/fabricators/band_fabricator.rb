# encoding: utf-8
Fabricator(:band) do
  name "Dead Kennedys"
end

# Use Depeche Mode for testing of the entire object graph.
Fabricator(:depeche_mode, class_name: "Band") do
  description {
    "Depeche Mode are an English electronic music band which formed in 1980, in " +
    "Basildon, Essex. The group's original line-up consisted of Dave Gahan " +
    "(lead vocals), Martin Gore (keyboards, guitar, vocals, chief songwriter " +
    "after 1981), Andy Fletcher (keyboards) and Vince Clarke (keyboards, chief " +
    "songwriter 1980–81). Vince Clarke left the band after the release of their " +
    "1981 debut album, Speak & Spell, and was replaced by Alan Wilder " +
    "(keyboards, drums) with Gore taking over songwriting. Wilder left the band " +
    "in 1995 and since then Gahan, Gore, and Fletcher have continued as a trio."
  }
  genres [ "Electronic", "Synth Pop", "New Romantic" ]
  name "Depeche Mode"
  similarities [ "Pet Shop Boys", "New Order", "Mute" ]
  sounds [ "Synthesizer", "Piano", "Drum Machine", "Sequencer" ]

  after_build do |band|
    band.albums.push(Fabricate.build(:singles_86_98))
    band.photos.push([
      Fabricate.build(:depeche_mode_wall),
      Fabricate.build(:depeche_mode_universe),
      Fabricate.build(:depeche_mode_table)
    ])
  end
end

# Use Nine Inch Nails for a smaller full object graph
Fabricator(:nine_inch_nails, class_name: "Band") do
  description "Trent Reznor's baby."
  name "Nine Inch Nails"

  after_build do |band|
    band.albums.push(Fabricate.build(:halo_one))
  end
end
