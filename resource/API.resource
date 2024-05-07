*** Settings ***
Library   SeleniumLibrary
Library   Collections
Library   String
Library   RequestsLibrary
Resource  variables.resource

*** Keywords ***
Create API Session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=APITheOriginals  url=https://the-originals.qacoders-academy.com.br  
    ...                                                                        headers=${headers}
# AUTH    

Login de acesso   
   ${body}    Create Dictionary       mail=${mail}    password=${password}   
   Log  ${body}
   Create API Session    # Chamando a keyword diretamente
   ${response}=    POST On Session  alias=APITheOriginals  url=/api/login   json=${body}
   Log  ${response.json()}
   Set Test Variable    ${TOKEN}     ${response.json()["token"]}

    
Validar o token e gravar em um header de autorização
   ${headers}  Create Dictionary  Authorization=Bearer ${TOKEN}
   ${response}  GET On Session   alias=APITheOriginals   url=/api/validateToken  headers=${headers}
    Log    ${response.content}
    Log   ${TOKEN}

# USUÀRIO

Criar um novo usuário 
    ${palavra_randomica}=    Generate Random String    8    chars=[LETTERS]
    ${palavra_randomica}=    Convert To Lower Case    ${palavra_randomica}
    ${cpf_randomico}=        Generate Random String   11    chars=[NUMBERS]
    ${palavra_randomica}=    Generate Random String    100   chars=[LETTERS]
    ${palavra_randomica}=    Convert To Lower Case     ${palavra_randomica}
    Set Test Variable        ${CPF}                    ${cpf_randomico}
    Set Test Variable        ${EMAIL_TEST}              ${palavra_randomica}@hotmail.com
    Set Test Variable       ${nome100}                  ${palavra_randomica}

Criar um nome randomico departamento/board     
   ${nome_randomic}      Generate Random String    10   chars=[LETTERS]
   ${nome_randomic}      Convert To Lower Case    ${nome_randomic} 
   Set Test Variable    ${nomedepartamento}        ${nome_randomic}depmen
   Log     ${nomedepartamento}
   ${nome_randomic}      Generate Random String    9   chars=[LETTERS]
   ${nome_randomic}      Convert To Lower Case    ${nome_randomic} 
   Set Test Variable    ${nomedepart&}        ${nome_randomic}&
   Log     ${nomedepart&}
   ${nome_randomic}      Generate Random String    8   chars=[LETTERS]
   ${nome_randomic}      Convert To Uppercase    ${nome_randomic} 
   Set Test Variable    ${NOMEDEPAT}        ${nome_randomic}DEP
   Log          ${NOMEDEPAT} 
    ${nome_randomic}      Generate Random String    9   chars=[LETTERS]
   ${nome_randomic}      Convert To Lower Case    ${nome_randomic} 
   Set Test Variable    ${nomedepartminus}        ${nome_randomic}depar&
   Log     ${nomedepartminus}
   ${nome_randomic}      Generate Random String    50   chars=[LETTERS]
   ${nome_randomic}      Convert To Lower Case    ${nome_randomic} 
   Set Test Variable    ${nomecom50}            ${nome_randomic}
   Log     ${nomecom50}
   ${nome_randomic}      Generate Random String    7   chars=[LETTERS]
   ${nome_randomic}      Convert To Lower Case    ${nome_randomic} 
   Set Test Variable    ${nameboard}            ${nome_randomic}
   Log     ${nameboard} 
    

Cadastrar um usuario
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary        fullName=${fullName}   mail=${EMAIL_TEST} 
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}      cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user 
    ...  json=${body}    headers=${headers}    expected_status=201
    Log  ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['user']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


usuário com fullName em branco
    ${headers}=  Create Dictionary     Authorization=${TOKEN}
    ${body}    Create Dictionary           mail=${EMAIL_TEST}    password=${password} 
    ...  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]   O campo nome completo é obrigatório.

usuário com fullName com numeros
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName23}     mail=${EMAIL_TEST} 
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]  O campo nome completo não deve conter números

usuário com fullName com caracteres
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName##}     mail=${EMAIL_TEST}
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]  Informe o nome e sobrenome com as iniciais em letra maiúscula e sem caracteres especiais.

