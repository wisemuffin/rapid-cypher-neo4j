// CSV - TDS to RAPID Rel
LOAD CSV WITH HEADERS
FROM 'file:///tds_to_rapid_columns_removed.csv' as row

MATCH (tds:TDS {name: row.tds}), (sql:SQL {name: row.schema+'.'+row.table})

MERGE (tds)-[rel:DEPENDS]->(sql)
RETURN (tds)-[rel]->(sql)