*** Settings ***
Resource    ../resource/API.resource
Resource    ../resource/variables.resource
*** Test Cases ***
CT01 - Cadastrar um Departamento
   Create API Session  
   Login de acesso 
   Criar um nome randomico departamento/board 
   Incluir department


CT02 - departamento com letras maiusculas  
   Create API Session  
   Login de acesso   
   Criar um nome randomico departamento/board 
   departamento com letras maiusculas 
  
CT03 - departamento com letras minúscula
    Create API Session  
    Login de acesso
    Criar um nome randomico departamento/board 
    departamento com letras minúscula

CT04 - departamento com letras e caractere &
   Create API Session  
   Login de acesso  
   Criar um nome randomico departamento/board 
   departamento com letras e caractere &


CT05 - departamento com letras e numeros
    Create API Session  
    Login de acesso
    departamento com letras e numeros

CT06 - departamento com caracteres especias
   Create API Session  
    Login de acesso 
   departamento com caracteres especias

CT07 - departament é obrigátorio
   Create API Session  
    Login de acesso 
   departament é obrigátorio

CT08 - department com nome ja cadastrado
   Create API Session  
   Login de acesso 
   Criar um nome randomico departamento/board 
    Incluir department
   department com nome ja cadastrado

CT09 - departament com 51 caractere
  Create API Session  
   Login de acesso
  departament com 51 caractere

CT10 - departament com 50 caractere
   Create API Session  
   Login de acesso
   Criar um nome randomico departamento/board 
  departament com 50 caractere

CT11 - Editar departamento
   Create API Session  
   Login de acesso 
   Editar departamento


CT12 - Listar departamento
   Create API Session  
   Login de acesso 
   Listar department


