# Copyright © 2020 SMAUG
# 
# https://github.com/smaug-group/cardano-sh-completion
#
# Install:
# $ sudo curl -o /etc/bash_completion.d/cardano https://raw.githubusercontent.com/smaug-group/cardano-sh-completion/master/cardano-completion.sh
#
# Then log out and log in again, or run `. ~/.bashrc`.


cardano_cli ()
{
    commands=(shelley version --help)
    find_arg ${commands[*]}
    case "$arg" in
        shelley)
            shelley "$3" "$2"
            return 0
            ;;
        version)
            return 0
            ;;
        --help)
            return 0
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

# $1 previous_word
# $2 current_word
shelley ()
{
    commands=(address stake-address transaction node stake-pool query block system genesis \
        governance text-view)
    find_arg ${commands[*]}
    case "$arg" in
        address)
            address "$1" "$2"
            ;;
        stake-address)
            stake_address "$1" "$2"
            ;;
        transaction)
            transaction "$1" "$2"
            ;;
        node)
            node "$1" "$2"
            ;;
        stake-pool)
            stake_pool "$1" "$2"
            ;;
        query)
            query "$1" "$2"
            ;;
        block)
            block "$1" "$2"
            ;;
        system)
            system "$1" "$2"
            ;;
        genesis)
            genesis "$1" "$2"
            ;;
        governance)
            governance "$1" "$2"
            ;;
        text-view)
            text_view "$1" "$2"
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

address ()
{
    commands=(key-gen key-hash build build-multisig info)
    find_arg ${commands[*]}
    case "$arg" in
        key-gen)
            options "$1" "$2" --verification-key-file --signing-key-file
            ;;
        key-hash)
            options "$1" "$2" --payment-verification-key-file --out-file
            ;;
        build)
            options "$1" "$2" --payment-verification-key-file --stake-verification-key-file \
                --mainnet --testnet-magic --out-file
            ;;
        build-multisig)
            return 0
            ;;
        info)
            options "$1" "$2" --address
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

stake_address ()
{
    commands=(key-gen build register delegate de-register registration-certificate \
        deregistration-certificate delegation-certificate)
    find_arg ${commands[*]}
    case "$arg" in
        key-gen)
            options "$1" "$2" --verification-key-file --signing-key-file
            ;;
        build)
            options "$1" "$2" --stake-verification-key-file --mainnet --testnet-magic --out-file
            ;;
        register)
            options "$1" "$2" --signing-key-file --host-addr --port
            ;;
        delegate)
            options "$1" "$2" --signing-key-file --pool-id --delegation-fee --host-addr --port
            ;;
        de-register)
            options "$1" "$2" --signing-key-file --host-addr --port
            ;;
        registration-certificate | deregistration-certificate)
            options "$1" "$2" --stake-verification-key-file --out-file
            ;;
        delegation-certificate)
            options "$1" "$2" --stake-verification-key-file --cold-verification-key-file --out-file
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

transaction ()
{
    commands=(build-raw sign witness sign-witness check submit calculate-min-fee info)
    find_arg ${commands[*]}
    case "$arg" in
        build-raw)
            options "$1" "$2" --tx-in --tx-out --ttl --fee --certificate-file \
                --update-protosal-file --out-file
            ;;
        sign)
            options "$1" "$2" --tx-body-file --signing-key-file --mainnet --testnet-magic --out-file
            ;;
        submit)
            options "$1" "$2" --tx-file --mainnet --testnet-magic
            ;;
        calculate-min-fee)
            options "$1" "$2" --tx-in-count --tx-out-count --ttl --mainnet --testnet-magic \
                --signing-key-file --certificate-file --protocol-params-file
            ;;
        witness | sign-witness | check | info)
            return 0
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

node ()
{
    commands=(key-gen key-gen-KES key-gen-VRF issue-op-cert)
    find_arg ${commands[*]}
    case "$arg" in
        key-gen)
            options "$1" "$2" --cold-verification-key-file --cold-signing-key-file \
                --operational-certificate-issue-counter-file
            ;;
        key-gen-KES | key-gen-VRF)
            options "$1" "$2" --verification-key-file --signing-key-file
            ;;
        issue-op-cert)
            options "$1" "$2" --kes-verification-key-file --cold-signing-key-file \
                --operational-certificate-issue-counter-file --kes-period --out-file
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

