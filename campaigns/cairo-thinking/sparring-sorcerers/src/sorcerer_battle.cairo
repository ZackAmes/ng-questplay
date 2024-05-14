use src::sorcerer::{SorcererTrait, Sorcerer};
use src::sorcerer_duel::duel;
use core::debug::PrintTrait;
fn battle(
    ref team1: Array<Sorcerer>, 
    ref team2: Array<Sorcerer>
) {

    // IMPLEMENT THIS FUNCTION
    
    let mut s1 = team1.pop_front().unwrap();
    let mut s2 = team2.pop_front().unwrap();
    
    let mut over = false;
    
    loop {
        
        duel(ref s1, ref s2);
        
        if s1.is_defeated() {
            let next = team1.pop_front();
            match next {
                Option::Some(s) => {
                    s1 = s;
                },
                Option::None => {
                    over = true;
                }
            }
        }
        if s2.is_defeated() {
            let next = team2.pop_front();
            match next {
                Option::Some(s) => {
                    s2 = s;
                },
                Option::None=> {
                    over = true;
                }
            }
        }

        if over {
            if !s1.is_defeated() {
                let mut res = ArrayTrait::new();
                res.append(s1);
                res.append_span(team1.span());
                team1 = res;
            }
            if !s2.is_defeated() {
                let mut res = ArrayTrait::new();
                res.append(s2);
                res.append_span(team2.span());
                team2 = res;
            }
            break;
        }
        


    };

}
