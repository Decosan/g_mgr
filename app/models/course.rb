class Course < ApplicationRecord
  has_many :scores

  enum location: {
    "Bangkok": 0,
    "Chonburi": 1,
    "Ayuttaya": 2,
    "Changmai": 3,
    "Others": 4,
  }

end
