import { buildPoseidon } from "circomlibjs";


async function main(){
    const poseidon = await buildPoseidon();
    const hash = poseidon([0,9]);
    console.log(poseidon.F.toString(hash, 16));
}

main();