usuário com fullName com iniciais minúscula
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullNameminusculo}     mail=${EMAIL_TEST} 
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]  Informe o nome e sobrenome com as iniciais em letra maiúscula e sem caracteres especiais.



usuário com fullName com 101 caracteres
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName101carc}     mail=${EMAIL_TEST} 
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]  O nome completo deve ter no máximo 100 caracteres.

usuário com fullName com 100 caracteres 
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${nome100}      mail=${EMAIL_TEST}
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=201
    Log  ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['user']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}

usuário com email com espaço no dominio
   usuário com fullName com 100 caracteres 
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}     mail=${emailespacodominio} 
    ...    password=${password}  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
     Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]  O e-mail informado é inválido. Informe um e-mail no formato [nome@domínio.com].

usuário com email em branco 
   usuário com fullName com 100 caracteres 
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}      password=${password} 
    ...  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value           ${response.json()}[error]  O campo e-mail é obrigatório.

usuário com email inválido
   usuário com fullName com 100 caracteres 
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${emailinválido}  password=${password}
    ...  confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value           ${response.json()}[error]  O e-mail informado é inválido. Informe um e-mail no formato [nome@domínio.com].

usuário com senha em branco 
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${emailinválido}  
    ...    confirmPassword=${password}   accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   O campo senha é obrigatório

usuário com senha com 13 caracteres
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}  password=${password13} 
    ...    confirmPassword=${password13}  accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   Senha precisa ter: uma letra maiúscula, uma letra minúscula, um número, um caractere especial(@#$%) e tamanho entre 8-12.

usuário com senha com 7 caracteres
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}   mail=${EMAIL_TEST}  password=${password7}  
    ...    confirmPassword=${password7}  accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   Senha precisa ter: uma letra maiúscula, uma letra minúscula, um número, um caractere especial(@#$%) e tamanho entre 8-12.

usuário com senha com 8 caracteres  
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary        fullName=${fullName}   mail=${EMAIL_TEST}    password=${password8} 
    ...     confirmPassword=${password8}   accessProfile=${accessProfile}      cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  json=${body}    headers=${headers}    expected_status=201
    Log  ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['user']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


usuário com corfimar senha em branco  
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password} 
    ...    accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   O campo de confirmação de senha é obrigatório.

usário com confirmar senha diferente de senha  
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}
    ...    confirmPassword=${confirmarsenhadif}    accessProfile=${accessProfile}     cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   As senhas não coincidem.

usuário com perfil de acesso em branco 
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}  
    ...    confirmPassword=${password}        cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   O campo perfil de acesso é obrigatório.


usuario com perfil de acesso inválido
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}  
    ...    confirmPassword=${password}   accessProfile=${perfildeacessoinva}       cpf=${CPF}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   O campo perfil de acesso deve ser preenchido de acordo com o seu cargo exemplo: ADMIN.

usuário com cpf em branco 
    ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}  
    ...    confirmPassword=${password}   accessProfile=${accessProfile}   
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]   O campo CPF é obrigatório!

usuário com cpf com 10 números
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}  
    ...    confirmPassword=${password}   accessProfile=${accessProfile}       cpf=${CPF10}
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]    Deve preencher o CPF com 11 dígitos

usuário com cpf com 12 números
   ${headers}=  Create Dictionary      Authorization=${TOKEN}
    ${body}    Create Dictionary      fullName=${fullName}    mail=${EMAIL_TEST}    password=${password}  
    ...    confirmPassword=${password}   accessProfile=${accessProfile}       cpf=${CPF12} 
    Log  ${body}
   Create API Session
    ${response}  POST On Session   alias=APITheOriginals   url=/api/user  
    ...  json=${body}    headers=${headers}    expected_status=400
    Log  ${response.json()}
    Dictionary Should Contain Key      ${response.json()}          error
    List Should Contain Value          ${response.json()}[error]    Deve preencher o CPF com 11 dígitos
Listar usuários
    ${headers}=    Create Dictionary    Authorization=${token} 
    ${response}   GET On Session   alias=APITheOriginals   url=/api/user  headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 

