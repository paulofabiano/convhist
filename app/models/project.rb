class Project < ApplicationRecord
  include ActiveModel::Dirty

  define_attribute_methods

  belongs_to :user
  has_many :comments

  attribute :status, :string, default: :draft

  enum :status, { 
    draft: "draft", 
    published: "published", 
    archived: "archived", 
    trashed: "trashed" 
  }
end
