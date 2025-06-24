variables {
  repository_name = "MyRepo"
}

run "test_resource_creation" {
  command = plan
}