###################DEPARTAMENTO
Incluir department
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${nomedepartamento}    costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}

departamento com letras maiusculas
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${NOMEDEPAT}   costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


departamento com letras minúscula
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${nomedepartminus}   costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


departamento com letras e caractere &
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${nomedepart&}  costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


departamento com letras e numeros
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${departamentnumero}  costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=400
    Log   ${response.json()}
    Dictionary Should Contain Key       ${response.json()}   error
    List Should Contain Value     ${response.json()}[error]   O campo 'departamento' só pode conter letras e o caractere especial '&'.

departamento com caracteres especias
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${department@@@#}  costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=400
    Log   ${response.json()}
    Dictionary Should Contain Key       ${response.json()}   error
    List Should Contain Value      ${response.json()}[error]   O campo 'departamento' só pode conter letras e o caractere especial '&'.

departament é obrigátorio
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary       costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=400
    Log   ${response.json()}
    Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value      ${response.json()}[error]  O campo 'departamento' é obrigatório.

department com nome ja cadastrado
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${nomedepartamento}   costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=409
    Log   ${response.json()}
    Dictionary Should Contain Key       ${response.json()}     alert
    List Should Contain Value      ${response.json()}[alert]   Não é possível salvar esse registro. Departamento já cadastrado no sistema.


departament com 51 caractere
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${departamento51}    costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=400
    Log   ${response.json()}
    Dictionary Should Contain Key     ${response.json()}    error
     List Should Contain Value     ${response.json()}[error]  O campo 'departamento' deve possuir no máximo 50 caracteres.

departament com 50 caractere
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=${nomecom50}    costCenterId=65855af6a2d3ae70485da0b7
    Log   ${body}
    Create API Session
    ${response}=    POST On Session    alias=APITheOriginals    url=/api/department/    json=${body}  
    ...        headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 
    


Listar department
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}  GET On Session  alias=APITheOriginals   url=/api/department  headers=${headers}
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 


Editar departamento
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary    departmentName=Registrosss    costCenterId=65855af6a2d3ae70485da0b7
    Create API Session
    ${response}  PUT On Session  alias=APITheOriginals   url=/api/department/66201627a8c16a1961d9710e  
    ...    json=${body}    headers=${headers}   expected_status=200
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}


# DIRETORIA
Listar diretoria
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}  GET On Session  alias=APITheOriginals   url=/api/board 
    ...  headers=${headers}    expected_status=200
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()} 


Incluir diretoria
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${nameboard}  
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...    json=${body}    headers=${headers}  expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}
    

diretoria com letras maiúsculas
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${NOMEDEPAT}   
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...    json=${body}    headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}  


diretoria com letras minúsculas      
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${nomedepartminus}
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}  

diretoria com letras e caractere &     
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${nomedepart&} 
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=201
    Log   ${response.json()}
    Set Test Variable    ${ID_USUARIO}   ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_USUARIO}   ${response.json()}  



diretoria com letras e números      
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${boardnumero}  
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=400
    Log   ${response.json()}
     Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]    O campo 'diretoria' só pode conter letras e o caractere especial '&'.
 
diretoria com caracteres especias
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${boardcaractere#}
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=400
    Log   ${response.json()}
     Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]    O campo 'diretoria' só pode conter letras e o caractere especial '&'. 


diretoria é obrigatório    
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary       
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=400
    Log   ${response.json()}
     Dictionary Should Contain Key      ${response.json()}    error
    List Should Contain Value           ${response.json()}[error]    O campo 'diretoria' é obrigatório.


diretoria ja cadastrado 
    ${headers}=    Create Dictionary    Authorization=${token}
    ${body}=    Create Dictionary      boardName=${nameboard} 
    Create API Session 
    ${response}   POST On Session  alias=APITheOriginals   url=/api/board  
    ...     json=${body}    headers=${headers}   expected_status=409
    Log   ${response.json()}
     Dictionary Should Contain Key      ${response.json()}    alert
    List Should Contain Value           ${response.json()}[alert]   Não é possível salvar esse registro. Diretoria já cadastrada no sistema.
