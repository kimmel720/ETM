require "refile/s3"

aws = {
  access_key_id: "AKIAIYIKVWZTV265K65Q",
  secret_access_key: "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",
  region: "US-Standard",
  bucket: "etm-photo-lib"
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
