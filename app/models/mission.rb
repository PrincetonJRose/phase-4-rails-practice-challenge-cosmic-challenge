class Mission < ApplicationRecord
    belongs_to :scientist
    belongs_to :planet

    validates :name, presence: true

    validate :join_mission_once

    def join_mission_once
        if Mission.find_by( name: self.name, scientist: self.scientist, planet: self.planet)
            self.errors.add( :scientist, "can't join the same mission more than once. Sorry space cowboy. 🧑‍🚀" )
        end
    end

end
