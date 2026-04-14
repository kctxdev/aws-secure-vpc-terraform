# ==========================================
# 1. VPC (A sua Rede Virtual Isolada)
# ==========================================
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-segura-devsecops"
  }
}

# ==========================================
# 2. Subnets (Segregação de Ambiente)
# ==========================================

# Subnet Pública (Para recursos que precisam de internet, ex: Load Balancer)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Permite receber IP público
  availability_zone       = "sa-east-1a"

  tags = {
    Name = "subnet-publica"
  }
}

# Subnet Privada (Totalmente isolada da internet, máxima segurança)
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "subnet-privada"
  }
}

# ==========================================
# 3. Internet Gateway e Roteamento
# ==========================================

# Internet Gateway (A porta de saída para a internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-principal"
  }
}

# Tabela de Roteamento para a Subnet Pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "tabela-roteamento-publica"
  }
}

# Associando a Tabela de Roteamento apenas à Subnet Pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
