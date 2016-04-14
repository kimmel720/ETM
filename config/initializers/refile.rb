require "refile/s3"

aws = {
  access_key_id: "AKIAJ27BI4IUFEJXZ2JQ",
  secret_access_key: "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",
  region: "us-east-1",
  bucket: "etm-photo-lib"
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