stake_pool ()
{
    commands=(register re-register retire registration-certificate deregistration-certificate id)
    find_arg ${commands[*]}
    case "$arg" in
        register | re-register)
            options "$1" "$2" --pool-id
            ;;
        retire)
            options "$1" "$2" --pool-id --epoch --host-addr --port
            ;;
        registration-certificate)
            options "$1" "$2" --cold-verification-key-file --vrf-verification-key-file \
                --pool-pledge --pool-cost --pool-margin --pool-reward-account-verification-key-file \
                --pool-owner-stake-verification-key-file --mainnet --testnet-magic --out-file
            ;;
        deregistration-certificate)
            options "$1" "$2" --cold-verification-key-file --epoch --out-file
            ;;
        id)
            options "$1" "$2" --verification-key-file
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

query ()
{
    commands=(pool-id protocol-parameters tip stake-distribution stake-address-info utxo version \
        ledger-state status)
    find_arg ${commands[*]}
    case "$arg" in
        pool-id | version)
            return 0
            ;;
        protocol-parameters | tip | stake-distribution | stake-address-info)
            options "$1" "$2" --mainnet --testnet-magic --out-file 
            ;;
        utxo)
            options "$1" "$2" --address --mainnet --testnet-magic --out-file 
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

block ()
{
    commands=(info)
    find_arg ${commands[*]}
    case "$arg" in
        info)
            options "$1" "$2" --block-id --host-addr --port
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

system ()
{
    commands=(start stop)
    find_arg ${commands[*]}
    case "$arg" in
        start)
            options "$1" "$2" --genesis --host-addr --port
            ;;
        stop)
            return 0
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

genesis ()
{
    commands=(key-gen-genesis key-gen-delegate key-gen-utxo key-hash get-ver-key initial-addr \
        initial-txin create)
    find_arg ${commands[*]}
    case "$arg" in
        key-gen-genesis | key-gen-utxo | get-ver-key)
            options "$1" "$2" --verification-key-file --signing-key-file
            ;;
        key-gen-delegate)
            options "$1" "$2" --verification-key-file --signing-key-file \
                --operational-certificate-issue-counter-file
            ;;
        key-hash)
            options "$1" "$2" --verification-key-file
            ;;
        initial-addr | initial-txin)
            options "$1" "$2" --verification-key-file --mainnet --testnet-magic --out-file
            ;;
        create)
            options "$1" "$2" --genesis-dir --gen-genesis-keys --gen-utxo-keys --start-time \
                --supply --mainnet --testnet-magic
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

governance ()
{
    commands=(create-mir-certificate create-update-proposal protocol-update cold-keys)
    find_arg ${commands[*]}
    case "$arg" in
        create-mir-certificate)
            options "$1" "$2" --reserves --treasury --stake-verification-key-file --reward --out-file
            ;;
        create-update-proposal)
            options "$1" "$2" --out-file --epoch --genesis-verification-key-file --min-fee-linear \
                --min-fee-constant --max-block-body-size --max-tx-size --max-block-header-size \
                --key-reg-deposit-amt --min-percent-refund --deposit-decay-rate --pool-reg-deposit \
                --min-pool-percent-refund --pool-deposit-decay-rate --pool-retirement-epoch-boundary \
                --number-of-pools --pool-influence --monetary-expansion --treasury-expansion \
                --decentralization-parameter --extra-entropy --protocol-major-version \
                --protocol-minor-version --min-utxo-value
            ;;
        protocol-update | cold-keys)
            options "$1" "$2" --cold-signing-key-file
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

text_view ()
{
    commands=(decode-cbor)
    find_arg ${commands[*]}
    case "$arg" in
        decode-cbor)
            options "$1" "$2" --in-file --out-file
            ;;
        *)
            reply "${commands[*]}" "$2"
            ;;
    esac
}

# Set $arg variable if argument found amond "$@"
find_arg ()
{
    arg=""
    for w in ${COMP_WORDS[@]:1};do
        for cmd in "$@"; do
            if [ "$w" = "$cmd" ]; then
                arg="$cmd";
                return 0
            fi
        done
    done
    return 1
}

options ()
{
    previous=$1
    word=$2
    shift 2
    if [ "$previous" = "--testnet-magic" ]; then
        reply "42" "$word"
        return 0
    else
        for opt in "$@"; do
            if [ "$opt" = "$previous" ]; then
                return 0
            fi
        done
    fi
    reply "$*" "$word"
}

reply ()
{
    COMPREPLY=($(compgen -W "$1" -- "$2"))
}

if [ -n "$ZSH_VERSION" ]; then
    autoload bashcompinit
    bashcompinit
fi

complete -o bashdefault -o default -F cardano_cli cardano-cli
