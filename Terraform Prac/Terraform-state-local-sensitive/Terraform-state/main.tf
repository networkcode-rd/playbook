resource "local_file" "demo-1" {
  content  = "This is demo content-1"
  filename = "${path.module}/demo-1.txt"
}

resource "local_file" "demo-2" {
  content  = "THis is demo content-2"
  filename = "${path.module}/demo-2.txt"
}

resource "local_sensitive_file" "demo-sensitive" {
  content  = "This is sensitive content Wassup12345"
  filename = "${path.module}/sensitive.md"
}