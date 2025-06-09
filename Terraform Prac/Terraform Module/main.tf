terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}

module "create_files" {
  source = "./file_creator"

  file_content1 = "Hello, this is file 1!. Modified from main.tf"
  file_content2 = "Hello this is file 2. Modified from main.tf"
  file_name1    = "file1.txt"
  file_name2    = "file2.txt"
  
}

output "file_paths" {
  description = "The paths to the files created by the module"
  value = {
    file1_path = module.create_files.file1_path
    file2_path = module.create_files.file2_path
  }
  
}