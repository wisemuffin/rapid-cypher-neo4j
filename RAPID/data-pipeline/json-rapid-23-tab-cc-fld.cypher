// JSON RAPID - 23,  tab, cc, fld
CALL apoc.load.json('https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/allSql.json') YIELD value as row
//RETURN row LIMIT 10
WITH row
  , toLower(replace(split(row.parent,'.')[0],'"','')) as parent_shema
  , toLower(replace(split(row.parent,'.')[1],'"','')) as parent_table
  , row.path as path
WHERE (row.ddl_type CONTAINS 'CREATE' OR row.ddl_type CONTAINS 'ALTER') // remove other DDL statements e.g. DROP
  AND parent_shema IN ["nbn_dde_23","cc_dde","nbn_dde_intraday","field_dde","tableau_dde","bia_sa_stg","wwm_sa_stg","nbn_dde_02","spt_sa_stg","rmdy_sa_stg","enc_dde","ful_sa_stg","ref_sa_stg","hfs_sa_stg","neto_dde","lld","hwm_sa_stg","splnk_sa_stg","bia_ba_eul","omn_dde","nbn_dde_24","public","duncanwelsh","bia_ba_cal", "neto_stg", "pni_sa_stg", "slf_sa_stg", "streamline"]
UNWIND row.depnd_tables as depnd_tables
WITH parent_shema
  , parent_table
  , path
  , toLower(replace(split(depnd_tables,'.')[0],'"','')) as child_shema
  , toLower(replace(split(depnd_tables,'.')[1],'"','')) as child_table
WHERE child_table IS NOT NULL // removes temp tables and some incorrect tagging of tables
  AND child_shema IN ["nbn_dde_23","cc_dde","nbn_dde_intraday","field_dde","tableau_dde","bia_sa_stg","wwm_sa_stg","nbn_dde_02","spt_sa_stg","rmdy_sa_stg","enc_dde","ful_sa_stg","ref_sa_stg","hfs_sa_stg","neto_dde","lld","hwm_sa_stg","splnk_sa_stg","bia_ba_eul","omn_dde","nbn_dde_24","public","duncanwelsh","bia_ba_cal", "neto_stg", "pni_sa_stg", "slf_sa_stg", "streamline"]


CALL apoc.merge.node(['SQL'], {name: parent_shema+'.'+parent_table}, {schema: parent_shema, table:parent_table, path:path}) YIELD node as n1
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