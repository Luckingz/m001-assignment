use cardano/transaction.{OutputReference, Transaction, placeholder}
use cardano/assets.{PolicyId}
use cardano/script_context.{ScriptContext, Minting}


validator mint_validator {
    mint(
        redeemer: Data,
        policy_id: PolicyId,
        tx: Transaction
    ) {
        trace @"Minting validator called"
        True
    }
    else(_) {
        fail
    }
}





test mint_validator_pass() {

    trace @"The first test is called"

    mint_validator.mint(Void, #"", placeholder)
}


test second_mint_validator_pass() {
    trace @"Fixing values"

    let data1 = #"f4c9f9c4252d86702c2f4c2e49e6648c7cffe3c8f2b6b7d779788f50"
    let data2 = "khkj388274hd"
    let data3 = placeholder
    
    trace @"The second test is called"
    mint_validator.mint(data1, data2, data3)

}


test mint_validator_fail() {
    trace @"This should fail"

    let context = 
    ScriptContext{
        transaction: placeholder,
        redeemer: None,
        info: Minting(#"f4c9f9c4252d86702c2f4c2e49e6648c7cffe3c8f2b6b7d779788f50")
    }
    

    !mint_validator.else(context)
}