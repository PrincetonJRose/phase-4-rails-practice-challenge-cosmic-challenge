class Mission < ApplicationRecord
  belongs_to :scientist
  belongs_to :planet

  validates :name, :planet, :scientist, presence: true
  # validates :scientist, uniqueness: { scope: :name }

  validate :join_mission_once, on: :create

  def join_mission_once
    if Mission.find_by( name: self.name, planet: self.planet, scientist: self.scientist )
      errors.add(:scientist, "can't join the same mission more than once. Sorry space cowboy.")
    end
  end
end
