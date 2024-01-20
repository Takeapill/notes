#!/bin/bash

# Vérification des arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <fichier_texte>"
    exit 1
fi

# Fichier texte
fichier_texte="$1"

# Tableau associatif pour stocker les occurrences
declare -A occurrences

# Transformation du texte
cat "$fichier_texte" | tr '[:upper:]' '[:lower:]' | tr -sc 'a-z' ' ' | tr -s ' ' | while read -r mot; do
    # Vérifier si le mot n'est pas vide
    if [ -n "$mot" ]; then
        # Ajouter le mot au tableau associatif avec un préfixe
        mot_cle="Mot_$mot"
        occurrences["$mot_cle"]=$((occurrences["$mot_cle"] + 1))
    fi
done

# Afficher le résultat
for mot in "${!occurrences[@]}"; do
    # Retirer le préfixe pour l'affichage
    mot_original="${mot#Mot_}"
    echo "Le mot '$mot_original' apparaît ${occurrences[$mot]} fois."
done

