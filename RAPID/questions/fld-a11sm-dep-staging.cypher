// FIND FLD A11Sm TDS Staging depenencies
MATCH query=((tds:TDS)-[:DEPENDS*1..12]->(sql:SQL))
WHERE tds.name = 'FLD A11Sm - Orders and Incidents'
WITH sql
WHERE toUpper(sql.schema) = 'BIA_SA_STG'
RETURN sql.name, sql.schema, sql.table