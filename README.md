# AWS Infrastructure as Code - Secure Baseline 🚀

Este projeto utiliza **Terraform** para provisionar uma infraestrutura básica e segura na **AWS**, seguindo as melhores práticas de **DevSecOps**.

## 🛠️ Recursos Criados:
- **Rede:** VPC com Subnets, Route Tables e Internet Gateway.
- **Segurança:** Security Group configurado para permitir apenas tráfego essencial.
- **Armazenamento:** Bucket S3 com criptografia AES256, versionamento e bloqueio de acesso público.

## 🛡️ Destaques de Segurança (DevSecOps):
- Bloqueio total de acesso público no S3 (Anti-vazamento).
- Princípio do menor privilégio em Security Groups.
- Criptografia em repouso ativada por padrão.

## 🚀 Como executar:
1. Configure suas credenciais AWS via CLI.
2. `terraform init`
3. `terraform plan`
4. `terraform apply`