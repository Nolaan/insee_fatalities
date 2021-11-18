\c mortalite_insee;
DELETE FROM insee WHERE date_deces >= TO_DATE('2021-07-01','YYYY-MM-DD');
