# ==========================================
# S3 Bucket (Armazenamento de Arquivos)
# ==========================================
resource "aws_s3_bucket" "secure_data" {
  # IMPORTANTE: O nome do bucket tem que ser ÚNICO NO MUNDO! 
  # Troque "johnata" por algo seu, ou adicione numeros aleatorios no final.
  bucket = "bucket-sec-devsecops-kctxd" 
}

# Regra 1: Bloqueio TOTAL de acesso público (Evita vazamento de dados)
resource "aws_s3_bucket_public_access_block" "secure_data_block" {
  bucket = aws_s3_bucket.secure_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Regra 2: Criptografia ativada por padrão (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_data_crypto" {
  bucket = aws_s3_bucket.secure_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Regra 3: Versionamento (Protege contra deleção acidental)
resource "aws_s3_bucket_versioning" "secure_data_versioning" {
  bucket = aws_s3_bucket.secure_data.id
  versioning_configuration {
    status = "Enabled"
  }
}