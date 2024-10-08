use array::ArrayTrait;
use clone::Clone;
use option::OptionTrait;
use core::debug::PrintTrait;
use src::pyramid::{ Chamber, Pyramid };

// ╔════════════════════════════════════════════╗
// ║         PART #1: Into<Pyramid, Array>      ║
// ╚════════════════════════════════════════════╝

impl PyramidIntoArray<
    T, 
    impl TClone: Clone<T>, 
    impl TDrop: Drop<T>
> of Into<Pyramid<T>, Array<T>> {
    fn into(self: Pyramid<T>) -> Array<T> {
        // IMPLEMENT THIS FUNCTION
        let mut res = ArrayTrait::new();
        let mut chambers = self.chambers.span();
        handle_chamber(ref chambers, self.top, ref res);
        res
        
    }
}

fn handle_chamber<T, impl TClone: Clone<T>, impl TDrop: Drop<T>>(ref chambers: Span<Chamber<T>>, index: usize, ref res: Array<T>) {
    
    let chamber = chambers.at(index);
    match chamber.lower_chambers {
        Option::Some((left, right)) => {
            handle_chamber(ref chambers, *left, ref res);
            res.append(chamber.item.clone());
            handle_chamber(ref chambers, *right, ref res);
        },
        Option::None => {
            res.append(chamber.item.clone());
        }
    }
}

// ╔════════════════════════════════════════════╗
// ║          PART #2: Pyramid Search           ║
// ╚════════════════════════════════════════════╝

trait PyramidSearchTrait<T> {
    fn search(self: @Pyramid<T>, key: T) -> Option<Array<T>>;
}

impl PyramidSearchImpl<
    T, 
    impl TClone: Clone<T>, 
    impl TDrop: Drop<T>, 
    impl TPartialEq: PartialEq<T>
> of PyramidSearchTrait<T> {
    fn search(self: @Pyramid<T>, key: T) -> Option<Array<T>> {
        // IMPLEMENT THIS FUNCTION
        let mut chambers = self.chambers.span();
        let mut res = ArrayTrait::new();
        let found = search_chamber(ref chambers, *self.top, key, ref res);
        
        if found {
            res.append(chambers.at(*self.top).item.clone());
            res = reverse_array(res);
            return Option::Some(res);
        }
        else {
            return Option::None;
        }

    }
}

fn search_chamber<T, +Clone<T>, +Drop<T>, +PartialEq<T>>(ref chambers: Span<Chamber<T>>, index: usize, key: T, ref res: Array<T>) -> bool {
    
    let searching = chambers.at(index);
    if searching.item == @key {
        return true;
    }
    else {
        match searching.lower_chambers {
            Option::Some((left, right)) => {
                let in_left = search_chamber(ref chambers, *left, key.clone(), ref res);
                if in_left {
                    res.append((chambers.at(*left)).item.clone());
                    return true;
                }
                else {
                    let in_right = search_chamber(ref chambers, *right, key.clone(), ref res);
                    if in_right {
                        res.append((chambers.at(*right)).item.clone());
                        return true;
                    }
                }
            },
            Option::None => {
                return false;
            }
        }
    }
    return false;
}

fn reverse_array<T, +Clone<T>, +Drop<T>>(arr: Array<T>) -> Array<T>{
    
    let mut res = ArrayTrait::new();
    let mut index = 1;

    while index <= arr.len() {
        let next = arr.at(arr.len() - index).clone();
        res.append(next);
        index+=1;
    };
    res
}
























