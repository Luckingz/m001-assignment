use cardano/transaction.{OutputReference, Transaction, placeholder}
use cardano/script_context.{ScriptContext, Spending}
use mocktail.{mock_utxo_ref}


validator spend_validator {
    spend(
        datum: Option<Data>,
        redeemer: Data,
        input: OutputReference,
        tx: Transaction,
    ) {
        True
    }

    else(_) {
        fail
    }
}

test spend_validator_pass() {
    trace @"The test is successful"
    spend_validator.spend(None, Void, mock_utxo_ref(0, 0), placeholder)
}

type MyDatum {
    value: ByteArray
}

test spend_validator_pass_two() {
    trace @"The test pass again"
    let my_datum = MyDatum { value: #"001122334455" }
    let data1: Option<Data> = Some(as_data(my_datum))
    let data2 = #"abc123"
    let data3 = 
    OutputReference {
        transaction_id: #"deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef",
        output_index: 0
    }
    let data4 = placeholder

    spend_validator.spend(data1, data2, data3, data4)
}


test spend_validator_fail() {
    trace @"The test failed"
    let context = 
    ScriptContext {
        transaction: placeholder,
        redeemer: Void,
        info: Spending(OutputReference {transaction_id: #"00", output_index: 0 }, 
        None
        ),
    }
    !spend_validator.else(context)
}