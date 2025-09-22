*** Settings ***
Documentation     Arquivo de recursos contendo keywords de baixo nível para automação do Kabum.
Library           SeleniumLibrary

*** Keywords ***

# Abre o site no navegador especificado ( Nosso caso o Chrome) e tira print da tela inicial
Abrir o site da Kabum
    [Arguments]    ${url}    ${navegador}
    Open Browser    ${url}    ${navegador}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Set Screenshot Directory    ${EXECDIR}/results    # Define pasta de prints
    Log To Console    Navegador aberto e site da Kabum! acessado.
    Capture Page Screenshot    filename=01_pagina_inicial.png

# Aceita cookies se o pop-up aparecer
Aceitar cookies se necessario
    ${cookie_button_present}=    Run Keyword And Return Status    Page Should Contain Element    id:onetrust-accept-btn-handler
    IF    ${cookie_button_present}
        Click Button    id:onetrust-accept-btn-handler
        Log To Console    Botão de cookies aceito.
        Capture Page Screenshot    filename=02_cookies_aceitos.png
    ELSE
        Log To Console    Pop-up de cookies não encontrado.
    END

# Realizara a busca pelo produto, digitando caractere a caractere
Realizar a busca pelo produto
    [Arguments]    ${termo}
    Wait Until Element Is Visible    id:inputBusca    timeout=10s
    Click Element    id:inputBusca
    Clear Element Text    id:inputBusca
    ${tamanho}=    Get Length    ${termo}
    FOR    ${i}    IN RANGE    ${tamanho}
        ${char}=    Evaluate    "${termo}[${i}]"
        Press Keys    id:inputBusca    ${char}
    END
    Press Keys    id:inputBusca    RETURN
    Wait Until Element Is Visible    css:.productCard    timeout=20s
    Log To Console    Busca por "${termo}" realizada com sucesso.
    Capture Page Screenshot    filename=03_resultado_busca.png

# Selecionara o primeiro produto da lista de resultados
Selecionar o primeiro produto da lista
    Wait Until Element Is Visible    css:.productCard a    timeout=30s
    ${primeiro_produto}=    Get WebElements    css:.productCard a
    Scroll Element Into View    ${primeiro_produto}[0]
    Click Element               ${primeiro_produto}[0]
    Wait Until Element Is Visible    tag:h1    timeout=30s
    Log To Console    Primeiro produto da lista selecionado.
    Capture Page Screenshot    filename=04_pagina_produto.png

# Salvara o nome do produto para validar no carrinho
Salvar o nome do produto selecionado
    ${nome_produto}=    Get Text    tag:h1
    Set Suite Variable    ${NOME_PRODUTO_PAGINA}    ${nome_produto}
    Log To Console    Nome do produto salvo: ${NOME_PRODUTO_PAGINA}

# Calcula o frete e valida se foi exibido corretamente
Calcular e validar o frete
    [Arguments]    ${cep}
    Wait Until Element Is Visible    id=inputCalcularFrete    timeout=10s
    Scroll Element Into View         id=inputCalcularFrete
    Click Element                    id=inputCalcularFrete
    Input Text                       id=inputCalcularFrete    ${cep}
    Wait Until Page Contains          Entrega    timeout=15s
    Wait Until Page Contains          R$         timeout=15s
    Log To Console                   Cálculo de frete realizado.
    Capture Page Screenshot    filename=05_frete_calculado.png

# Adiciona o produto ao carrinho
Adicionar o produto ao carrinho
    Wait Until Page Contains Element    xpath=//span[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'adicionar ao carrinho')]    timeout=30s
    Wait Until Element Is Visible       xpath=//span[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'adicionar ao carrinho')]    timeout=10s
    Click Element                       xpath=//span[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'adicionar ao carrinho')]
    Log To Console    Produto adicionado no carrinho.
    Capture Page Screenshot    filename=06_produto_adicionado_popup.png

# Vai para a página do carrinho
Entrar no carrrinho
    Wait Until Element Is Visible    id=linkCarrinhoHeader    timeout=10s
    Click Element    id=linkCarrinhoHeader
    Wait Until Page Contains    Carrinho    timeout=15s
    Log To Console    Navegando para o carrinho.
    Capture Page Screenshot    filename=07_pagina_carrinho.png

# Seleciona a garantia estendida de 12 meses se o produto permitir, se não exibe na tela mensagem "Produto não permite estender a garantia"
Selecionar a garantia estendida
    ${existe}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//label[contains(., '12 Meses de Garantia Estendida Kabum')]
    IF    ${existe}
        Click Element    xpath=//label[contains(., '12 Meses de Garantia Estendida Kabum')]
        Log To Console   Garantia de 12 meses selecionada.
        Wait Until Element Is Not Visible    xpath=//*[contains(., 'Carregando')]    timeout=15s
        Capture Page Screenshot    filename=08_garantia_selecionada.png
    ELSE
        Log To Console   Produto não permite estender a garantia.
        Capture Page Screenshot    filename=08_garantia_nao_selecionada.png
    END

# Verifica se o produto correto está no carrinho
Verificar se o produto esta correto no carrinho
    Wait Until Page Contains    ${NOME_PRODUTO_PAGINA}    timeout=30s
    Log To Console    Produto encontrado no carrinho.
    Capture Page Screenshot    filename=09_verificacao_final_carrinho.png

# Fecha o navegador ao final do teste
Fechar Navegador
    Close Browser
