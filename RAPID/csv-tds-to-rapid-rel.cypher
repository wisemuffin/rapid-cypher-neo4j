// CSV - TBW to TDS - RELATIONSHIPS
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/tds_to_rapid_columns_removed.csv' as row
//RETURN row

MATCH  (twb:TWB {name: row.`Workbook Name`}), (tds:TDS {name: row.`Datasource Name`})

MERGE (twb)-[rel:DEPENDS]->(tds)
MERGE (twb)<-[:IMPACTS]-(tds)
RETURN (twb)-[rel]->(tds)