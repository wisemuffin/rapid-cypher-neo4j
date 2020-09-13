// JSON RAPID - 23,  tab, cc, fld
CALL apoc.load.json('/allSql.json') YIELD value as row
//RETURN row LIMIT 10
WITH row
  , toLower(replace(split(row.parent,'.')[0],'"','')) as parent_shema
  , toLower(replace(split(row.parent,'.')[1],'"','')) as parent_table
WHERE row.ddl_type CONTAINS 'CREATE' OR row.ddl_type CONTAINS 'ALTER' // remove other DDL statements e.g. DROP
UNWIND row.depnd_tables as depnd_tables
WITH parent_shema
  , parent_table
  , toLower(replace(split(depnd_tables,'.')[0],'"','')) as child_shema
  , toLower(replace(split(depnd_tables,'.')[1],'"','')) as child_table
WHERE child_table IS NOT NULL // removes temp tables and some incorrect tagging of tables

/////////////////////// EXAMPLE CHECKPOINT 1 /////////////////////
	AND (trim(toLower(parent_shema)) IN ['tableau_dde', 'field_dde', 'cc_dde', 'nbn_dde_23']
    	OR trim(toLower(child_shema)) IN ['tableau_dde', 'field_dde', 'cc_dde', 'nbn_dde_23']
        //OR toLower(parent_table) CONTAINS 'work'
        )
// RETURN parent_shema, parent_table, child_shema, child_table LIMIT 10
/////////////////////// EXAMPLE CHECKPOINT 1 /////////////////////

// INSET DATA
//MERGE (parent:SQL {id:  parent_shema+'.'+parent_table})
//SET parent.table = parent_table
//	, parent.schema = parent_shema
    
//MERGE (child:SQL {id:  child_shema+'.'+child_table})
//SET child.table = child_table
//	, child.schema = child_shema

CALL apoc.merge.node(['SQL'], {name: parent_shema+'.'+parent_table}, {schema: parent_shema, table:parent_table}) YIELD node as n1
WITH * WHERE parent_shema <> ''
	AND NOT parent_shema CONTAINS 'C:' // removing some funny schema names
CALL apoc.create.addLabels(n1, [toUpper(parent_shema)]) YIELD node as n2

CALL apoc.merge.node(['SQL'], {name: child_shema+'.'+child_table}, {schema: child_shema, table: child_table}) YIELD node as n3
WITH * WHERE child_shema <> '' 
	AND NOT child_shema CONTAINS 'C:' // removing some funny schema names
CALL apoc.create.addLabels(n3, [toUpper(child_shema)]) YIELD node as n4
    
//MERGE (p:SQL)-[rel:DEPENDS]->(c:SQL)

/////////////////////// EXAMPLE CHECKPOINT 2 /////////////////////
// MATCH (n)
// RETURN n
/////////////////////// EXAMPLE CHECKPOINT 2 /////////////////////
MATCH (p:SQL {name: parent_shema+'.'+parent_table}), (c:SQL {name: child_shema+'.'+child_table})
MERGE (p)-[rel:DEPENDS]->(c)

// CALL apoc.merge.relationship()
RETURN count(p)