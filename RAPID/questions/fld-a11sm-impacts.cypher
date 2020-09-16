// FLD A11Sm view dependancies
MATCH query=((flda11sm:SQL)-[:IMPACTS*1..10]->(c))
WHERE flda11sm.table = 'tableau_fld_a11s_minified_v'
RETURN query