%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero

from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from starkware.cairo.common.uint256 import (
    Uint256,
    uint256_add,
    uint256_sub,
    uint256_le,
    uint256_lt,
    uint256_check,
    uint256_eq,
)
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1
from contracts.token.ERC20.IERC20 import IERC20

//
// Storage vars
//

@storage_var
func l1_evaluator_address_storage() -> (res: felt) {
}

@storage_var
func random_value_storage() -> (res: felt) {
}


//
// Getters
//

@view
func random_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
) -> (random: felt) {
    let (random) = random_value_storage.read();
    return (random,);
}

//
// Constructor
//

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    l1_evaluator_address: felt

) {
    l1_evaluator_address_storage.write(l1_evaluator_address);
    return ();
}

// 
// External functions
//

@l1_handler
func ex4{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    from_address: felt, random_value: felt
) {
    let (l1_evaluator_address) = l1_evaluator_address_storage.read();
    with_attr error_message("Message was not sent by the official L1 contract") {
        assert from_address = l1_evaluator_address;
    }

    random_value_storage.write(random_value);
    return();
}




