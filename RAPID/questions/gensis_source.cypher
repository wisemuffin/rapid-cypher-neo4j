// FIND FLD A11Sm TDS Staging depenencies
MATCH query=((tds:TDS)-[:DEPENDS]->(sql:SQL)-[:DEPENDS*1..15]->(gen:SQL))
WHERE toUpper(gen.table) contains 'GEN'
RETURN query