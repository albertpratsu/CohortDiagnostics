# Copyright 2023 OXINFER
#
# This file is part of CohortDiagnostics
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Function to create the counts table
#' 
#' @param connection Connection to tha database created with DatabaseConnector
#' @param cdmDatabaseSchema Schema where cdm is stored
#' @param writeDatabaseSchema Schema where table should be created
#' 
#' @export
#' 
#' @return 
#' @example 
#' 
createCountsTable <- function(connection,
                              cdmDatabaseSchema,
                              writeDatabaseSchema) {
  sql <-
    SqlRender::loadRenderTranslateSql(
      "CreationOfConceptCountTable.sql",
      packageName = utils::packageName(),
      dbms = connection@dbms,
      cdm_database_schema = cdmDatabaseSchema,
      work_database_schema = writeDatabaseSchema
    )
  DatabaseConnector::executeSql(connection, sql)
}

#' @param connection Connection to tha database created with DatabaseConnector
#' @param cdmDatabaseSchema Schema where cdm is stored
#' @param writeDatabaseSchema Schema where table should be created
#' 
#' @noRd
#' 
#' @return 
#' @example 
#' 
createCountsTableSample <- function(connection,
                                    cdmDatabaseSchema,
                                    writeDatabaseSchema) {
  sql <-
    SqlRender::loadRenderTranslateSql(
      "CreationOfConceptCountTableL100.sql",
      packageName = utils::packageName(),
      dbms = connection@dbms,
      cdm_database_schema = cdmDatabaseSchema,
      work_database_schema = writeDatabaseSchema
    )
  DatabaseConnector::executeSql(connection, sql)
}
