// FLD A11Sm dependancies
MATCH query=((flda11sm:SQL)-[:DEPENDS*1..1]->(c:SQL))
WHERE flda11sm.table = 'tableau_fld_a11s_minified_v'
RETURN query