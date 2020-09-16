// CSV - TDS to RAPID
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/tds_to_rapid_columns_removed.csv' as row
WITH DISTINCT row.tds as tds_name
//RETURN count(tds)
MERGE (tds:TDS {name: tds_name})
RETURN tds
;