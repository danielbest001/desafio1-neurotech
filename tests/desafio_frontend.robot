*** Settings ***
Documentation     Suite de testes para o fluxo de compra no site da Kabum!.
Resource          ${EXECDIR}/resources/keywords.robot

*** Variables ***
${URL}              https://www.kabum.com.br
${NAVEGADOR}        Chrome
${TERMO_PESQUISA}   notebook
${CEP}              50780-010

*** Test Cases ***
Automatizar Fluxo de Compra no Kabum
    [Documentation]    Valida o fluxo completo desde a busca até a verificação do produto no carrinho.
    [Tags]             CenarioPrincipal

    Abrir o site da Kabum                       url=${URL}    navegador=${NAVEGADOR}
    Aceitar cookies se necessario
    Realizar a busca pelo produto               termo=${TERMO_PESQUISA}
    Selecionar o primeiro produto da lista
    Salvar o nome do produto selecionado
    Calcular e validar o frete                  cep=${CEP}
    Adicionar o produto ao carrinho
    Entrar no carrrinho
    Selecionar a garantia estendida
    Verificar se o produto esta correto no carrinho
    [Teardown]    Fechar Navegador