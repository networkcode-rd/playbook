output "file1_path" {
  description = "The path to the first file created for file 1"
  value       = local_file.file1.filename
}

output "file2_path" {
  description = "The path to the first file created for file 2"
  value       = local_file.file2.filename
}