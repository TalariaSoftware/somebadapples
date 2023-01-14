SELECT
  officers.id AS officer_id,
  positions.agency_id AS agency_id
  FROM officers
  JOIN positions ON officers.id = positions.officer_id
