#[derive(Copy, Drop, Display)]
struct Sorcerer {
    attack: u8,
    health: u8,
    talent: Talent,
    damaged: bool
}

// For Part 2...
#[derive(Copy, Drop, PartialEq, Debug)]
enum Talent {
    Talentless: (),
    Venomous: (),
    Swift: (),
    Guardian: ()
}

#[generate_trait]
impl SorcererImpl of SorcererTrait {

    fn new(attack: u8, health: u8) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: Talent::Talentless(()),
            damaged: false
        }
    }
    
    fn dmg(ref self: Sorcerer, amt: u8) {
        if amt > self.health {
            self.health = 0;
        }
        else {
            self.health -= amt;
    
        }
    }
    // For Part 2...
    fn with_talent(attack: u8, health: u8, talent: Talent) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: talent,
            damaged: false
        }
    }

    fn attack(self: @Sorcerer) -> u8 { *self.attack }
    fn health(self: @Sorcerer) -> u8 { *self.health }
    fn is_defeated(self: @Sorcerer) -> bool { *self.health == 0_u8 }

}
