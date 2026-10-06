#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
  printf '%s\n' 'Please provide an element as an argument.'
  exit 0
fi

if ! element_data=$(psql \
  --username=freecodecamp \
  --dbname=periodic_table \
  --no-psqlrc \
  --quiet \
  --tuples-only \
  --no-align \
  --field-separator='|' \
  --set="element=$1" \
  --file=- <<'SQL'
SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
FROM elements AS e
JOIN properties AS p USING (atomic_number)
JOIN types AS t USING (type_id)
WHERE e.atomic_number::text = :'element'
   OR lower(e.symbol) = lower(:'element')
   OR lower(e.name) = lower(:'element')
LIMIT 1;
SQL
); then
  exit 1
fi

if [[ -z "$element_data" ]]; then
  printf '%s\n' 'I could not find that element in the database.'
  exit 0
fi

IFS='|' read -r atomic_number name symbol type atomic_mass melting_point boiling_point <<< "$element_data"
printf "The element with atomic number %s is %s (%s). It's a %s, with a mass of %s amu. %s has a melting point of %s celsius and a boiling point of %s celsius.\n" \
  "$atomic_number" "$name" "$symbol" "$type" "$atomic_mass" "$name" "$melting_point" "$boiling_point"
