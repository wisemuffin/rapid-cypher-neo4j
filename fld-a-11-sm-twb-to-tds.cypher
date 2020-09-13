//FLD A11Sm twb to tds
MATCH (twb:TBW)-[:DEPENDS]->(tds:TDS)
WHERE tds.name = 'FLD A11Sm - Orders and Incidents'
RETURN tds