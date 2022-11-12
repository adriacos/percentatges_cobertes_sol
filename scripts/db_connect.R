library(odbc)
library(RODBC)


db_save <- function(data, tablename){
  postgresqlCon <- dbConnect(odbc::odbc(), .connection_string = "Driver={PostgreSQL ANSI};Server=95.216.35.146;\nDatabase=ifn;\nUID=ifn_guest;\nPWD=AB2ttf63HXB2PavdbgufpwKX;\nPort=5432;")
  dbWriteTable(postgresqlCon, DBI::Id(schema="adria", table=tablename), data, overwrite=T)
  dbDisconnect(postgresqlCon)
  gc()
}