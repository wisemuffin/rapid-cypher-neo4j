// CSV - TBW to TDS - RELATIONSHIPS
LOAD CSV WITH HEADERS
FROM 'file:///tbw_to_tds_RAPID.csv' as row
//RETURN row

MATCH  (twb:TWB {name: row.Workbook}), (tds:TDS {name: row.Connection})

MERGE (twb)-[rel:DEPENDS]->(tds)
RETURN (twb)-[rel]->(tds)