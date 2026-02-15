output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.sql_db.id
}

output "sql_connection_string" {
  description = "SQL Database connection string for ADO.NET client"
  sensitive   = true
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${random_password.sql_admin_password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}