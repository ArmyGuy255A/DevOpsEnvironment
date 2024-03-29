path "kv/*" {
	capabilities = ["list"]
}
path "kv/data/helpdesk/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
path "kv/data/mcsc/*" {
  capabilities = [, "read", "list"]
}