// withdraw_circuit/src/main.nr

use dep::std::hash::pedersen_hash;
use dep::std::merkle::compute_merkle_root;

global DEPTH: u32 = 8;

fn main(
    // private inputs from Prover.toml
    r        : Field,
    index    : Field,
    hashpath : [Field; DEPTH],

    // public inputs
    root : pub Field,
    id   : pub Field,
) {
    //Recompute the commitment
    let commit = pedersen_hash([id, r]);

    // Recompute the Merkle root for that leaf + path
    let calc_root = compute_merkle_root(commit, index, hashpath);

    // Assert it matches the public root
    assert(root == calc_root);
}
