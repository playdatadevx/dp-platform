
## tfstate 파일용 lock 테이블
resource "aws_dynamodb_table" "terraform_lock" {
  name = "tfstateLock"
  hash_key = "LockID"
  read_capacity = 1
  write_capacity = 1
    
  attribute {
    name = "LockID"
    type = "S"
  }
}

## 로그 저장용 버킷

resource "aws_s3_bucket" "logs" {
  bucket = "playdata.devx.logs"
}
resource "aws_s3_bucket_acl" "log-delivery-write" {
  bucket = aws_s3_bucket.logs.id
  acl = "private"
}

## tfstate 저장용 버킷
resource "aws_s3_bucket" "terraform_state" {
  bucket = "playdata.devx.terraform.state"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl = "private"
}
