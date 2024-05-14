use src::sorcerer::{Sorcerer,Talent, SorcererTrait};


fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    // IMPLEMENT THIS FUNCTION

    loop {
        
        match sorcerer1.talent {
            Talent::Talentless => {
                sorcerer1.dmg(sorcerer2.attack);
            },
            Talent::Venomous => {
                sorcerer1.dmg(sorcerer2.attack);
            },
            Talent::Swift => {
                if sorcerer2.attack < 4 {
                    sorcerer1.dmg(1);
                }
                else {
                    sorcerer1.dmg(sorcerer2.attack);
                }
            },
            Talent::Guardian => {
                if sorcerer1.damaged {
                    sorcerer1.dmg(sorcerer2.attack);
                }
            }
            
        }

        match sorcerer2.talent {
            Talent::Talentless => {
                sorcerer2.dmg(sorcerer1.attack);
            },
            Talent::Venomous => {
                sorcerer2.dmg(sorcerer1.attack);
            },
            Talent::Swift => {
                if sorcerer1.attack < 4 {
                    sorcerer2.dmg(1);
                }
                else {
                    sorcerer2.dmg(sorcerer1.attack);
                }
            },
            Talent::Guardian => {
                if sorcerer2.damaged {
                    sorcerer2.dmg(sorcerer1.attack);
                }
            }
        }

        if sorcerer1.talent == Talent::Venomous {
            sorcerer1.attack +=1;
        }
        if sorcerer2.talent == Talent::Venomous {
            sorcerer2.attack +=1;
        }

        sorcerer1.damaged = true;
        sorcerer2.damaged = true;
        if(sorcerer1.is_defeated() || sorcerer2.is_defeated()) {
            break;
        }

        
    }

}
