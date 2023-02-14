{DEFAULT @table_is_temp = FALSE}

{@table_is_temp} ? {
IF OBJECT_ID('tempdb..cohort_diagnostics_concept_counts_permanent_table', 'U') IS NOT NULL
  DROP TABLE cohort_diagnostics_concept_counts_permanent_table;
} : {
IF OBJECT_ID('@work_database_schema.cohort_diagnostics_concept_counts_permanent_table', 'U') IS NOT NULL
	DROP TABLE @work_database_schema.cohort_diagnostics_concept_counts_permanent_table;
}

SELECT concept_id,
	concept_count,
	concept_subjects
{@table_is_temp} ? {
INTO cohort_diagnostics_concept_counts_permanent_table
} : { 
INTO @work_database_schema.cohort_diagnostics_concept_counts_permanent_table
}
FROM (
	SELECT condition_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.condition_occurrence TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY condition_concept_id 
	
	UNION ALL
	
	SELECT condition_source_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.condition_occurrence TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY condition_source_concept_id 
	
	UNION ALL
	
	SELECT drug_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.drug_exposure TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY drug_concept_id 
	
	UNION ALL
	
	SELECT drug_source_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.drug_exposure TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY drug_source_concept_id 
	
	UNION ALL
	
	SELECT procedure_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.procedure_occurrence TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY procedure_concept_id 
	
	UNION ALL
	
	SELECT procedure_source_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.procedure_occurrence TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY procedure_source_concept_id 
	
	UNION ALL
	
	SELECT measurement_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.measurement TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY measurement_concept_id 
	
	UNION ALL
	
	SELECT measurement_source_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.measurement TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY measurement_source_concept_id 
	
	UNION ALL
	
	SELECT observation_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.observation TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY observation_concept_id 
	
	UNION ALL
	
	SELECT observation_source_concept_id AS concept_id,
		COUNT_BIG(*) AS concept_count,
		COUNT_BIG(DISTINCT person_id) AS concept_subjects
	FROM @cdm_database_schema.observation TABLESAMPLE SYSTEM (0.1) REPEATABLE (1311)
	GROUP BY observation_source_concept_id 
	) tmp;
