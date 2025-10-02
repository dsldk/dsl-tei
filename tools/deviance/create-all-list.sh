#!/bin/bash

cat odsformer_brutto_lower.csv \
    moth_stednavne_raa_lower.csv \
    ods_lemmaer_lower.txt \
    ods_lemmaer_lower_extended.txt \
    personnavne_lower_aa_uniq.txt \
    stednavne_lower_plus-aa_uniq.txt \
    numbers.txt \
    tags_attributes.txt \
    abbreviations.txt | sort -u > all.txt
