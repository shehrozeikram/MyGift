# frozen_string_literal: true
# This migration comes from acts_as_taggable_on_engine (originally 6)

class AddMissingIndexesOnTaggings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  disable_ddl_transaction!

  def change
    add_index :taggings, :taggable_id, algorithm: :concurrently
  end


  # def change
  #   add_index ActsAsTaggableOn.taggings_table, :tag_id unless index_exists? ActsAsTaggableOn.taggings_table, :tag_id
  #   add_index ActsAsTaggableOn.taggings_table, :taggable_id unless index_exists? ActsAsTaggableOn.taggings_table,
  #                                                                                :taggable_id
  #   add_index ActsAsTaggableOn.taggings_table, :taggable_type unless index_exists? ActsAsTaggableOn.taggings_table,
  #                                                                                  :taggable_type
  #   add_index ActsAsTaggableOn.taggings_table, :tagger_id unless index_exists? ActsAsTaggableOn.taggings_table,
  #                                                                              :tagger_id
  #   add_index ActsAsTaggableOn.taggings_table, :context unless index_exists? ActsAsTaggableOn.taggings_table, :context
  #
  #   unless index_exists? ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type]
  #     add_index ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type]
  #   end
  #
  #   unless index_exists? ActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type tagger_id context],
  #                        name: 'taggings_idy'
  #     add_index ActsAsTaggableOn.taggings_table, %i[taggable_id taggable_type tagger_id context],
  #               name: 'taggings_idy'
  #   end
  #   add_index :taggings, :taggable_id, algorithm: :concurrently
  #
  # end
end
