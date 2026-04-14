# ==========================================
# Security Group (O Firewall da nossa EC2)
# ==========================================
resource "aws_security_group" "web_sg" {
  name        = "web-seguro"
  description = "Permite trafego HTTP e controla saida"
  vpc_id      = aws_vpc.main.id

  # Regra de Entrada (Ingress): Quem pode acessar o servidor
  ingress {
    description = "HTTP da Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra de Saída (Egress): Para onde o servidor pode se conectar
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-seguro"
  }
}