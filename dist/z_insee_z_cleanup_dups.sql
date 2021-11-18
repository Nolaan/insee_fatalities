\c mortalite_insee;
DELETE FROM insee a USING (
  SELECT MIN(ctid) as ctid, nom, prenoms, date_deces, code_lieu_deces, numero_acte_deces
  FROM insee
  GROUP BY nom, prenoms, date_deces, code_lieu_deces, numero_acte_deces    
  HAVING COUNT(*) > 1
) b
WHERE a.date_deces >= TO_DATE('2020-01-07', 'YYYY-MM-DD')
AND a.numero_acte_deces = b.numero_acte_deces
AND a.nom  = b.nom
AND a.prenoms = b.prenoms
AND a.date_deces = b.date_deces
AND a.code_lieu_deces = b.code_lieu_deces
AND a.ctid <> b.ctid

