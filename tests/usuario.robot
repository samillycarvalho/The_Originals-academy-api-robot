*** Settings ***
Resource    ../resource/API.resource
Resource    ../resource/variables.resource
*** Test Cases ***
TC01 - Cadastrar um novo usuário com sucesso
   Create API Session
   Login de acesso  
   Criar um novo usuário
   Cadastrar um usuario
   
TC02 - usuário com fullName em branco    
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com fullName em branco

CT03 - usuário com fullName com numeros
   Create API Session
   Login de acesso  
   Criar um novo usuário

   usuário com fullName com numeros   

CT04 - usuário com caracteres
  Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com fullName com caracteres  

CT05 - usuário com iniciais minúscula   
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com fullName com iniciais minúscula

CT06 - usuário com fullName com 101 caracteres
    Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com fullName com 101 caracteres

CT07 - usuário com fullName com 100 caracteres 
    Create API Session
   Login de acesso  
   Criar um novo usuário
   usuáriocom fullName com 100 caracteres

CT08 - usuário com email com espaço no dominio
   Create API Session
   Login de acesso  
   Criar um novo usuário
  usuário com email com espaço no dominio

CT09 - usuário com email em branco  
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com email em branco

CT10 - usuário com email inválido
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com email inválido

CT11 - usuário com senha em branco 
   Create API Session
   Login de acesso  
   Criar um novo usuário
  usuário com senha em branco 

CT12 - usuário com senha com 13 caracteres
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com senha com 13 caracteres  

CT13 - usuário com senha com 7 caracteres
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com senha com 7 caracteres

CT14 - usuário com senha com 8 caracteres   
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com senha com 8 caracteres

CT15 - usuário com corfimar senha em branco     
    Create API Session
   Login de acesso  
   Criar um novo usuário  
   usuário com corfimar senha em branco 

CT16 - usário com confirmar senha diferente de senha   
   Create API Session
   Login de acesso  
   Criar um novo usuário
  usário com confirmar senha diferente de senha

CT17 - usuário com perfil de acesso em branco  
   Create API Session
   Login de acesso  
   Criar um novo usuário
  usuário com perfil de acesso em branco 

CT18 - usuario com perfil de acesso inválido
   Create API Session
   Login de acesso  
   Criar um novo usuário
     usuario com perfil de acesso inválido

CT19 - usuário com cpf em branco     
   Create API Session
   Login de acesso  
   Criar um novo usuário
   usuário com cpf em branco 

CT20 - usuário com cpf com 10 números
   Create API Session
   Login de acesso  
   Criar um novo usuário
  usuário com cpf com 10 números

CT21 - usuário com cpf com 12 números 
   Create API Session
   Login de acesso  
   Criar um novo usuário  
  usuário com cpf com 12 números