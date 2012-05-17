# encoding: utf-8
class Metadata
  include Mongoid::Document

  field :tags, type: Array

  belongs_to :document, polymorphic: true

  index({ tags: 1 }, { background: true })

  # Get all application entities that match the supplied text. Will work for
  # text that is exact, on contains the text in any part of the name.
  #
  # @example Search for an metadata by band name.
  #   Metadata.search_for("Depeche")
  #
  # @example Search for metadata by instruments.
  #   Metadata.search_for("piano bass")
  #
  # @example Search for metadata by genre.
  #   Metadata.search_for("punk, rock")
  #
  # @param [ String ] text The text to search for.
  #
  # @return [ Array<Metadata> ] The matching entities.
  scope :search_for, ->(text) {
    any_in(tags: text.split(/\s*[, ]\s*/).map{ |t| /#{t}/i })
  }

  # Given the provided search text, return a list of tags that would have
  # matched.
  #
  # @example Get the matching text.
  #   metadata.matches_on("Depeche Mode")
  #
  # @param [ String ] text The search text.
  #
  # @return [ Array<String> ] The matching tags.
  def matches_on(text)
    terms = text.split(/\s*[, ]\s*/)
    tags.reduce([]) do |match, tag|
      match.tap { terms.each { |term| match << tag if tag =~ /#{term}/i } }
    end.uniq
  end
end
