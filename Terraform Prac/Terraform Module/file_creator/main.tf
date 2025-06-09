terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.5.3"
    }
  }
}

resource "local_file" "file1" {
  content  = var.file_content1
  filename = "${path.module}/${var.file_name1}"
}

resource "local_file" "file2" {
  content  = var.file_content2
  filename = "${path.module}/${var.file_name2}"
}