*** Settings ***
Resource    ../resource/API.resource
Resource    ../resource/variables.resource
*** Test Cases ***
CT01 - Cadastrar um Board
    Create API Session  
    Login de acesso 
    Criar um nome randomico departamento/board 
   Incluir diretoria

CT02 - diretoria com letras maiúsculas
   Create API Session  
   Login de acesso
   Criar um nome randomico departamento/board 
   diretoria com letras maiúsculas

CT03 - diretoria com letras minúsculas
    Create API Session  
    Login de acesso
    Criar um nome randomico departamento/board 
   diretoria com letras minúsculas

CT04 - diretoria com letras e caractere & 
   Create API Session  
   Login de acesso
   Criar um nome randomico departamento/board 
   diretoria com letras e caractere & 

CT05 - diretoria com letras e números
   Create API Session  
   Login de acesso
   diretoria com letras e números


CT06 - diretoria com caracteres especias
   Create API Session  
    Login de acesso 
   diretoria com caracteres especias
   
CT07 - diretoria é obrigatório 
    Create API Session  
    Login de acesso 
    diretoria é obrigatório    


CT08 - diretoria ja cadastrado 
    Create API Session  
    Login de acesso 
    Criar um nome randomico departamento/board 
    Incluir diretoria
     diretoria ja cadastrado 




CT9 - Listar diretoria
    Create API Session  
    Login de acesso 
    Listar diretoria  
   
    