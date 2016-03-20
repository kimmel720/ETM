require "refile/s3"

aws = {
  access_key_id: "AKIAJNCF7VAV6RO7JKNQ",
  secret_access_key: "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",
  region: "US Standard",
  bucket: "etm-photo-lib",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
