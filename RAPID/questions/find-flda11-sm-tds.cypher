// FIND FLD A11Sm TDS
MATCH query=((tds:TDS)-[:DEPENDS*1..3]->(slq:SQL))
WHERE tds.name = 'FLD A11Sm - Orders and Incidents'
RETURN query