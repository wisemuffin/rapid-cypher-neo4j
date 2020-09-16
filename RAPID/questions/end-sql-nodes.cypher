// End SQL nodes
MATCH (sql:SQL)
WHERE NOT (sql)-[:DEPENDS]->()
RETURN DISTINCT sql.schema, sql.table