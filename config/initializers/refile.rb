require "refile/s3"

aws = {
  access_key_id: "AKIAIPSH536XOMBYVGHQ",
  secret_access_key: "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",
  region: "US Standard",
  bucket: "etm-photo-lib",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
