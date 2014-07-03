class Page < ActiveRecord::Base
  attr_accessible :parent_id, :content, :name, :slug, :is_published, :in_menu, :position

  validates :name, uniqueness: true, presence: true
  validate :cant_contain_slashes
  validates :slug, uniqueness: true, presence: true,
                  exclusion: {in: %w[users user admin sign_up sign_in sign_out store en gr]}


  before_validation :generate_slug

  has_ancestry :orphan_strategy => :restrict
  acts_as_list scope: [:ancestry]

  scope :published, -> { where(:is_published => true) }
  scope :live, -> { where('is_published = true AND in_menu = true').order(:position) }

  def to_param
    slug
  end

  def live?
    is_published && in_menu
  end

  def self.arrange_as_array(options={}, hash=nil)                                                                                                                                                            
    hash ||= arrange(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_array(options, children) unless children.nil?
    end
    arr
  end

  def name_for_selects
    "#{'-' * depth} #{name}"
  end

  def possible_parents
    parents = Page.arrange_as_array(:order => 'position')
    return new_record? ? parents : parents - subtree
  end

  def full_slug
    (ancestors + [self]).map(&:to_param).join("/")
  end

  private
    def generate_slug
      self.slug = name.parameterize if self.slug.blank?
    end

    def cant_contain_slashes
      errors.add(:slug, "can' t contain slashes") if slug =~ /\\|\//
    end
end
