{DEFAULT @table_is_temp = FALSE}

{@table_is_temp} ? {
IF OBJECT_ID('tempdb..@concept_counts_table', 'U') IS NOT NULL
  DROP TABLE @concept_counts_table;
} : {
IF OBJECT_ID('@work_database_schema.@concept_counts_table', 'U') IS NOT NULL
	DROP TABLE @work_database_schema.@concept_counts_table;
}

SELECT concept_id,
	concept_count,
	concept_subjects
{@table_is_temp} ? {
INTO @concept_counts_table
} : { 
INTO @work_database_schema.@concept_counts_table
}
FROM SELECT * FROM '@work_database_schema'.cohort_diagnostics_concept_counts_permanent_table ;
