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
func l1_messaging_nft_address() -> (res: felt) {
}



//
// Getters
//



//
// Constructor
//

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    l1_messaging_nft: felt

) {
    l1_messaging_nft_address.write(l1_messaging_nft);
    return ();
}

// 
// External functions
//

@external
func create_l1_nft_message{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    l1_user: felt
) {
    alloc_locals;
    let (message_payload : felt*) = alloc();
    assert message_payload[0] = l1_user;
    let (l1_contract_address) = l1_messaging_nft_address.read();
    send_message_to_l1(to_address=l1_contract_address, payload_size=1, payload=message_payload);
    return ();
}



