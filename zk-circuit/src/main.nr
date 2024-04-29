use dep::std;
use dep::std::hash::poseidon::bn254;

struct Wizard{
    age: Field
}

fn ageChecker (x: Field, y: pub Field){
    assert(x as u32 > y as u32);
}

fn WizScore(sec1: Field, sec2: Field, sec3: Field, min_total: pub Field ){
    let user_Total = sec1 as u32 + sec2 as u32 + sec3 as u32;
    assert(min_total as u32 == user_Total as u32);
}

fn passwordAs(password: [Field; 2], passwordHash : pub Field ){
    let mut passhash = bn254::hash_2(password);
    passhash = 0x + passhash; 
    assert(passwordHash ==  passhash);
}

fn main(x: Field, y: Field, sec1: Field, sec2: Field, sec3: Field, min_total: pub Field,password: [Field; 2], passwordHash : pub Field ) {
    ageChecker(x, y);
    WizScore(sec1, sec2, sec3, min_total);
    passwordAs(password, passwordHash);
}

global passhashchecknum = 0x1192f6c0f2da8102217e6a956b222dd10faa71d4d9033bb839124ac8f31bb811;

#[test]
fn test_main() {
    main(19, 18, 1,2,15,18, [0,9], passhashchecknum);
}

#[test]
fn WizScoreCheck(){
    let total = 4;
    let sec1 = 1;
    let sec2 = 2;
    let sec3 = 1;
    WizScore(sec1, sec2, sec3, total);
}

#[test]
fn passwordAsh(){
    let pass = [0,9];
    let passhash = bn254::hash_2([0,9]);
    passwordAs(pass, passhash)

}