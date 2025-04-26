use dep::std::hash::pedersen_hash;
use dep::std::merkle::compute_merkle_root;

global DEPTH: u32 = 8;          


fn commitment(id: Field, r: Field) -> Field {
    pedersen_hash([id, r])
}

fn roots(old_path: [Field; DEPTH], index: Field, commit: Field) -> (Field, Field) {
    
    let empty = old_path[0];
    let old_root = compute_merkle_root(empty,  index, old_path);
    let new_root = compute_merkle_root(commit, index, old_path);
    (old_root, new_root)
}



fn main(
    // private
    id      : Field,
    r       : Field,
    oldPath : [Field; DEPTH],

    // public
    oldRoot   : pub Field,
    newRoot   : pub Field,
    commitPub : pub Field,
    index     : pub Field,
) {
    // Check commitment
    assert(commitPub == commitment(id, r));

    // Check Merkle roots
    let (calc_old, calc_new) = roots(oldPath, index, commitPub);
    assert(oldRoot == calc_old);
    assert(newRoot == calc_new);
}
