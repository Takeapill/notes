#!/bin/bash
#
# Shell script permettant de calculer la factorielle d'un nombre
# Utilisation : --dc active l'utilisation de dc, -v valeur à calculer

calculate_factorial_basic() {

# Ce programme ne prend pas en compte les cas où l'entrée est négative 
# (comme mentionné dans l'énoncé, la factorielle d'un nombre négatif n'est pas définie).
# l'utilisation d'une boucle quelconque peut être inefficace pour des entrées très grandes, car elle effectue une multiplication itérative.

    num=$1
    factorial=1

    while [ $num -gt 1 ]; do
        factorial=$((factorial * num))
        num=$((num - 1))
    done

    echo $factorial
}

calculate_factorial_dc() {
    num=$1
    dc_script="[d1-d1<F*]dsFxp"
    result=$(echo "$num $dc_script" | dc)
    echo $result
}

print_help() {
    echo "Usage: $0 [--value <number>] [--dc] [-h, --help]"
    echo "Options:"
    echo "  -v | --value <number>   Specify the number for factorial calculation."
    echo "  --dc               Use dc for factorial calculation."
    echo "  -h, --help         Display this help message."
    exit 0
}

use_dc=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --dc)
            use_dc=true
            shift
            ;;
        -v|--value)
            shift
            value=$1
            ;;
        -h|--help)
            print_help
            ;;
        *)
            echo "Option non reconnue: $1"
            exit 1
            ;;
    esac
    shift
done

if [ -z "$value" ]; then
    echo "Veuillez spécifier une valeur avec l'option -v ou --value."
    exit 1
fi

if [ "$use_dc" = true ]; then
    result=$(calculate_factorial_dc $value)
    echo "La factorielle de $value est : $result"
else
    result=$(calculate_factorial_basic $value)
    echo "La factorielle de $value est : $result"
fi
